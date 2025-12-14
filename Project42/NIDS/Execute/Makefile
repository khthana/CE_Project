OBJECTS= rmonit.o IPCheck.o Sniff.o Fragment.o Analys1.o Analys2.o HostCheck.o BombCheck.o

EXEC= isagnid
CC=cc
INSTALLDIR=/usr/local/bin
LOGDIR=/var/log
INSTALL=/usr/bin/ginstall -c
MANDIR=/usr/local/man

all:	${EXEC}
clean: 
	rm -f ${OBJECTS} ${EXEC}


install:	all
	$(INSTALL) -d $(LOGDIR)/$(EXEC)
	$(INSTALL) -d $(INSTALLDIR)
	$(INSTALL) -d $(MANDIR)
	$(INSTALL) -d $(MANDIR)/man1
	$(INSTALL) -m 755 $(EXEC) $(INSTALLDIR)/$(EXEC)
	$(INSTALL) -m 644 $(EXEC).1 $(MANDIR)/man1/$(EXEC).1
	$(INSTALL) -m 644 $(EXEC).host /etc/$(EXEC).host

uninstall: 
	rm -f $(INSTALLDIR)/$(EXEC)
	rm -f $(MANDIR)/man1/$(EXEC).1
	rm -f /etc/$(EXEC).host

isagnid:	${OBJECTS}
	${CC} -o ${EXEC} ${OBJECTS}
       
rmonit.o : rmonit.c rmonit.h
IPCheck.o : IPCheck.c IPCheck.h
Sniff.o : Sniff.c Sniff.h  
Fragment.o :  Fragment.c Fragment.h  
Analys1.o : Analys1.c Analys1.h rmonit.h
Analys2.o : Analys2.c Analys2.h Fragment.h
HostCheck.o : HostCheck.c HostCheck.h rmonit.h
BombCheck.o : BombCheck.c BombCheck.h rmonit.h
