unit uDFPDeclares;

interface

const
  DFP_LIBRARY = '..\DFPUtils.dll';

function GetHarddiskDFP(DriveID: Byte; Serial: PChar; MaxLen: Integer): Integer; stdcall;
function GetMACAddress(MACAddr: PChar; MaxLen: Integer): Integer; stdcall;
function GetLogicalDiskDFP(DriveID: Char; LogicalDiskDFP: PChar; MaxLen: Integer): Integer; stdcall;
function GetProcessorDFP(ProcessorDFP: PChar; MaxLen: Integer): Integer; stdcall;

implementation

function GetHarddiskDFP(DriveID: Byte; Serial: PChar; MaxLen: Integer): Integer; stdcall;
                        external DFP_LIBRARY;
function GetMACAddress(MACAddr: PChar; MaxLen: Integer): Integer; stdcall;
                       external DFP_LIBRARY;
function GetLogicalDiskDFP(DriveID: Char; LogicalDiskDFP: PChar;
                           MaxLen: Integer): Integer; stdcall; external DFP_LIBRARY;
function GetProcessorDFP(ProcessorDFP: PChar; MaxLen: Integer): Integer; stdcall;
                         external DFP_LIBRARY;
end.
