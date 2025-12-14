PROJ = Browse
PROJFILE = d:\kpwinpp\samples\template.mak
OPTCPP = Browse.cpp BROWSEPL.cpp 
OPTOBJ = Browse.obj BROWSEPL.obj 
# TEMPLATE Makefile for KPWin++
# If you installed C++ and the SDK without modifying the PATH,
#    LIB, and INCLUDE environment variables, then remove
#    the # character from the next two statements and specify
#    the correct paths. 
# SYSTEM = c:\c700
# SDKSYSTEM = d:\sdk31
# Your path for the KPWin++ files should appear in the next line.
KPWINPP = d:\kpwinpp

KPCPP = $(KPWINPP)\kp.exe
CXX  = cl
CXXFLAGS_G  = /AL /W2 /G2 /GA /GEf /Zp /BATCH /Gy /Bm4096 /Gt16
CXXFLAGS_R  = /f- /Ox /Gs 
MAPFILE_R  = NUL
LFLAGS_G  = /BATCH /ONERROR:NOEXE
LFLAGS_R  = /NOF
LLIBS_G  = LIBW.LIB
LINKER  = link
LRF  = echo > NUL
RC  = rc
RCFLAGS = -k -t
LLIBS_R  = /NOD:LLIBCE LLIBCEW KPENGINE
KPCFLAGS = -nt\kpwinpp\samples\template.mak -bt 
DEF_FILE  = $(PROJ).DEF
OBJS  = $(OPTOBJ)
RESS  = $(KPWINPP)\resource\kpkbmain.res

all: setenv $(PROJ).exe

.SUFFIXES:
.SUFFIXES:
.SUFFIXES: .obj .cpp .res

$(OPTOBJ) : $(OPTCPP)
  @echo Compiling C++ code to EXE...
  @$(CXX) @<<$(PROJ).rsp
/c $(CXXFLAGS_G)
$(CXXFLAGS_R) $(OPTCPP) $(OPTOBJOUT)
<<

$(PROJ).cpp : $(PROJ).kb
  @echo.
  @echo Generating C++ code from $(PROJ).kb 
  $(KPCPP) $(KPCFLAGS) $(PROJ).kb $(PROJ).cpp > NUL
  @echo.

$(PROJ).exe : $(DEF_FILE) $(OBJS) 
  @echo Linking code...
	$(LRF) @<<$(PROJ).lrf
$(RT_OBJS: = +^
) $(OBJS: = +^
)
$@
$(MAPFILE_R)
$(LIBS: = +^
) +
$(LLIBS_G: = +^
) +
$(LLIBS_R: = +^
)
$(DEF_FILE) $(LFLAGS_G) $(LFLAGS_R);
<<
	$(LINKER) @$(PROJ).lrf
	del $(PROJ).lrf
	@$(RC) $(RCFLAGS) $(RESS) $@

.cpp.obj :
	@$(CXX) @<<$(PROJ).rsp
/c $(CXXFLAGS_G)
$(CXXFLAGS_R) /Fo$@ $<
<<

setenv:
  @echo off
!IFDEF SDKSYSTEM
  @set system=$(SYSTEM)\bin;$(SDKSYSTEM)\bin;
  @set init=$(SYSTEM)\init;
  @set include=$(SYSTEM)\include;$(SDKSYSTEM)\include;$(KPWINPP)\include;
  @set lib=$(SYSTEM)\lib;$(SDKSYSTEM)\lib;$(KPWINPP)\lib;
!ELSE
  @set include=%include%;$(KPWINPP)\include;
  @set lib=%lib%;$(KPWINPP)\lib;
!ENDIF