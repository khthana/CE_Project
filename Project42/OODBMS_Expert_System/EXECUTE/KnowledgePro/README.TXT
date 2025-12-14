                          Release Notes 
                               for 
                     KnowledgePro Windows 2.2
                   KnowledgePro Windows Gold 2.2

Contents:

 * Installation
 * KnowledgePro Options
 * Differences from Version 1.1
 * Differences from Version 2.0
 * Differences from Version 2.11
 * Known bugs
 * Runtime Policy
 * Questions you may have

============================================================================
                           Installation
============================================================================

The KnowledgePro Windows Install utility is a Windows program.
To begin the installation, first start Microsoft Windows. From 
within Program Manager or File Manager, select File, Run and type:

            A:INSTALL (or B:INSTALL if installing from drive B:)

to setup your copy of KPWin. You can also click on INSTALL.EXE
from File Manager.

Changes will be made to your WIN.INI file unless you specify
otherwise in the installation options. If you decide to not allow the
installation to make changes to the WIN.INI, add the following items
to your Windows initialization file:

Remember to restart Windows to make these changes effective.

* Under the heading [extensions]:

        KB=kppath\KPWIN.EXE ^.KB
        CKB=kppath\KPWIN.EXE ^.CKB

   This tells Windows to load KnowledgePro whenever the user runs
   a file with either a .KB or a .CKB file suffix.

   For KnowledgePro Gold use the following entries:

        KB=kppath\KPWING.EXE ^.KB
        CKB=kppath\KPWING.EXE ^.CKB

* A section must be created for KnowledgePro:

        [KnowledgePro] 

  For KnowledgePro Gold use the following:

        [KnowledgePro Gold]

* Add an entry, under the [KnowledgePro] section for the help system:

        HELPFILE=path\KPHELP.CKB

* Add the following entry, under the [KnowledgePro] or
  [KnowledgePro Gold] section:

        Optimize=T

* To make the Development Tools appear on the KnowledgePro menu, 
  add the following entries under the [KnowledgePro] section:

        TOOL1=['Calendar', 'calendar.ckb', ''].
        TOOL2=['Clock', 'clock.ckb', ''].
        TOOL3=['Color Selector', 'palette.ckb', ''].
        TOOL4=['Control Panel', 'ctrlpnl.ckb', ''].
        TOOL5=['Custom Color Designer', 'color.ckb', ''].
        TOOL6=['Font Designer', 'font.ckb', ''].
        TOOL7=['Font List', 'fontprn.ckb', ''].
        TOOL8=['Index', 'index.ckb', ''].
        TOOL9=['Keyboard Event Display', 'chartest.ckb', ''].
        TOOL10=['Library Browser', 'browse.ckb', ''].
        TOOL11=['Paintbrush', 'pbrush.ckb', ''].
        TOOL12=['KPWin Designer', 'design.ckb', ''].

More WIN.INI items are described in this file. See "KnowledgePro Options".

============================================================================
                         KnowledgePro Options
============================================================================

The [KnowledgePro] or [KnowledgePro Gold] section of the WIN.INI file 
contains parameters used to initialize the KPWIN environment. You can 
change any of the settings in the WIN.INI file with the KPWIN editor 
or NOTEPAD, but any changes made in this way will not take effect 
until Windows is restarted.  

Each line in the [KnowledgePro] or [KnowledgePro Gold] section has the format:
 
key=value 
 
You can include comments in WIN.INI. You must begin each line of comments 
with a semicolon (;). 
 
KnowledgePro accepts the following keys: 
 
------------------------------------------------------------ 
AboutFile=file name 
Default=none 
 
Purpose: This setting can be used to specify the name of a KPWIN application 
which can be called when "About KnowledgePro..." is chosen from the Help menu. 
The normal KPWIN dialog box is called and then file name is executed. 
------------------------------------------------------------ 
AllocationSize=integer 
Default=8 
 
Purpose: This option controls the size of the default memory allocation size 
in Kbytes. KnowledgePro normally allocates memory in 8K blocks. Increasing this 
size may reduce the amount of garbage collection slightly at the cost of making 
it more difficult for Windows to manage memory blocks. 
------------------------------------------------------------ 
Backup=<T or F> 
Default: F 
 
Purpose: If this setting is enabled, KnowledgePro will create a file with the 
extension .BAK containing the old contents of the edit file before saving a file 
from the KPWIN environment editor. 
 
To change: Select Create Backups from the Options menu. 
------------------------------------------------------------ 
Debug=<T or F> 
Default: F 
 
Purpose: If this setting is enabled, KnowledgePro will enable certain debugging 
options. This option should only be used by system developers who need system 
level debugging capablity. Enabling this option allows !! topics to be viewed 
with the debugger and memory allocation messages displayed on a secondary monitor. 
------------------------------------------------------------ 
DDE=<T or F> 
Default: T 
 
Purpose: If this setting is enabled, KnowledgePro will respond to DDE request 
from other applications as a server. 
 
To change: Select Remote Requests from the Options menu. 
------------------------------------------------------------ 
EditFont=FontDescription 
Default: none 
 
Purpose: This option can be used to install a new font for the KPWIN environment 
editor. FontDescription has the same format as the font_description in the 
create_char_font command. For example, 
 
EditFont=['-0.8125', 0, 400, f, f, f, 0, 1, 1, System].  
 
will install a fixed spaced system font as the edit window font. 
This setting will not effect edit windows created under application 
control. 
------------------------------------------------------------ 
HelpFile=file name 
Default: kphelp 
 
Purpose: This setting defines the applicaion which will be called when an option 
is chosen from the Help menu. 
------------------------------------------------------------ 
MsgQueueSize=integer 
Default: 16 
 
Purpose: This setting defines the size of the KPWIN message queue. It may be 
increased if KPWIN is losing events or DDE messages. 
------------------------------------------------------------ 
Optimize=<T or F> 
Default: T 
 
Purpose: Setting this option to T, turn causes calls to primitive functions 
to be replaced with direct calls. This option can be overridden by the use 
of #optimize_primitives compiler directive. 
 
To change: Select Optimize Primitives from the Options menu. 
------------------------------------------------------------ 
System Topics=<T or F> 
Default: F 
 
Purpose: Changing this option T, allows !! topics to be displayed when 
Topics is chosen from the Debug menu. This setting has no 
effect if Debug=F. 
 
To change: Select System Topics from the Options menu. 
------------------------------------------------------------ 
Tooln=Tool List 
Default: none 
 
Purpose: n is an integer from 1 to 16. This option allows up to 16 tools 
to be added to the Tool menu. Tool List is a three element list 
consisting of 
 
[Title, Application, Initialization Command]. 
 
where  
 
Title is the text which will appear on the Tool menu, If this text contains 
spaces, periods etc., it must be enclosed in single quotes. 
 
Application is the name of the KPWIN application which will be executed 
when the menu option is selected. If this text contains spaces, periods 
etc., it must be enclosed in single quotes. The application is loaded by 
the command KPWIN Application. 
 
Initialization Command is an optional string which will be sent to the 
application via a dde_execute command after the application is 
loaded. It must have proper KnowledgePro syntax, including a period 
after each command. 
 
For example,  
 
Tool1=['&Fonts...', 'C:\windows\kpwin\fonts\font2.ckb', 'change_directory (c:\appfonts).']. 
 
This setting adds Fonts... to the Tools menu. When this option is selected, 
the application,  C:\windows\kpwin\fonts\font2.ckb is loaded 
and a change_directory command is executed to switch the application to a 
new directory. 
 
To change: Select Customize Tool Menu from the Tools menu. 

To build your own tools beyond what is supplied with KnowledgePro, refer
to the Help System's How To Write Tools.

============================================================================
                         Differences from Version 1.1
============================================================================

Introducing KnowlegePro Windows Gold

  Users of previous versions of KnowledgePro Windows will now notice our
  new product name. KnowledgePro Windows Gold is the version of KPWin
  that includes your royalty-free runtime system. 

Files not needed from the previous version:

  KnowledgePro Windows no longer requires the following files. If you
  are distributing them with your current KPWin applications, please 
  note that they can be safely removed from your distribution.

       kpwin2.exe
       win87em.exe
       kpwin.ico - now supplied as an internal icon KP_ICON

New features

  Many new features that users have requested have been incorporated. 
  Please view the help system for further information. Some of these 
  new features are:

  * Font support in screen objects
  * Visual screen designer
  * Improved performance
  * Improved development menu with short-cut keys
  * Customizeable tools menu
  * Expanded Help system with a special "How To" section
  * Compiler directives
  * Many New Functions and New events

  For a detailed description of the function and event changes
  see the file UPGRADE2.TXT.
 
Backward compatibility

     KnowledgePro Windows 2.0 was designed with provisions for backward
     compatibility. Your KPWin 1.1 applications should be re-compiled
     (if possible, with Primitive Optimization enabled for faster programs)
     to run with this new version and new runtime system.

     Some new features, however, do not allow for backward compatibility
     simple because there was no previous specifications. These few
     differences are mentioned here:

           menu - The menu function now provides three or more levels of
                  pop-up menus. Nested sublists passed to the menu command
                  become pop-up menus automatically. Be sure to test your
                  KPWin 1.1 application's menus to see if you need to
                  make any modifications.

           string_to_list - This function had a previously undocumented
                  third parameter which produced empty list elements for
                  the specified delimited. The format has changed, please
                  refer to the reference manual for details.

     If you encounter any anomalies when running KPWin 1.1 program, 
     please contact Technical Support.

============================================================================
                         Differences from Version 2.0
============================================================================

     If you are upgrading from version 1.1, please be sure to first read 
     the previous section, Differences from Version 1.1.

Summary of Changes

     Version 2.11 includes some corrections to version 2.0 as well as
     some new features.

     * Improved KPWin Designer
     * User reported bug corrections (detailed below)

Corrected features:

Editor      Some of the new Multiple Document Interface (MDI) features in
            the development environment caused problems in Windows 3.0.
focus       Some programs work differently from version 1.1. The tabbing 
            order appears to get confused, when you set focus to another 
            object. 

Corrected functions:

group_box   The group box doesn't allow text to appear from the main window.
save_topic  save_topic doesn't save sub topic values.                                                      
auto_hyper_on
            Dragging on the text to mark it for hypertext causes the text 
            to repaint several times. 
insert_text Insert text has a different behavior in child windows than it 
            does in popup windows (with a parent).
save_topic  Topics can be saved the KPWIN runtime, but they are not
            loaded back in properly.
set_text    The bitmap only appears in the area that the text appears. 
set_text    set_text does not erase the text on the screen in all cases. 

============================================================================
                         Differences from Version 2.11
============================================================================

     If you are upgrading from version 1.1, please be sure to first read 
     the section, Differences from Version 1.1.

Summary of Changes

     Version 2.21 includes some corrections to version 2.11 as well as
     some new features.

     * Improved KPWin Designer
     * User reported bug corrections (detailed below)

Enhancements:

dde_execute     Now returns the lowest-order byte of lParam.
environment     Added a list of previously used files to the file menu.     
window styles   MODALFRAME style added for modal dialog windows.

Corrected features:

close_event     When KPWin closes, the close events were not recognized 
                nor handled. 
compiler        A long string without quotes caused a GPF during 
                compilation. 
editor          Certain files larger than 32K weren't saved properly 
                by the editor.  MDI anomalies corrected.

Corrected functions:

auto_hyper_on   The last letter of any line couldn't be highlighted 
                with auto_hyper_on. 
combo_box       Repainting and positioning information from a 
                double_click_event corrected.
delete_bitmap   Caused intermittent problems.
double          This typecast didn't work correctly. 
float           This typecast didn't work correctly. 
get_text        Didn't work when text had been written using hash 
                characters.
hyper_region    Scrolling a window with hyper-regions caused improper 
                hyper-region repainting.
intersect       The intersect function didn't work properly if the 
                second list has only one element.
list_box        Long (> 80 chars) list box entries caused a GPF.                                      
load_topic      load_topic did not retrieve values for individual topics. 
menu            Disabling and menu item with any cascasing menu option 
                caused the wrong item to be disabled.                                                                              
replace_elements     Replace elements didn't handle single element 
                     lists correctly. 
set_number_of_values After the "exceeds number of values" error, the topic 
                     was assigned an incorrect value. 
trace           Caused intermittent problems.


============================================================================
                           Known bugs 
============================================================================

The following bug listing includes problems encountered too late for final
production.

SUBJECT:  Running out of handles. 

    Doing a Debug/Topics on a large KB causes strange effects, notably wrong 
    fonts is the File/Open dialog box. The problem is that when you do Debug/Topics, you create 
    a whole bunch of hyper_regions. Each hyper_region is what Windows calls a region. Each region 
    has a handle and allocates space on the GDI stack. Windows is supposed to return a NULL handle 
    when it runs out of space, but it doesn't. 

SUBJECT:  maximizing a child edit_window 

    Maximize the edit window.  It is not sized correctly to fit in the parent.  
    This works fine for display windows. To propely maximimze a child window, you need a 
    menu bar in the parent. You can even use a null menu like 
 
    menu([ [ ] ]). 

 
SUBJECT: combo box 

    In the simple style a double click does not generate a lose_focus event but in 
    the others it does. Combo boxes don't correctly handle double clicks. This is a MS 
    Windows problem. When you double click on a dropdown list, the focus gets set to 
    the parent window when the listbox closes. In the simple style, nothing closes 
    and the focus stays where it is. 
 
SUBJECT: DDE 
  
    Trying to do a new_kb on a .kb file (not ckb) from Word via DDE results in an
    Application Error in KPWIN. New_kb causes a clear ( ) to be executed and thus 
    wipes out the current kb, terminates all DDE conversations, closes files etc. 
    We recommend not using new_kb via DDE, a DLL or any place where the continuing 
    existence of a topic structure is expected. 

SUBJECT: Deleting hyper regions
  
    Deleting hyper regions after closing a window will cause an application error.
    If you are going to use delete_hyper_region, we recommend that you use it 
    prior to closing a window.

============================================================================ 
                           RUNTIME POLICY 
============================================================================ 
   
  The runtime version of KnowledgePro Windows included in every copy of
  KnowledgePro Windows Gold, can be distributed freely provided 
  that your application is not an engine or a tool with the ability to 
  create further applications.  If you wish to distribute such an  
  application, or have any questions about our runtime policy, contact 
  Knowledge Garden. 
  
============================================================================ 
                           QUESTIONS YOU MAY HAVE 
============================================================================ 
 
Q] How do I convert my KnowledgePro DOS applications to Windows? 
A] When KnowledgePro Windows is loaded press F1 for help 
and then select:

      Converting from KnowledgePro (DOS) version 1.x 

For additional information see the file CONVERT.SRC.
 
Q] Can I run my KnowledgePro Windows 1.1 applications?
A] KnowledgePro Windows 2.x was designed with provisions for backward
compatibility. Your KPWin 1.1 applications should be re-compiled
(if possible, with Primitive Optimization enabled for faster programs)
to run with this new version and new runtime system.
 
Q] Why won't my window display the way I expect it to? 
A] The style of a window is very important in determining 
the way it is displayed and how the objects inside it are 
displayed.  If you have not read the manual we suggest you 
use the default style to avoid problems.  Whenever you select 
a style that does not use one of: 

   OverlappedWindow, PopupWindow, ChildWindow or DialogWindow 

include the styles ShowChildren, Siblings, or visible.
 
Q] How can I customize the HELP system. 
A] The source code for the help file is KPHELP.KB.  It 
includes comments that describe how the help system can be 
customized. 

If you need more information, check with the "How To" section of
the KnowledgePro Windows Help System.
