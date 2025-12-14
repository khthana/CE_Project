@echo on
lib  lib\powrdevc.lib -+ obj\powrdevc.obj,  lib\powrdevc.lst;
lib  lib\powrvido.lib -+ obj\powrvido.obj,  lib\powrvido.lst;
lib  lib\powrstor.lib -+ obj\powrstor.obj,  lib\powrstor.lst;
lib  lib\powrvmem.lib -+ obj\vmkrnl.obj,    lib\powrvmem.lst;
lib  lib\powrvmem.lib -+ obj\vmheap.obj,    lib\powrvmem.lst;
lib  lib\powrvmem.lib -+ obj\vmarry1d.obj,  lib\powrvmem.lst;
lib  lib\powrvmem.lib -+ obj\vmarry3d.obj,  lib\powrvmem.lst;
