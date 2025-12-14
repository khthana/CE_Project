# Make file for KnowledgePro (Windows) DLLs

CFLAGS = -Asnw -c -D LINT_ARGS -Gsw -Ox -W2 -Zip 
ASMFLAGS = -ZI
C6LIBS = sdllcew libw slibcew

all : kpuser.dll

libentry.obj : libentry.asm
   masm $(ASMFLAGS) libentry.asm;

wep.obj : wep.c 
   echo wep.c >con
   cl $(CFLAGS) wep.c

kputil.obj : kputil.c kpdefs.h 
   echo kputil.c >con
   cl $(CFLAGS) kputil.c

kpuser.obj : kpuser.c kputil.h 
   echo kpuser.c >con
   cl $(CFLAGS) kpuser.c

# The SDK 3.0 requires all of these steps to complete DLL creation
kpuser.dll: kpuser.obj libentry.obj wep.obj kputil.obj kpuser.def kpuser.mak
    echo linking >con
    link libentry wep kputil kpuser, kpuser.dll/align:16/co, kpuser.map/li/map, $(C6LIBS)/NOE/NOD, kpuser.def
    mapsym kpuser.map
    implib kpuser.lib kpuser.def
    rc kpuser.dll

