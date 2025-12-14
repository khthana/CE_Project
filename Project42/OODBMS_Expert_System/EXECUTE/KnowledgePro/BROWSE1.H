/**** File: browse.kb , Line 1 , Topic : !main ****/

void B_Main ( Topic* ET )
{ 
  CB Jmp,* OldJmp;
  if (Catch(Jmp))
    return;
  OldJmp = ET->pExit;
  ET->pExit=&Jmp;
  
  
  // (* ============================= BROWSE.KB ===================================
  //     A Topic Library Browser for KnowledgePro.
  // 
  //     This tool loads a topic library from disk and displays the topics in a hypertext
  //     list. When you select a topic from this list, a description of the topic appears.
  //     You can copy the syntax or the entire topic to the clipboard for use in your 
  //     applications as well as view the topic interactively. 
  // 
  //     For more details run this program and view the help system.
  // 
  //    Copyright (c) Knowledge Garden Inc. 1990-92
  // 
  //                  Knowledge Garden Inc.
  //                  Stony Brook Technology Center
  //                  12-8 Technology Drive
  //                  Setauket, NY 11733
  // 
  //                  Phone (516) 246-5400
  //                  Fax   (516) 246-5452
  // 
  //    This source code may not be distibuted without permission of
  //    Knowledge Garden Inc.
  // 
  //    NOTE: This tool is designed to run in a separate instance of 
  //          KnowledgePro. Therefore when you quit this tool, you
  //          also terminate KnowledgePro.
  // 
  // ==========================================================================*)
  // 
  // setup (). 
  FindTopic("setup" ,-1)->DoBody(
    vnNL);
  
  // (* =============== Create Main Window =============== *)
  // 
  // wmain is window (quit, 2,1,84,26,'Library Browser',[overlapped,thickframe,controlmenu,minimizebox,maximizebox,showchildren,titlebar], , , green2, close_event). 
  FindTopicCreate("wmain" ,-1)->MAKE1(ReUse(FindTopic(__Window)->DoBody(
    new VN(11,
      new VN("quit" ,5),
      new VN(2.0),
      new VN(1.0),
      new VN(84.0),
      new VN(26.0),
      new VN("Library Browser" ,16),
      new VN(7,
        new VN("overlapped" ,11),
        new VN("thickframe" ,11),
        new VN("controlmenu" ,12),
        new VN("minimizebox" ,12),
        new VN("maximizebox" ,12),
        new VN("showchildren" ,13),
        new VN("titlebar" ,9)),
      vnNL,vnNL,new VN("green2" ,7),
      new VN("close_event" ,12)))));
  
  // icon is load_icon (kptool_icon). 
  FindTopicCreate(__Icon)->MAKE1(ReUse(FindTopic(__Load_Icon)->DoBody(
    new VN(1,new VN("kptool_icon" ,12)))));
  
  // attach_icon ( ?wMain, ?icon ). 
  FindTopic(__Attach_Icon)->DoBody(
    new VN(2,
      FindTopic("wMain" ,-1)->TV(),
      FindTopic(__Icon)->TV()));
  
  // w4 is window (,3,2,78.4,20.7, ,[childwindow,horzscroll,thinframe,vertscroll],?wmain). 
  FindTopicCreate("w4" ,-1)->MAKE1(ReUse(FindTopic(__Window)->DoBody(
    new VN(8,
      vnNL,new VN(3.0),
      new VN(2.0),
      new VN(78.4),
      new VN(20.7),
      vnNL,new VN(4,
        new VN("childwindow" ,12),
        new VN("horzscroll" ,11),
        new VN("thinframe" ,10),
        new VN("vertscroll" ,11)),
      FindTopic("wmain" ,-1)->TV()))));
  
  // w1 is window (, 3,17,78.4,7.5 ,,[childwindow,thinframe,visible],?wmain). 
  FindTopicCreate("w1" ,-1)->MAKE1(ReUse(FindTopic(__Window)->DoBody(
    new VN(8,
      vnNL,new VN(3.0),
      new VN(17.0),
      new VN(78.4),
      new VN(7.5),
      vnNL,new VN(3,
        new VN("childwindow" ,12),
        new VN("thinframe" ,10),
        new VN("visible" ,8)),
      FindTopic("wmain" ,-1)->TV()))));
  
  // use_font (?bigFont). 
  FindTopic(__Use_Font)->DoBody(
    new VN(1,FindTopic("bigFont" ,-1)->TV()));
  
  // text (' #fred Current topic:'). 
  FindTopic(__Text)->DoBody(
    new VN(1,new VN(" #fred Current topic:" ,22)));
  
  // use_font (?mainFont). 
  FindTopic(__Use_Font)->DoBody(
    new VN(1,FindTopic("mainFont" ,-1)->TV()));
  
  // button (Quit,quit,66,6.5,13). 
  FindTopic(__Button)->DoBody(
    new VN(5,
      new VN("Quit" ,5),
      new VN("quit" ,5),
      new VN(66.0),
      new VN(6.5),
      new VN(13.0)));
  
  // button (Help,help,53,6.5,13). 
  FindTopic(__Button)->DoBody(
    new VN(5,
      new VN("Help" ,5),
      new VN("help" ,5),
      new VN(53.0),
      new VN(6.5),
      new VN(13.0)));
  
  // button ('Load Library',PromptLoadLib,40,6.5,13). 
  FindTopic(__Button)->DoBody(
    new VN(5,
      new VN("Load Library" ,13),
      new VN("PromptLoadLib" ,14),
      new VN(40.0),
      new VN(6.5),
      new VN(13.0)));
  
  // bView is button ('View Topic',CopyTopic,27,6.5,13). 
  FindTopicCreate("bView" ,-1)->MAKE1(ReUse(FindTopic(__Button)->DoBody(
    new VN(5,
      new VN("View Topic" ,11),
      new VN("CopyTopic" ,10),
      new VN(27.0),
      new VN(6.5),
      new VN(13.0)))));
  
  // bTopics is button (Topics,toTopics,27,6.5,13). 
  FindTopicCreate("bTopics" ,-1)->MAKE1(ReUse(FindTopic(__Button)->DoBody(
    new VN(5,
      new VN("Topics" ,7),
      new VN("toTopics" ,9),
      new VN(27.0),
      new VN(6.5),
      new VN(13.0)))));
  
  // hide_window (?bTopics). 
  FindTopic(__Hide_Window)->DoBody(
    new VN(1,FindTopic("bTopics" ,-1)->TV()));
  
  // bCopyTopic is button ('Copy Topic',CopyTopic,14,6.5,13). 
  FindTopicCreate("bCopyTopic" ,-1)->MAKE1(ReUse(FindTopic(__Button)->DoBody(
    new VN(5,
      new VN("Copy Topic" ,11),
      new VN("CopyTopic" ,10),
      new VN(14.0),
      new VN(6.5),
      new VN(13.0)))));
  
  // bCopySyntax is button ('Copy Syntax',CopySyntax,1,6.5,13). 
  FindTopicCreate("bCopySyntax" ,-1)->MAKE1(ReUse(FindTopic(__Button)->DoBody(
    new VN(5,
      new VN("Copy Syntax" ,12),
      new VN("CopySyntax" ,11),
      new VN(1.0),
      new VN(6.5),
      new VN(13.0)))));
  
  // curWin is window ( , 15.5,1.15,65,1.25, ,[child,visible],?w1). 
  FindTopicCreate("curWin" ,-1)->MAKE1(ReUse(FindTopic(__Window)->DoBody(
    new VN(8,
      vnNL,new VN(15.5),
      new VN(1.15),
      new VN(65.0),
      new VN(1.25),
      vnNL,new VN(2,
        new VN("child" ,6),
        new VN("visible" ,8)),
      FindTopic("w1" ,-1)->TV()))));
  
  // desWin is window (, 1,2.5,78,4, , [childwindow,visible,vertscroll],?w1). 
  FindTopicCreate("desWin" ,-1)->MAKE1(ReUse(FindTopic(__Window)->DoBody(
    new VN(8,
      vnNL,new VN(1.0),
      new VN(2.5),
      new VN(78.0),
      new VN(4.0),
      vnNL,new VN(3,
        new VN("childwindow" ,12),
        new VN("visible" ,8),
        new VN("vertscroll" ,11)),
      FindTopic("w1" ,-1)->TV()))));
  
  // disable_window ([?bView, ?bTopics, ?bCopyTopic, ?bCopySyntax]). 
  FindTopic(__Disable_Window)->DoBody(
    new VN(1,new VN(4,
      FindTopic("bView" ,-1)->TV(),
      FindTopic("bTopics" ,-1)->TV(),
      FindTopic("bCopyTopic" ,-1)->TV(),
      FindTopic("bCopySyntax" ,-1)->TV())));
  
  // (* =============== Create Topic Display Window =============== *)
  // 
  // w3 is window (, 3,2,78.4,14, ,[childwindow,thinframe,visible],?wmain). 
  FindTopicCreate("w3" ,-1)->MAKE1(ReUse(FindTopic(__Window)->DoBody(
    new VN(8,
      vnNL,new VN(3.0),
      new VN(2.0),
      new VN(78.4),
      new VN(14.0),
      vnNL,new VN(3,
        new VN("childwindow" ,12),
        new VN("thinframe" ,10),
        new VN("visible" ,8)),
      FindTopic("wmain" ,-1)->TV()))));
  
  // use_font (?bigFont). 
  FindTopic(__Use_Font)->DoBody(
    new VN(1,FindTopic("bigFont" ,-1)->TV()));
  
  // text (' #fred Current library:'). 
  FindTopic(__Text)->DoBody(
    new VN(1,new VN(" #fred Current library:" ,24)));
  
  // use_font (?mainFont). 
  FindTopic(__Use_Font)->DoBody(
    new VN(1,FindTopic("mainFont" ,-1)->TV()));
  
  // libWin is window ( , 15.5,1.15,65,1.25, ,[child,visible],?w3). 
  FindTopicCreate("libWin" ,-1)->MAKE1(ReUse(FindTopic(__Window)->DoBody(
    new VN(8,
      vnNL,new VN(15.5),
      new VN(1.15),
      new VN(65.0),
      new VN(1.25),
      vnNL,new VN(2,
        new VN("child" ,6),
        new VN("visible" ,8)),
      FindTopic("w3" ,-1)->TV()))));
  
  // topWin is window (,1,2.5,78,12.5, ,[childwindow,thinframe,vertscroll,visible],?w3). 
  FindTopicCreate("topWin" ,-1)->MAKE1(ReUse(FindTopic(__Window)->DoBody(
    new VN(8,
      vnNL,new VN(1.0),
      new VN(2.5),
      new VN(78.0),
      new VN(12.5),
      vnNL,new VN(4,
        new VN("childwindow" ,12),
        new VN("thinframe" ,10),
        new VN("vertscroll" ,11),
        new VN("visible" ,8)),
      FindTopic("w3" ,-1)->TV()))));
  
  // (* =============== Show the main window and prompt the user =============== *)
  // 
  // show_window (?wmain). 
  FindTopic(__Show_Window)->DoBody(
    new VN(1,FindTopic("wmain" ,-1)->TV()));
  
  // PromptLoadLib (). 
  FindTopic("PromptLoadLib" ,-1)->DoBody(
    vnNL);
  
End:
  ET->pExit = OldJmp;
  return;
}

