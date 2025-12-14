@echo off
@echo KPWin++ Copyright (c) 1992 Knowledge Garden, Inc. 
@echo Version 1.00
@echo Generating C++ code from %1.kb 
d:\kpwinpp\kp.exe -ntd:\kpwinpp\samples\template.mak -bt %1.kb %1.cpp > NUL
@echo Compiling C++ code to EXE...
d:\kpwinpp\kpwinpp.exe %1.mak