/* WEP.C
	These are routines necessary to create DLLs for Windows 3.0 */

#include <windows.h>

int FAR PASCAL LibMain (HANDLE hInstance, WORD wDataSeg, WORD cbHeapSize, LPSTR lpszCmdLine)
{
	/* Perform DLL initialization here! */

	/* If DLL data seg is MOVEABLE */
	if (cbHeapSize != 0)
		UnlockData (0);

	return (1); /* successful installation, otherwise return (0); */
}

int FAR PASCAL WEP (int nParameter)
{
	if (nParameter == WEP_SYSTEM_EXIT)
	{
		/* System shutdown in progress. Respond accordingly! */
		return (1);
	}
	else
	{
		if (nParameter == WEP_FREE_DLL)
		{
			/* DLL use count is 0. Every application that had loaded the DLL
				has freed it. */
			return (1);
		}
		else
		{
			/* Undefined value - ignore */
			return (1);
		}
	}
}
