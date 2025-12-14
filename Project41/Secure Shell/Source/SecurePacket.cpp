// SecurePacket.cpp: implementation of the CSecurePacket class.
//
//////////////////////////////////////////////////////////////////////

#include "stdafx.h"
#include "SecureShell.h"
#include "SecurePacket.h"
#include "SecureMisc.h"

#ifdef _DEBUG
#undef THIS_FILE
static char THIS_FILE[]=__FILE__;
#define new DEBUG_NEW
#endif

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////
BOOL CSecurePacket::encryption = false;
CSecureCrypto* CSecurePacket::cryptoSend = new CSecureCrypto();
CSecureCrypto* CSecurePacket::cryptoRecv = new CSecureCrypto();

CSecurePacket::CSecurePacket()
{
		packet_length_array = new CByteArray();
		block = new CByteArray();
		padding = new CByteArray();
		data	= new CByteArray();
		crc_array = new CByteArray();
}

CSecurePacket::CSecurePacket(BYTE newtype,CByteArray* newdata)
{
	// Save Data and Type
	packet_type = newtype;
	data = newdata;

	// Set Packet Length
	packet_length_array = new CByteArray();
	packet_length_array->SetSize(4);

	if (data->GetSize() != 0) 
		packet_length = data->GetSize() + 5;
	else
		packet_length = 5;

	for (int i=0;i<4;i++)
		packet_length_array->SetAt(i,(BYTE) (packet_length >> ((3-i)*8) & 0xff));

	// Setpadding
	int padding_size = (8-(packet_length % 8));
	padding = new CByteArray();
	padding->SetSize(padding_size);
	if (!encryption) 
		for(i=0; i<padding_size;i++)
			padding->SetAt(i,0);
	else {
			for(i=0; i<padding_size;i++){
				padding->SetAt(i,CSecureMisc::getNotZeroRandomByte());
		}
	}

	//Compute the crc of [ Padding, Packet type, Data ]
	CByteArray* tempByte = new CByteArray();
	tempByte->Append(*padding);
	tempByte->Add(packet_type);
	tempByte->Append(*data);

	unsigned long crc = 0;
	crc = CSecureMisc::crc32(tempByte,tempByte->GetSize());

	crc_array = new CByteArray();
	crc_array->SetSize(4);
	crc_array->SetAt(3,(BYTE) (crc & 0xff));
	crc_array->SetAt(2,(BYTE) ((crc>>8) & 0xff));
	crc_array->SetAt(1,(BYTE) ((crc>>16) & 0xff));
	crc_array->SetAt(0,(BYTE) ((crc>>24) & 0xff));
	SetBlock();

// Set Block of Data for Transfer 
	if (encryption) block = cryptoSend->Encrypt(block);

		EncryptedBlock = block;

}

CSecurePacket::~CSecurePacket()
{

}

CSecurePacket* CSecurePacket::GetPacketFromBytes(CByteArray * buff)
{
		if (buff->GetSize() > 4) // enough for packet length
		{
			packet_length_array = new CByteArray();
			for (int i=0;i<4;i++)				// get length
				packet_length_array->Add(buff->GetAt(i));
			packet_length = (packet_length_array->GetAt(3)&0xff) +
							((packet_length_array->GetAt(2)&0xff)<<8) +
							((packet_length_array->GetAt(1)&0xff)<<16) +
							((packet_length_array->GetAt(0)&0xff)<<24);
			

			int lengthBlock = 8*(packet_length/8 +1);   // compute lenght get
			if (buff->GetSize() >= lengthBlock + 4)		// buffer get enough
			{
				block = new CByteArray();
				for (int i=0;i<4;i++)
					buff->RemoveAt(0);
				for (i=0;i<lengthBlock;i++)
				{
					block->Add(buff->GetAt(0));
					buff->RemoveAt(0);
				}
				if (encryption) block = cryptoRecv->Decrypt(block);
				DecryptedBlock = block;
				setPacketFromDecryptedBlock();
				if (!checkCrc()) {
					AfxMessageBox("Crc Error");
					return NULL;
				}
//				int help = buff->GetSize();
				return this;			
			} 
			else return NULL;  // data < length
				
		} 
		return NULL; // data not enough
}


void CSecurePacket::setPacketFromDecryptedBlock()
{
		int blockOffset = 0; 

		//padding
		int padding_length = (int) (8-(packet_length%8));
		padding = new CByteArray();
		padding->SetSize(padding_length);

		for (int i=0; i<padding->GetSize(); i++) padding->SetAt(i,DecryptedBlock->GetAt(blockOffset++));
	
		//packet type
		packet_type = DecryptedBlock->GetAt(blockOffset++);
				
		//data
		data = new CByteArray();
		if(packet_length > 5)  {
			data->SetSize(packet_length-5);
			for(int i=0; i<data->GetSize(); i++) data->SetAt(i,DecryptedBlock->GetAt(blockOffset++));
		}
		else data = NULL;
		
		//crc
		crc_array = new CByteArray();
		crc_array->SetSize(4);
		for (i=0; i<crc_array->GetSize(); i++) crc_array->SetAt(i,DecryptedBlock->GetAt(blockOffset++));

}

BOOL CSecurePacket::checkCrc()
{
	CByteArray* crc_arrayCheck = new CByteArray();
	crc_arrayCheck->SetSize(4);							// 32-bit crc
	unsigned long crcCheck;											// 32-bit crc

	crcCheck = CSecureMisc::crc32(DecryptedBlock, DecryptedBlock->GetSize()-4);
		crc_arrayCheck->SetAt(3,(BYTE) (crcCheck & 0xff));
		crc_arrayCheck->SetAt(2,(BYTE) ((crcCheck>>8) & 0xff));
		crc_arrayCheck->SetAt(1,(BYTE) ((crcCheck>>16) & 0xff));
		crc_arrayCheck->SetAt(0,(BYTE) ((crcCheck>>24) & 0xff));

		if	(crc_arrayCheck->GetAt(3) != crc_array->GetAt(3)) return false; 
		if	(crc_arrayCheck->GetAt(2) != crc_array->GetAt(2)) return false;
		if	(crc_arrayCheck->GetAt(1) != crc_array->GetAt(1)) return false;
		if	(crc_arrayCheck->GetAt(0) != crc_array->GetAt(0)) return false;
		return true;


}

void CSecurePacket::SetBlock()
{
	int offset = 0;
	block = new CByteArray();	
	
	block->Append(*padding);
	block->Add(packet_type);
	block->Append(*data);
	block->Append(*crc_array);

}

CByteArray* CSecurePacket::GetBytes()
{
/*	for (int i=0;i<packet_length_array->GetSize();i++)
		SendBytes->Add(packet_length_array->GetAt(i));
	for (i=0;i<EncryptedBlock->GetSize();i++)
		SendBytes->Add(EncryptedBlock->GetAt(i));
*/
	CByteArray *SendBytes = new CByteArray();
	SendBytes->Append(*packet_length_array);
	SendBytes->Append(*EncryptedBlock);
	return SendBytes;

}

BYTE CSecurePacket::GetType()
{
	return packet_type;
}

CByteArray* CSecurePacket::GetData()
{
	return data;
}
