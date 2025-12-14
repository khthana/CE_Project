unit CryptEMsg;

interface

uses Windows;

function CryptECodeToMsg(ECode: Longint): String;

implementation

function CryptECodeToMsg(ECode: Longint): String;
begin
  case ECode of
    // CryptAcquireContext GetLastError() return code.
    ERROR_INVALID_PARAMETER:    Result := 'ERROR_INVALID_PARAMETER';
    ERROR_NOT_ENOUGH_MEMORY:    Result := 'ERROR_NOT_ENOUGH_MEMORY';
    NTE_BAD_FLAGS:              Result := 'NTE_BAD_FLAGS';
    NTE_BAD_KEYSET:             Result := 'NTE_BAD_KEYSET';
    NTE_BAD_KEYSET_PARAM:       Result := 'NTE_BAD_KEYSET_PARAM';
    NTE_BAD_PROV_TYPE:          Result := 'NTE_BAD_PROV_TYPE';
    NTE_BAD_SIGNATURE:          Result := 'NTE_BAD_SIGNATURE';
    NTE_EXISTS:                 Result := 'NTE_EXISTS';
    NTE_KEYSET_ENTRY_BAD:       Result := 'NTE_KEYSET_ENTRY_BAD';
    NTE_KEYSET_NOT_DEF:         Result := 'NTE_KEYSET_NOT_DEF';
    NTE_NO_MEMORY:              Result := 'NTE_NO_MEMORY';
    NTE_PROV_DLL_NOT_FOUND:     Result := 'NTE_PROV_DLL_NOT_FOUND';
    NTE_PROV_TYPE_ENTRY_BAD:    Result := 'NTE_PROV_TYPE_ENTRY_BAD';
    NTE_PROV_TYPE_NO_MATCH:     Result := 'NTE_PROV_TYPE_NO_MATCH';
    NTE_PROV_TYPE_NOT_DEF:      Result := 'NTE_PROV_TYPE_NOT_DEF';
    NTE_PROVIDER_DLL_FAIL:      Result := 'NTE_PROVIDER_DLL_FAIL';
    NTE_SIGNATURE_FILE_BAD:     Result := 'NTE_SIGNATURE_FILE_BAD';

    // CryptCreateHash GetLastError() return code.
    ERROR_INVALID_HANDLE:       Result := 'ERROR_INVALID_HANDLE';
    NTE_BAD_KEY:                Result := 'NTE_BAD_KEY';

    // CryptDecrypt GetLastError() return code.
    NTE_BAD_ALGID:              Result := 'NTE_BAD_ALGID';
    NTE_BAD_DATA:               Result := 'NTE_BAD_DATA';
    NTE_BAD_HASH:               Result := 'NTE_BAD_HASH';
    NTE_BAD_LEN:                Result := 'NTE_BAD_LEN';
    NTE_BAD_UID:                Result := 'NTE_BAD_UID';
    NTE_DOUBLE_ENCRYPT:         Result := 'NTE_DOUBLE_ENCRYPT';
    NTE_FAIL:                   Result := 'NTE_FAIL';

    // CryptDestroyHash GetLastError() return code.
    ERROR_BUSY:                 Result := 'ERROR_BUSY';

    // CryptExportKey GetLastError() return code.
    NTE_BAD_KEY_STATE:          Result := 'NTE_BAD_KEY_STATE';
    NTE_BAD_PUBLIC_KEY:         Result := 'NTE_BAD_PUBLIC_KEY';
    NTE_BAD_TYPE:               Result := 'NTE_BAD_TYPE';
    NTE_NO_KEY:                 Result := 'NTE_NO_KEY';

    // CryptGetProvParam GetLastError() return code.
    ERROR_NO_MORE_ITEMS:        Result := 'ERROR_NO_MORE_ITEMS';

    // CryptHashData GetLastError() return code.
    NTE_BAD_HASH_STATE:         Result := 'NTE_BAD_HASH_STATE';

    // CryptImportKey GetLastError() return code.
    NTE_BAD_VER:                Result := 'NTE_BAD_VER';

  else
    Result := 'Unknown this error code!!!';
  end;
end;

end.
