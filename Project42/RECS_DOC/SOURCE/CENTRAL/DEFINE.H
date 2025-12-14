// For board 188 ,2 flash & 2 srm last edit 03/03/2000
#define BACKSPACE 0x08
#define ENTER '\r'
#define ESC 0x1B
#define UP 0x18
#define DOWN 0x19
#define LEFT 0x1A
#define RIGHT 0x1B
#define TAB 0x09

#define TIMBUF 0x1FF8

#define START_UP        0x07FF0
#define BIOS_START      0x0FFF8
#define BIOS_SIZE       32              // KBYTE
#define UCS_32K         0x0F83C
#define UCS_64K         0x0F03C
#define LCS_08K         0x01FC
#define LCS_32K         0x07FC
#define LCS_64K         0x0FFC
#define RAM0_START      0x00000
#define RAM0_SIZE       32              // KBYTE
#define SEG_ROM0        0x0f800
#define SEG_RAM0        0x00000
#define START           0x00000
#define SETUP_CS        0x07e00
#define START_RAM       0x00200
#define DATAX           0x07e00
#define STACK           0x7800
#define TDELAY          0x0FFF

// Chip-Select Control Registers
#define UCS_REGS             0x0FFA0
#define LCS_REGS             0x0FFA2
#define PCS_BASE             0x0FFA4
#define MCS_BASE             0x0FFA6
#define MCS_SIZE             0x0FFA8

// Set interrupt number
#define _Divide0              0
#define _Single_Step          1
#define _NMI_Pin              2
#define _Breakpoint           3
#define _Overflow             4
#define _BOUND                5
#define _Unused               6
#define _ESCape               7
#define _Timer0               8
#define _Reserved             9
#define _DMA0                 10
#define _DMA1                 11
#define _INT0                 12
#define _INT1                 13
#define _INT2                 14
#define _INT3                 15
#define _80187                16
#define _Reserved2            17
#define _Timer1               18
#define _Timer2               19
#define _Serial0_RX           20
#define _Serial1_TX           21

// Port of Interrupt Control Unit
#define Int3_REGS            0x0FF3E
#define Int2_REGS            0x0FF3C
#define Int1_REGS            0x0FF3A
#define Int0_REGS            0x0FF38
#define DMA1_REGS            0x0FF36
#define DMA0_REGS            0x0FF34
#define TIMER_REGS           0x0FF32
#define Int_Status           0x0FF30
#define Request              0x0FF2E
#define In_Service           0x0FF2C
#define PRIMSK               0x0FF2A
#define Int_Masks            0x0FF28
#define POLL_Status          0x0FF26
#define POLL                 0x0FF24
#define _EOIx                0x0FF22

// Port of Register Timer
#define T2_Control           0x0FF66
#define T2_Compare_A         0x0FF62
#define T2_Count             0x0FF60
#define T1_Control           0x0FF5E
#define T1_Compare_B         0x0FF5C
#define T1_Compare_A         0x0FF5A
#define T1_Count             0x0FF58
#define T0_Control           0x0FF56
#define T0_Compare_B         0x0FF54
#define T0_Compare_A         0x0FF52
#define T0_Count             0x0FF50

// Address Register of LCD               ; PCS4
#define LCD_BASE             0x0e00
#define LCD_CODE             LCD_BASE+0
#define LCD_DATA             LCD_BASE+1

// Address of LED
#define LED_BASE             0x0C80           ; PCS1

// peripheral 0 - 6
#define PCS0 0x0c00
#define PCS1 0x0c80
#define PCS2 0x0d00
#define PCS3 0x0d80
#define PCS4 0x0e00
#define PCS5 0x0e80
#define PCS6 0x0f00

// memory chip select 0 - 3 
#define MCS0 0x08000             // ROM 1
#define MCS1 0x08800             // RAM 1
#define MCS2 0x09000
#define MCS3 0x09800
#define UCS 0x0f8000
#define LCS 0x00000

// define for UART #0
#define UART0_BASE 0x0c00
#define UART0_RBR UART0_BASE + 0
#define UART0_THR UART0_BASE + 0
#define UART0_IER UART0_BASE + 1
#define UART0_IIR UART0_BASE + 2
#define UART0_FCR UART0_BASE + 2
#define UART0_LCR UART0_BASE + 3
#define UART0_MCR UART0_BASE + 4
#define UART0_LSR UART0_BASE + 5
#define UART0_MSR UART0_BASE + 6
#define UART0_SCR UART0_BASE + 7
#define UART0_DLL UART0_BASE + 0
#define UART0_DLM UART0_BASE + 1
// define for UART # 1
#define UART1_BASE 0x0c80
#define UART1_RBR UART1_BASE + 0
#define UART1_THR UART1_BASE + 0
#define UART1_IER UART1_BASE + 1
#define UART1_IIR UART1_BASE + 2
#define UART1_FCR UART1_BASE + 2
#define UART1_LCR UART1_BASE + 3
#define UART1_MCR UART1_BASE + 4
#define UART1_LSR UART1_BASE + 5
#define UART1_MSR UART1_BASE + 6
#define UART1_SCR UART1_BASE + 7
#define UART1_DLL UART1_BASE + 0
#define UART1_DLM UART1_BASE + 1
// define for UART # 2
#define UART2_BASE 0x0d00
#define UART2_RBR UART2_BASE + 0
#define UART2_THR UART2_BASE + 0
#define UART2_IER UART2_BASE + 1
#define UART2_IIR UART2_BASE + 2
#define UART2_FCR UART2_BASE + 2
#define UART2_LCR UART2_BASE + 3
#define UART2_MCR UART2_BASE + 4
#define UART2_LSR UART2_BASE + 5
#define UART2_MSR UART2_BASE + 6
#define UART2_SCR UART2_BASE + 7
#define UART2_DLL UART2_BASE + 0
#define UART2_DLM UART2_BASE + 1
