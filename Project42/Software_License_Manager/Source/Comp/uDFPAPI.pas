unit uDFPAPI;

interface

uses Windows, SysUtils;

function GetHarddiskDFP(DriveID: Byte; HarddiskDFP: PChar; MaxLen: Integer): Integer; stdcall;
function GetMACAddress(MACAddr: PChar; MaxLen: Integer): Integer; stdcall;
function GetLogicalDiskDFP(DriveID: Char; LogicalDiskDFP: PChar; MaxLen: Integer): Integer; stdcall;
function GetProcessorDFP(ProcessorDFP: PChar; MaxLen: Integer): Integer; stdcall;

implementation

uses Smart;

//---------------------------------------------------------------------
// Open SMART to allow DeviceIoControl communications.
//---------------------------------------------------------------------
function OpenSMART(var hSMARTIOCTL: THandle; DriveID: Byte): Boolean;
begin
  hSMARTIOCTL := 0;

  if GetVersion >= $80000000 then
  begin
    // Version Windows 95 OSR2, Windows 98
    hSMARTIOCTL := CreateFile('\\.\SMARTVSD', 0, 0, nil, CREATE_NEW, 0, 0);
  end
  else begin
    // Windows NT, Windows 2000
    hSMARTIOCTL := CreateFile(PChar('\\.\PhysicalDrive' + IntToStr(DriveID)), GENERIC_READ or GENERIC_WRITE,
                              FILE_SHARE_READ or FILE_SHARE_WRITE, nil, OPEN_EXISTING, 0, 0);
  end;

  // Return Status of OpenSMART() function.
  if hSMARTIOCTL = INVALID_HANDLE_VALUE then
    Result := False
  else
    Result := True;
end;

procedure ChangeByteOrder(WordChar: PChar; Len: Integer);
var
  i: Integer;
  temp: Char;
begin
  i := 0;
  while i < Len - 1 do
  begin
    temp := WordChar[i];
    WordChar[i] := WordChar[i + 1];
    WordChar[i + 1] := temp;
    i := i + 2;
  end;
end;

(****************************************************************************
*
* DoIdentify
*
* FUNCTION: Send an IDENTIFY command to the drive
* bDriveNum = 0-3
* bIDCmd = IDE_ID_FUNCTION or IDE_ATAPI_ID
*
****************************************************************************)
function DoIdentify(hSMARTIOCTL: THandle; pSCIP: PSendCmdInParams; pSCOP: PSendCmdOutParams;
                    bIDCmd, bDriveNum: Byte; var cbBytesReturned: Longint): Boolean;
var
  IDSector: PIDSector;
begin
  //
  // Set up data structures for IDENTIFY command.
  //
  with pSCIP^ do
  begin
    cBufferSize := IDENTIFY_BUFFER_SIZE;
    irDriveRegs.bFeaturesReg := 0;
    irDriveRegs.bSectorCountReg := 1;
    irDriveRegs.bSectorNumberReg := 1;
    irDriveRegs.bCylLowReg := 0;
    irDriveRegs.bCylHighReg := 0;
    //
    // Compute the drive number.
    //
    irDriveRegs.bDriveHeadReg := $A0 or ((bDriveNum and 1) shl 4);
    //
    // The command can either be IDE identify or ATAPI identify.
    //
    irDriveRegs.bCommandReg := bIDCmd;
    bDriveNumber := bDriveNum;
  end;
  Result := DeviceIoControl(hSMARTIOCTL, DFP_RECEIVE_DRIVE_DATA,
                            pSCIP, SizeOf(TSendCmdInParams) - 1, pSCOP,
                            SizeOf(TSendCmdOutParams) + IDENTIFY_BUFFER_SIZE - 1,
               	            DWORD(cbBytesReturned), nil);
  if Result then
  begin
    IDSector := @pSCOP^.bBuffer;
    with IDSector^ do
    begin
      ChangeByteOrder(@sModelNumber, SizeOf(sModelNumber));
      ChangeByteOrder(@sSerialNumber, SizeOf(sSerialNumber));
      ChangeByteOrder(@sFirmwareRev, SizeOf(sFirmwareRev));
    end;
  end;
end;

function GetHarddiskDFP(DriveID: Byte; HarddiskDFP: PChar; MaxLen: Integer): Integer;
var
  NumBytesReturned: Longint;
  hSMARTIOCTL: THandle;
  DFP: string;
  pscip: PSendCmdInParams;
  pscop: PSendCmdOutParams;
  IDSector: PIDSector;
begin
  if not OpenSMART(hSMARTIOCTL, DriveID) then
  begin
    Result := -1;
    Exit;
  end;

  pscip := AllocMem(SizeOf(TSendCmdInParams) - 1);
  pscop := AllocMem(SizeOf(TSendCmdOutParams) + IDENTIFY_BUFFER_SIZE - 1);

  DoIdentify(hSMARTIOCTL, pscip, pscop, IDE_ID_FUNCTION, DriveID, NumBytesReturned);

  IDSector := @pscop^.bBuffer;
  with IDSector^ do
  begin
    DFP := sModelNumber + '/' + sSerialNumber + '/' + sFirmwareRev;
  end;
  Result := Length(DFP);
  if (HarddiskDFP <> nil) and (MaxLen > Result) then
  begin
    FillChar(HarddiskDFP^, MaxLen, 0);
    StrPLCopy(HarddiskDFP, DFP, Result);
  end
  else begin
    Result := -1;
  end;

  FreeMem(pscip);
  FreeMem(pscop);
  CloseHandle(hSMARTIOCTL);
end;

function CoCreateGuid(var guid: TGUID): HResult; stdcall;far external 'ole32.dll';

function GetMACAddress(MACAddr: PChar; MaxLen: Integer): Integer;
var
   g: TGUID;
   i: Byte;
   MAC: string;
begin
  CoCreateGUID(g);
  for i := 2 to 7 do
    MAC := MAC + IntToHex(g.D4[i], 2);
  Result := Length(MAC);
  if (MACAddr <> nil) and (MaxLen > Result) then
  begin
    FillChar(MACAddr^, MaxLen, 0);
    StrPLCopy(MACAddr, MAC, Result);
  end
  else begin
    Result := -1;
  end;
end;

function GetLogicalDiskDFP(DriveID: Char; LogicalDiskDFP: PChar; MaxLen: Integer): Integer;
var
   VolumeSerialNumber : DWORD;
   MaximumComponentLength : DWORD;
   FileSystemFlags : DWORD;
   DiskDFP: string;
begin
  try
    GetVolumeInformation(PChar(DriveID + ':\'), nil, 0, @VolumeSerialNumber,
                         MaximumComponentLength, FileSystemFlags, nil, 0);
    DiskDFP := IntToHex(HiWord(VolumeSerialNumber), 4) + '-' +
                        IntToHex(LoWord(VolumeSerialNumber), 4);
  except

  end;
  Result := Length(DiskDFP);
  if (LogicalDiskDFP <> nil) and (MaxLen > Result) then
  begin
    FillChar(LogicalDiskDFP^, MaxLen, 0);
    StrPLCopy(LogicalDiskDFP, DiskDFP, Result);
  end
  else begin
    Result := -1;
  end;
end;

function GetPSN(var PSN2, PSN1, PSN0: LongWord): Boolean;
asm
  MOV    EAX, 01H
  DB     0FH, 0A2H     // CPUID Instruction opcode.
  AND    EDX, 40000H   // Check PSN feature flag on bit 18 of EDX.
  JNZ    @PSN_Enabled

  MOV    Result, False
  JMP    @End

@PSN_Enabled:
  MOV    PSN2, EAX    // Save 32 most significant bits of PSN.

  MOV    EAX, 03H     // Get remain 64 bits of PSN.
  DB     0FH          // CPUID Instruction opcode.
  DB     0A2H
  MOV    PSN1, EDX    // Save 32 middle significant bits of PSN.
  MOV    PSN0, ECX    // Save 32 least significant bits of PSN.
  MOV    Result, True

@End:
end;

function GetProcessorDFP(ProcessorDFP: PChar; MaxLen: Integer): Integer;
var
  PSN2, PSN1, PSN0: LongWord;
  PSN: string;
begin
  if GetPSN(PSN2, PSN1, PSN0) then
  begin
    PSN := IntToHex(HiWord(PSN2), 4);
    PSN := PSN + '-' + IntToHex(LoWord(PSN2), 4);
    PSN := PSN + '-' + IntToHex(HiWord(PSN1), 4);
    PSN := PSN + '-' + IntToHex(LoWord(PSN1), 4);
    PSN := PSN + '-' + IntToHex(HiWord(PSN0), 4);
    PSN := PSN + '-' + IntToHex(LoWord(PSN0), 4);
    Result := Length(PSN);
    if (ProcessorDFP <> nil) and (MaxLen > Result) then
    begin
      FillChar(ProcessorDFP^, MaxLen, 0);
      StrPLCopy(ProcessorDFP, PSN, Result);
    end
    else begin
      Result := -1;
    end;
  end
  else begin
    Result := -1;
  end;
end;

end.
