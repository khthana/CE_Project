(****************************************************************************
*
* PROGRAM: SMART.PAS
*
* PURPOSE: Structure definitions for an application that calls SMART Ioctls
*          Using Delphi 5.0
*
* TRANSLATOR: By Mr. Suriyan Laohaprapanon.
*
* REVISION: 1. 1 March, 2000.
*
****************************************************************************)

(****************************************************************************
*                                                                           *
* THIS CODE AND INFORMATION IS PROVIDED "AS IS" WITHOUT WARRANTY OF ANY     *
* KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE       *
* IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A PARTICULAR     *
* PURPOSE.                                                                  *
*                                                                           *
* Copyright 1993-98  Microsoft Corporation.  All Rights Reserved.           *
*                                                                           *
****************************************************************************)

(****************************************************************************
*
* PROGRAM: SMART.H
*
* PURPOSE: Structure definitions for an application that calls SMART Ioctls
*
****************************************************************************)

unit Smart;

interface

// Miscellaneous

const
  MAX_IDE_DRIVES	        = 4;   // Max number of drives assuming primary/secondary, master/slave topology
  READ_ATTRIBUTE_BUFFER_SIZE	= 512;
  IDENTIFY_BUFFER_SIZE		= 512;
  READ_THRESHOLD_BUFFER_SIZE	= 512;

//
// IOCTL commands
//
  DFP_GET_VERSION	        = $00074080;
  DFP_SEND_DRIVE_COMMAND	= $0007c084;
  DFP_RECEIVE_DRIVE_DATA	= $0007c088;

//---------------------------------------------------------------------
// GETVERSIONOUTPARAMS contains the data returned from the
// Get Driver Version function.
//---------------------------------------------------------------------
type
  PGetVersionOutParams = ^TGetVersionOutParams;
  LPGetVersionOutParams = ^TGetVersionOutParams;
  TGetVersionOutParams = packed record
                           bVersion: Byte;		       // Binary driver version.
                           bRevision: Byte;	               // Binary driver revision.
                           bReserved: Byte;	               // Not used.
                           bIDEDeviceMap: Byte;	               // Bit map of IDE devices.
                           fCapabilities: LongWord;            // Bit mask of driver capabilities.
                           dwReserved: array[1..3] of LongWord;// For future use.
                         end;

//
// Bits returned in the fCapabilities member of GETVERSIONOUTPARAMS
//
const
  CAP_IDE_ID_FUNCTION		        = 1;	// ATA ID command supported
  CAP_IDE_ATAPI_ID			= 2;	// ATAPI ID command supported
  CAP_IDE_EXECUTE_SMART_FUNCTION	= 4;	// SMART commannds supported

//---------------------------------------------------------------------
// IDE registers
//---------------------------------------------------------------------
type
  PIDERegs = ^TIDERegs;
  LPIDERegs = ^TIDERegs;
  TIDERegs = packed record
               bFeaturesReg: Byte;     // Used for specifying DFP "sub commands".
               bSectorCountReg: Byte;  // IDE sector count register
               bSectorNumberReg: Byte; // IDE sector number register
               bCylLowReg: Byte;       // IDE low order cylinder value
               bCylHighReg: Byte;      // IDE high order cylinder value
               bDriveHeadReg: Byte;    // IDE drive/head register
               bCommandReg: Byte;      // Actual IDE command. Checked for validity by driver.
               bReserved: Byte;	       // Reserved for future use. Must be zero.
             end;

//---------------------------------------------------------------------
// SENDCMDINPARAMS contains the input parameters for the
// Send Command to Drive function.
//---------------------------------------------------------------------
  PSendCmdInParams = ^TSendCmdInParams;
  LPSendCmdInParams = ^TSendCmdInParams;
  TSendCmdInParams = packed record
                       cBufferSize: LongWord;		    // Size of bBuffer in bytes
                       irDriveRegs: TIDERegs;		    // Structure with drive register values
                       bDriveNumber: Byte;		    // Physical drive number to send command to (0,1,2,3)
                       bReserved: array[1..3] of Byte;	    // Reserved for future expansion
                       dwReserved: array[1..4] of LongWord; // Reserved for future expansion
                       bBuffer: array[1..1] of Byte;        // Buffer of arbitrary length in which to store the data
							    // to be written to drive.
                     end;

//
// Valid values for the bCommandReg member of IDEREGS.
//
const
  IDE_ATAPI_ID		        = $A1;	// Returns ID sector for ATAPI.
  IDE_ID_FUNCTION		= $EC;	// Returns ID sector for ATA.
  IDE_EXECUTE_SMART_FUNCTION	= $B0;	// Performs SMART cmd.
                                        // bCylLowReg, and bCylHighReg

//
// Cylinder register values required when issuing SMART command
//
  SMART_CYL_LOW	= $4F;
  SMART_CYL_HI	= $C2;

//---------------------------------------------------------------------
// Status returned from driver
//---------------------------------------------------------------------
type
  PDriverStatus = ^TDriverStatus;
  LPDriverStatus = ^TDriverStatus;
  TDriverStatus = packed record
                    bDriverError: Byte;		         // Error code from driver, or 0 if no error
                    bIDEStatus: Byte;		         // Contents of IDE error register
                    bReserved: array[1..2] of Byte;      // Reserved for future expansion
                    dwReserved: array[1..2] of LongWord; // Reserved for future expansion
                  end;

//
// bDriverError values
//
const
  SMART_NO_ERROR	    = 0;    // No error
  SMART_IDE_ERROR	    = 1;    // Error from IDE controller
  SMART_INVALID_FLAG	    = 2;    // Invalid command flag
  SMART_INVALID_COMMAND	    = 3;    // Invalid command byte
  SMART_INVALID_BUFFER	    = 4;    // Bad buffer (null, invalid addr..)
  SMART_INVALID_DRIVE	    = 5;    // Drive number not valid
  SMART_INVALID_IOCTL	    = 6;    // Invalid IOCTL
  SMART_ERROR_NO_MEM	    = 7;    // Could not lock user's buffer
  SMART_INVALID_REGISTER    = 8;    // Some IDE Register not valid
  SMART_NOT_SUPPORTED	    = 9;    // Invalid cmd flag set
  SMART_NO_IDE_DEVICE	    = 10;   // Cmd issued to device not present
                                    // although drive number is valid
  // 11-255 reserved

//---------------------------------------------------------------------
// Structure returned by SMART IOCTL for several commands
//---------------------------------------------------------------------
type
  PSendCmdOutParams = ^TSendCmdOutParams;
  LPSendCmdOutParams = ^TSendCmdOutParams;
  TSendCmdOutParams = packed record
                        cBufferSize: LongWord;	      // Size of bBuffer in bytes
                        DriverStatus: TDriverStatus;  // Driver status structure
                        bBuffer: array[1..1] of Byte;// Buffer of arbitrary length in which to store the data
						      // read from the drive
                      end;

//---------------------------------------------------------------------
// Feature register defines for SMART "sub commands"
//---------------------------------------------------------------------
const
  SMART_READ_ATTRIBUTE_VALUES		   = $D0;	// ATA4: Renamed
                                                        // SMART READ DATA
  SMART_READ_ATTRIBUTE_THRESHOLDS	   = $D1;	// Obsoleted in ATA4!
  SMART_ENABLE_DISABLE_ATTRIBUTE_AUTOSAVE  = $D2;
  SMART_SAVE_ATTRIBUTE_VALUES		   = $D3;
  SMART_EXECUTE_OFFLINE_IMMEDIATE	   = $D4;	// ATA4
  // Vendor specific commands:
  SMART_ENABLE_SMART_OPERATIONS		   = $D8;
  SMART_DISABLE_SMART_OPERATIONS	   = $D9;
  SMART_RETURN_SMART_STATUS		   = $DA;

//---------------------------------------------------------------------
// The following structure defines the structure of a Drive Attribute
//---------------------------------------------------------------------
type
  PDriveAttribute = ^TDriveAttribute;
  LPDriveAttribute = ^TDriveAttribute;
  TDriveAttribute = packed record
                      bAttrID: Byte;		        // Identifies which attribute
                      wStatusFlags: Word;	        // see bit definitions below
                      bAttrValue: Byte;		        // Current normalized value
                      bWorstValue: Byte;	        // How bad has it ever been?
                      bRawValue: array[1..6] of Byte;	// Un-normalized value
                      bReserved: Byte;		        // ...
                    end;


//---------------------------------------------------------------------
// The following structure defines the structure of a Warranty Threshold
// Obsoleted in ATA4!
//---------------------------------------------------------------------
  PAttrThreshold = ^TAttrThreshold;
  LPAttrThreshold = ^TAttrThreshold;
  TAttrThreshold = packed record
                     bAttrID: Byte;		      // Identifies which attribute
                     bWarrantyThreshold: Byte;	      // Triggering value
                     bReserved: array[1..10] of Byte; // ...
                   end;

//---------------------------------------------------------------------
// The following struct defines the interesting part of the IDENTIFY
// buffer:
//---------------------------------------------------------------------
  PIDSector = ^TIDSector;
  TIDSector = packed record
        	wGenConfig: Word;
        	wNumCyls: Word;
        	wReserved: Word;
        	wNumHeads: Word;
        	wBytesPerTrack: Word;
        	wBytesPerSector: Word;
        	wSectorsPerTrack: Word;
        	wVendorUnique: array[1..3] of Word;
        	sSerialNumber: array[1..20] of Char;
        	wBufferType: Word;
        	wBufferSize: Word;
        	wECCSize: Word;
        	sFirmwareRev: array[1..8] of Char;
        	sModelNumber: array[1..40] of Char;
        	wMoreVendorUnique: Word;
        	wDoubleWordIO: Word;
        	wCapabilities: Word;
        	wReserved1: Word;
        	wPIOTiming: Word;
        	wDMATiming: Word;
        	wBS: Word;
        	wNumCurrentCyls: Word;
        	wNumCurrentHeads: Word;
        	wNumCurrentSectorsPerTrack: Word;
        	ulCurrentSectorCapacity: LongWord;
        	wMultSectorStuff: Word;
        	ulTotalAddressableSectors: LongWord;
        	wSingleWordDMA: Word;
        	wMultiWordDMA: Word;
        	bReserved: array[1..128] of Byte;
              end;

//---------------------------------------------------------------------
// Valid Attribute IDs
//---------------------------------------------------------------------
const
  ATTR_INVALID		         = 0;
  ATTR_READ_ERROR_RATE	         = 1;
  ATTR_THROUGHPUT_PERF	         = 2;
  ATTR_SPIN_UP_TIME	         = 3;
  ATTR_START_STOP_COUNT	         = 4;
  ATTR_REALLOC_SECTOR_COUNT      = 5;
  ATTR_READ_CHANNEL_MARGIN       = 6;
  ATTR_SEEK_ERROR_RATE	         = 7;
  ATTR_SEEK_TIME_PERF	         = 8;
  ATTR_POWER_ON_HRS_COUNT        = 9;
  ATTR_SPIN_RETRY_COUNT	         = 10;
  ATTR_CALIBRATION_RETRY_COUNT   = 11;
  ATTR_POWER_CYCLE_COUNT         = 12;

//---------------------------------------------------------------------
// Status Flags Values
//---------------------------------------------------------------------
  PRE_FAILURE_WARRANTY		 = $1;
  ON_LINE_COLLECTION		 = $2;
  PERFORMANCE_ATTRIBUTE		 = $4;
  ERROR_RATE_ATTRIBUTE		 = $8;
  EVENT_COUNT_ATTRIBUTE		 = $10;
  SELF_PRESERVING_ATTRIBUTE	 = $20;
  NUM_ATTRIBUTE_STRUCTS		 = 30;

implementation

end.
