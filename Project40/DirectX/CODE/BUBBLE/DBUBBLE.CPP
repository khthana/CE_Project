#include "control.h"
#include "bb_local.h"

void cursor_on()
{
	unsigned int Vport = peek(0x0040,0x0063);
	unsigned int CursorMode = peek(0x0040,0x0060);

	outportb(Vport, 10);
	outportb(Vport+1, CursorMode>>8 & 0xDF);
	outportb(Vport, 11);
	outportb(Vport+1, CursorMode);
}

void cursor_off()
{
	unsigned int Vport = peek(0x0040,0x0063);
	unsigned int CursorMode = peek(0x0040,0x0060);

	outportb(Vport, 10);
	outportb(Vport+1, CursorMode>>8 | 0x20);
	outportb(Vport, 11);
	outportb(Vport+1, CursorMode);
}

int main(int argc, char *argv[])
{
	CBubbleLocal local;

	unsigned char key;

	clrscr();
	cursor_off();

//////////////////////////////////
	CBubbleLocal l;

	if( (argc > 1)&&(!strcmp(argv[1],"/2")) )
		local.start(EP_2ONE);
	else
		local.start(EP_ONE);


	while( local.get_status() == EL_RUNNING )
	{
		poke(0x0040,0x001A,peek(0x0040,0x001C));

		volatile key = inportb(0x60);
		if( key < 0x80 )
			local.key_press(key);
		else
			local.key_release(key-0x80);

		local.tick();
	}
//////////////////////////////////

	cursor_on();
	return 0;
}
