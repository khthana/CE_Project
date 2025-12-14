//////////////////////////////////////////////////////////////////////////////////
// Project Name:   [ CDX Class Library - CDX.lib ]
// Source File:    [ CDXResource Implementation ]
// Author:         [ Danny Farley - danny@jags.co.uk ]
// Contributions:  [ Patrick Feuser - pat@das-netz.de ]
// Revision:       [ 1.5 ]
//////////////////////////////////////////////////////////////////////////////////
#include "CDX.h"
#include <fcntl.h>
#include <io.h>
#include <sys/stat.h>

#define BLOCK_SIZE 16384

//////////////////////////////////////////////////////////////////////////////////
// CDXResource Constructor
//////////////////////////////////////////////////////////////////////////////////
CDXResource::CDXResource(void)
{
	m_pFE = NULL;
	m_Infile = 0;
	m_Outfile = 0;
	m_nFiles = 0;
}

//////////////////////////////////////////////////////////////////////////////////
// CDXResource Destructor
//////////////////////////////////////////////////////////////////////////////////
CDXResource::~CDXResource(void)
{
	DeleteFile("CDX.TMP");
	if(m_Infile) close(m_Infile);
	if(m_Outfile) close(m_Outfile);
}

//////////////////////////////////////////////////////////////////////////////////
// CDXResource Open
//////////////////////////////////////////////////////////////////////////////////
BOOL CDXResource::Open(const char *Filename)
{
	int bytes;

	// Open the resource file
	m_Infile = open(Filename, O_RDONLY | O_BINARY);
	if(m_Infile < 1) return FALSE;

	// Read the number of files in the resource
	bytes = read(m_Infile, &m_nFiles, sizeof(int));
	if(bytes != sizeof(int))
	{
		Close();
		return FALSE;
	}

	// Make space for the file header
	m_pFE = new FILEENTRY[m_nFiles];
	if(m_pFE == NULL)
	{
		Close();
		return FALSE;
	}

	// Read the header file
	bytes = read(m_Infile, m_pFE, m_nFiles * sizeof(FILEENTRY));
	if(bytes != (int)(m_nFiles * sizeof(FILEENTRY)))
	{
		Close();
		return FALSE;
	}

	return TRUE;
}

//////////////////////////////////////////////////////////////////////////////////
// CDXResource Close
//////////////////////////////////////////////////////////////////////////////////
void CDXResource::Close(void)
{
	DeleteFile("CDX.TMP");
	if(m_Infile) close(m_Infile);
	if(m_Outfile) close(m_Outfile);
}

//////////////////////////////////////////////////////////////////////////////////
// CDXResource GetFile
//////////////////////////////////////////////////////////////////////////////////
char* CDXResource::GetFile(const char *Filename)
{
	char *buffer;

	DeleteFile("CDX.TMP");

	for(int i = 0; i < m_nFiles; i++)
	{
		if(strnicmp(Filename, m_pFE[i].name, 13) == 0) break;
	}

	long offset = m_pFE[i].offset;
	lseek(m_Infile, offset, SEEK_SET);

	m_Outfile = open("CDX.TMP", _O_WRONLY | O_CREAT | O_TRUNC | O_BINARY, S_IREAD | S_IWRITE);
	if(m_Outfile < 1) return NULL;

	int size = m_pFE[i+1].offset - offset;

	// Get space for the buffer
	buffer = new char[size];
	if(buffer == NULL) return NULL;

	read(m_Infile, buffer, size);
	write(m_Outfile, buffer, size);

	close(m_Outfile);

	return (char*)"CDX.TMP";
}
