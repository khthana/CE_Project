/* This file is to introduce this disk */

# About document
All documents are in file paper.zip which includes

           Filename		Meaning

1. cover_out 		ปกหน้า
2. cover_in		ปกใน
3. kitti			กิตติกรรมประกาศ
4. abstract		บทคัดย่อ
5. content			สารบัญ
6. table_content		สารบัญตาราง
7. picture_content		สารบัญรูปภาพ
8. chap1			บทที่ 1
9. chap2(OSI)		บทที่ 2 ส่วน OSI และ TCP/IP
10. chap2(ether)		บทที่ 2 ส่วน Ethernet
11. chap3			บทที่ 3
12. chap4			บทที่ 4
13. chap5			บทที่ 5
14. chap6			บทที่ 6
15. chap7			บทที่ 7
16. apdx A		ภาคผนวก ก
17. apdx B		ภาคผนวก ข
18. apdx C D		ภาคผนวก ค และ ง
19. apdx E			ภาคผนวก จ
20. reference		หนังสืออ้างอิง

and file "develop.doc" is software development manual.

All files above are refer to THESIS contents

# About source code

	Filename		Meaning

1. pkt.cpp			Example to capture packet and display result
			after you compile and then run it. It will generate
			"Frames.dmp" -- raw data
			"Field.sep" -- Field display specific to IP address 161.246.6.99
2. Pktdef.hpp		Header file in use with Pktdrvr.hpp
3. Pktdrvr.hpp		Header file in use with Pktdrvr.cpp, declare method prototype
4. Pktdrvr.cpp		Declare method of class PktDriver for interface with packet driver
5. filter.hpp		Header file in use with filter.cpp, declare method prototype
6. filter.cpp		Declare method of class packetFilter for filter captured packet
7. fields.hpp		Header file in use with fields.cpp, declare method prototype
8. fields.cpp		Declare method of class Fields for seperate packet into each fields
9. analyze.hpp		Header file in use with analyze.cpp, declare method prototype
10. analyze.cpp		Declare method of class packetAnalyze
11. nmutil.h		Header file for useful function
12. xms.h			Header file in use with xms.cpp
13. xms.cpp		Declare method of class XMS
14. xms.doc		Help file of XMS

# Before you can start capture packet you must power on your computer in Dos by press F8
while booting and select "Dos prompt only" and then install packet driver.

Following is example to install NE2000.com(packet driver)

	Ex : ne2000 0x60 11 0x6100

parameter #1 is Interrupt port
parameter #2 is IRQ number
parameter #3 is I/O address

The end.