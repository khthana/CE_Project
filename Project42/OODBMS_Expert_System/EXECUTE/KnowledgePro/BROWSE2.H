/**** File: browse.kb , Line 70 , Topic : PromptLoadLib ****/

void B_PromptLoadLib ( Topic* ET )
{ 
  CB Jmp,* OldJmp;
  if (Catch(Jmp))
    goto End;
  
  OldJmp = ET->BodyIn(&Jmp);
  
  // (* This topic prompts the user with a list of topic libraries. If a selection is made
  //       then the library is read. *)
  //   file is file_menu ( '*.tpx', ,'Enter the library you want to browse:'). 
  FindTopicCreate("file" ,-1)->MAKE1(ReUse(FindTopic(__File_Menu)->DoBody(
    new VN(3,
      new VN("*.tpx" ,6),
      vnNL,new VN("Enter the library you want to browse:" ,38)))));
  
  // if ?file <> [] then 
  if (bNEQ(
    FindTopic("file" ,-1)->TV(),
    vnNL))
  { 
    
    // readLibrary (?file). 
    FindTopic("readLibrary" ,-1)->DoBody(
      new VN(1,FindTopic("file" ,-1)->TV()));
  }
  
End:
  ET->BodyOut( OldJmp );
}

/**** File: browse.kb , Line 78 , Topic : readLibrary ****/

void B_ReadLibrary ( Topic* ET )
{ 
  CB Jmp,* OldJmp;
  if (Catch(Jmp))
    goto End;
  
  OldJmp = ET->BodyIn(&Jmp);
  
  // (* This topic reads the topic library file and builds a list of the topics
  //       included in the file. *)
  // 
  //   msgWin is window ((* eventTopic*),20,10,44,6,,[popup,showChildren,siblings,DialogFrame]). 
  FindTopicCreate("msgWin" ,-1)->MAKE1(ReUse(FindTopic(__Window)->DoBody(
    new VN(7,
      vnNL,new VN(20.0),
      new VN(10.0),
      new VN(44.0),
      new VN(6.0),
      vnNL,new VN(4,
        new VN("popup" ,6),
        new VN("showChildren" ,13),
        new VN("siblings" ,9),
        new VN("DialogFrame" ,12))))));
  
  // text ('
  // 
  //       One moment ... Loading Topic Library'). 
  FindTopic(__Text)->DoBody(
    new VN(1,new VN("\n\n      One moment ... Loading Topic Library" ,47)));
  
  // show_window (?msgWin). 
  FindTopic(__Show_Window)->DoBody(
    new VN(1,FindTopic("msgWin" ,-1)->TV()));
  
  // update_window (?msgWin). 
  FindTopic(__Update_Window)->DoBody(
    new VN(1,FindTopic("msgWin" ,-1)->TV()));
  
  // make_modal (?msgWin). 
  FindTopic(__Make_Modal)->DoBody(
    new VN(1,FindTopic("msgWin" ,-1)->TV()));
  
  // set_text (?libWin,['   Library: #s',?file,#n]). 
  FindTopic(__Set_Text)->DoBody(
    new VN(2,
      FindTopic("libWin" ,-1)->TV(),
      new VN(3,
        new VN("   Library: #s" ,15),
        FindTopic("file" ,-1)->TV(),
        new VN("#n" ,3))));
  
  // load (?file, temp). 
  FindTopic(__Load)->DoBody(
    new VN(2,
      FindTopic("file" ,-1)->TV(),
      new VN("temp" ,5)));
  
  // topicList is children (temp). 
  FindTopicCreate("topicList" ,-1)->MAKE1(ReUse(FindTopic(__Children)->DoBody(
    new VN(1,new VN("temp" ,5)))));
  
  // remove_topic (temp). 
  FindTopic(__Remove_Topic)->DoBody(
    new VN(1,new VN("temp" ,5)));
  
  // set_display_window (?topWin). 
  FindTopic(__Set_Display_Window)->DoBody(
    new VN(1,FindTopic("topWin" ,-1)->TV()));
  
  // fullTopicList is []. 
  FindTopicCreate("fullTopicList" ,-1)->MAKE1(vnNL);
  
  // set_file_pos (?file,0). 
  FindTopic(__Set_File_Pos)->DoBody(
    new VN(2,
      FindTopic("file" ,-1)->TV(),
      new VN(0.0)));
  
  // apply (ReadLibraryParms, ?topicList). 
  FindTopic(__Apply)->DoBody(
    new VN(2,
      new VN("ReadLibraryParms" ,17),
      FindTopic("topicList" ,-1)->TV()));
  
  // set_text (?topWin, concat (?indent, '#m',?fullTopicList,'#m' )). 
  FindTopic(__Set_Text)->DoBody(
    new VN(2,
      FindTopic("topWin" ,-1)->TV(),
      ReUse(FindTopic(__Concat)->DoBody(
        new VN(4,
          FindTopic("indent" ,-1)->TV(),
          new VN("#m" ,3),
          FindTopic("fullTopicList" ,-1)->TV(),
          new VN("#m" ,3))))));
  
  // mark ( first (?fullTopicList) ). 
  FindTopic("mark" ,-1)->DoBody(
    new VN(1,ReUse(FindTopic(__First)->DoBody(
      new VN(1,FindTopic("fullTopicList" ,-1)->TV())))));
  
  // enable_window ([?bView, ?bTopics, ?bCopyTopic, ?bCopySyntax]). 
  FindTopic(__Enable_Window)->DoBody(
    new VN(1,new VN(4,
      FindTopic("bView" ,-1)->TV(),
      FindTopic("bTopics" ,-1)->TV(),
      FindTopic("bCopyTopic" ,-1)->TV(),
      FindTopic("bCopySyntax" ,-1)->TV())));
  
  // if ?inTopicView then 
  if (IsTrue(FindTopic("inTopicView" ,-1)->TV()))
  { 
    
    // toTopics (). 
    FindTopic("toTopics" ,-1)->DoBody(
      vnNL);
  }
  
  // close_window (?msgWin). 
  FindTopic(__Close_Window)->DoBody(
    new VN(1,FindTopic("msgWin" ,-1)->TV()));
  
End:
  ET->BodyOut( OldJmp );
}

/**** File: browse.kb , Line 117 , Topic : CopySyntax ****/

void B_CopySyntax ( Topic* ET )
{ 
  CB Jmp,* OldJmp;
  if (Catch(Jmp))
    goto End;
  
  OldJmp = ET->BodyIn(&Jmp);
  
  // (* This topic copies the selected topic's syntax to the clipboard, so that
  //       it can be copied into your application. *)
  //   copyItem is ?current. 
  FindTopicCreate("copyItem" ,-1)->MAKE1(FindTopic("current" ,-1)->TV());
  
  // if string_where (?copyItem, '(') is 0 then 
  if (bEQU(
    ReUse(FindTopic(__String_Where)->DoBody(
      new VN(2,
        FindTopic("copyItem" ,-1)->TV(),
        new VN("(" ,2)))),
    new VN(0.0)))
  { 
    
    // copyItem is concat (?copyItem, ' ()'). 
    FindTopicCreate("copyItem" ,-1)->MAKE1(ReUse(FindTopic(__Concat)->DoBody(
      new VN(2,
        FindTopic("copyItem" ,-1)->TV(),
        new VN(" ()" ,4)))));
  }
  
  // copyItem is concat (?copyItem, '.'). 
  FindTopicCreate("copyItem" ,-1)->MAKE1(ReUse(FindTopic(__Concat)->DoBody(
    new VN(2,
      FindTopic("copyItem" ,-1)->TV(),
      new VN("." ,2)))));
  
  // text_to_clipboard (?copyItem). 
  FindTopic(__Text_To_Clipboard)->DoBody(
    new VN(1,FindTopic("copyItem" ,-1)->TV()));
  
End:
  ET->BodyOut( OldJmp );
}

/**** File: browse.kb , Line 127 , Topic : CopyTopic ****/

void B_CopyTopic ( Topic* ET )
{ 
  CB Jmp,* OldJmp;
  if (Catch(Jmp))
    goto End;
  
  OldJmp = ET->BodyIn(&Jmp);
  
  // (* This topic copies the selected topic to the clipboard, so that
  //       it can be copied into your application. *)
  //   set_file_pos (?file, 0). 
  FindTopic(__Set_File_Pos)->DoBody(
    new VN(2,
      FindTopic("file" ,-1)->TV(),
      new VN(0.0)));
  
  // viewTopic is read (?file, concat (?topicHeader, ?current), element (?FullTopicList, where (?FullTopicList, ?current) + 1)). 
  FindTopicCreate("viewTopic" ,-1)->MAKE1(ReUse(FindTopic(__Read)->DoBody(
    new VN(3,
      FindTopic("file" ,-1)->TV(),
      ReUse(FindTopic(__Concat)->DoBody(
        new VN(2,
          FindTopic("topicHeader" ,-1)->TV(),
          FindTopic("current" ,-1)->TV()))),
      ReUse(FindTopic(__Element)->DoBody(
        new VN(2,
          FindTopic("FullTopicList" ,-1)->TV(),
          Arith(ADD,Make_0_Tree,
            ReUse(FindTopic(__Where)->DoBody(
              new VN(2,
                FindTopic("FullTopicList" ,-1)->TV(),
                FindTopic("current" ,-1)->TV()))),
            new VN(1.0)))))))));
  
  // viewTopic is combine ( concat (?topicHeader,?current, '.'), rest (?viewTopic)). 
  FindTopicCreate("viewTopic" ,-1)->MAKE1(ReUse(FindTopic(__Combine)->DoBody(
    new VN(2,
      ReUse(FindTopic(__Concat)->DoBody(
        new VN(3,
          FindTopic("topicHeader" ,-1)->TV(),
          FindTopic("current" ,-1)->TV(),
          new VN("." ,2)))),
      ReUse(FindTopic(__Rest)->DoBody(
        new VN(1,FindTopic("viewTopic" ,-1)->TV())))))));
  
  // viewTopic is remove (?viewTopic, ?topicHeader). 
  FindTopicCreate("viewTopic" ,-1)->MAKE1(ReUse(FindTopic(__Remove)->DoBody(
    new VN(2,
      FindTopic("viewTopic" ,-1)->TV(),
      FindTopic("topicHeader" ,-1)->TV()))));
  
  // if ?item is 'Copy Topic' then 
  if (bEQU(
    FindTopic("item" ,-1)->TV(),
    new VN("Copy Topic" ,11)))
  { 
    
    // text_to_clipboard (?viewTopic)
    //   else 
    FindTopic(__Text_To_Clipboard)->DoBody(
      new VN(1,FindTopic("viewTopic" ,-1)->TV()));
  }
  else
  { 
    
    // inTopicView is t and 
    FindTopicCreate("inTopicView" ,-1)->MAKE1(new VN("t" ,2));
    
    // set_text (?w4, ?viewTopic) and 
    FindTopic(__Set_Text)->DoBody(
      new VN(2,
        FindTopic("w4" ,-1)->TV(),
        FindTopic("viewTopic" ,-1)->TV()));
    
    // show_window ([?w4,?bTopics]) and 
    FindTopic(__Show_Window)->DoBody(
      new VN(1,new VN(2,
        FindTopic("w4" ,-1)->TV(),
        FindTopic("bTopics" ,-1)->TV())));
    
    // hide_window (?bView). 
    FindTopic(__Hide_Window)->DoBody(
      new VN(1,FindTopic("bView" ,-1)->TV()));
  }
  
End:
  ET->BodyOut( OldJmp );
}

/**** File: browse.kb , Line 143 , Topic : toTopics ****/

void B_ToTopics ( Topic* ET )
{ 
  CB Jmp,* OldJmp;
  if (Catch(Jmp))
    goto End;
  
  OldJmp = ET->BodyIn(&Jmp);
  
  // inTopicView is f. 
  FindTopicCreate("inTopicView" ,-1)->MAKE1(new VN("f" ,2));
  
  // show_window (?bView). 
  FindTopic(__Show_Window)->DoBody(
    new VN(1,FindTopic("bView" ,-1)->TV()));
  
  // hide_window ([?w4,?bTopics]). 
  FindTopic(__Hide_Window)->DoBody(
    new VN(1,new VN(2,
      FindTopic("w4" ,-1)->TV(),
      FindTopic("bTopics" ,-1)->TV())));
  
End:
  ET->BodyOut( OldJmp );
}

/**** File: browse.kb , Line 149 , Topic : Help ****/

void B_Help ( Topic* ET )
{ 
  CB Jmp,* OldJmp;
  if (Catch(Jmp))
    goto End;
  
  OldJmp = ET->BodyIn(&Jmp);
  
  // (* This topic calls the help system for this application. This help system is based on
  //       the generic help system provided with KnowledgePro. For reference see the file
  //       APPHELP.SRC. *)
  //   load ('browshlp.hkb', temp). 
  FindTopic(__Load)->DoBody(
    new VN(2,
      new VN("browshlp.hkb" ,13),
      new VN("temp" ,5)));
  
  // temp:file is 'browshlp.hlp'. 
  FindTopicCreate("temp:file" ,-1)->MAKE1(new VN("browshlp.hlp" ,13));
  
  // temp (). 
  FindTopic("temp" ,-1)->DoBody(
    vnNL);
  
  // wait (). 
  FindTopic(__Wait)->DoBody(
    vnNL);
  
  // remove_topic (temp). 
  FindTopic(__Remove_Topic)->DoBody(
    new VN(1,new VN("temp" ,5)));
  
End:
  ET->BodyOut( OldJmp );
}

/**** File: browse.kb , Line 160 , Topic : Quit ****/

void B_Quit ( Topic* ET )
{ 
  CB Jmp,* OldJmp;
  if (Catch(Jmp))
    goto End;
  
  OldJmp = ET->BodyIn(&Jmp);
  
  // (* This topic terminates the application. *)
  //   hide_window (?wmain). 
  FindTopic(__Hide_Window)->DoBody(
    new VN(1,FindTopic("wmain" ,-1)->TV()));
  
  // exit_kp (). 
  FindTopic(__Exit_Kp)->DoBody(
    vnNL);
  
End:
  ET->BodyOut( OldJmp );
}

/**** File: browse.kb , Line 166 , Topic : mark ****/

void B_Mark ( Topic* ET )
{ 
  CB Jmp,* OldJmp;
  if (Catch(Jmp))
    goto End;
  
  OldJmp = ET->BodyIn(&Jmp);
  
  // (* This is the default hypertext topic. All of the topics selected from the window are
  //       processed through this topic. For each selected topic, a description is read from
  //       the file and placed in the description window. *)
  //   current is ?item. 
  FindTopicCreate("current" ,-1)->MAKE1(FindTopic("item" ,-1)->TV());
  
  // set_file_pos (?file, 0). 
  FindTopic(__Set_File_Pos)->DoBody(
    new VN(2,
      FindTopic("file" ,-1)->TV(),
      new VN(0.0)));
  
  // check is read (?file, concat (?topicHeader, ?item), '(*'). 
  FindTopicCreate("check" ,-1)->MAKE1(ReUse(FindTopic(__Read)->DoBody(
    new VN(3,
      FindTopic("file" ,-1)->TV(),
      ReUse(FindTopic(__Concat)->DoBody(
        new VN(2,
          FindTopic("topicHeader" ,-1)->TV(),
          FindTopic("item" ,-1)->TV()))),
      new VN("(*" ,3)))));
  
  // topicEnded is f. 
  FindTopicCreate("topicEnded" ,-1)->MAKE1(new VN("f" ,2));
  
  // apply (checkEnd, ?check). 
  FindTopic(__Apply)->DoBody(
    new VN(2,
      new VN("checkEnd" ,9),
      FindTopic("check" ,-1)->TV()));
  
  // if ?topicEnded then 
  if (IsTrue(FindTopic("topicEnded" ,-1)->TV()))
  { 
    
    // describe is ?EOF
    //   else 
    FindTopicCreate("describe" ,-1)->MAKE1(FindTopic("EOF" ,-1)->TV());
  }
  else
  { 
    
    // describe is string_replace (read (?file, ,'*)'), '(*', ). 
    FindTopicCreate("describe" ,-1)->MAKE1(ReUse(FindTopic(__String_Replace)->DoBody(
      new VN(3,
        ReUse(FindTopic(__Read)->DoBody(
          new VN(3,
            FindTopic("file" ,-1)->TV(),
            vnNL,new VN("*)" ,3)))),
        new VN("(*" ,3),
        vnNL))));
  }
  
  // if ?describe is ?EOF then 
  if (bEQU(
    FindTopic("describe" ,-1)->TV(),
    FindTopic("EOF" ,-1)->TV()))
  { 
    
    // describe is '#fred   No Description Available for this topic#d'. 
    FindTopicCreate("describe" ,-1)->MAKE1(new VN(
      "#fred   No Description Available for this topic#d" ,50));
  }
  
  // set_text (?curWin, ?item). 
  FindTopic(__Set_Text)->DoBody(
    new VN(2,
      FindTopic("curWin" ,-1)->TV(),
      FindTopic("item" ,-1)->TV()));
  
  // set_text (?desWin, ?describe). 
  FindTopic(__Set_Text)->DoBody(
    new VN(2,
      FindTopic("desWin" ,-1)->TV(),
      FindTopic("describe" ,-1)->TV()));
  
End:
  ET->BodyOut( OldJmp );
}

/**** File: browse.kb , Line 190 , Topic : setup ****/

void B_Setup ( Topic* ET )
{ 
  CB Jmp,* OldJmp;
  if (Catch(Jmp))
    goto End;
  
  OldJmp = ET->BodyIn(&Jmp);
  
  // (* This topic sets up the fonts, colors and general purpose topics for use
  //       throughout the application. *)
  //   topicHeader is 'topic '. 
  FindTopicCreate("topicHeader" ,-1)->MAKE1(new VN("topic " ,7));
  
  // indent is '  '. 
  FindTopicCreate("indent" ,-1)->MAKE1(new VN("  " ,3));
  
  // EOF is number_to_char (26). 
  FindTopicCreate("EOF" ,-1)->MAKE1(ReUse(FindTopic(__Number_To_Char)->DoBody(
    new VN(1,new VN(26.0)))));
  
  // inTopicView is f. 
  FindTopicCreate("inTopicView" ,-1)->MAKE1(new VN("f" ,2));
  
  // bigFont is create_char_font ( [1,1,700,'F','F','F',0,1,34,'Helv']). 
  FindTopicCreate("bigFont" ,-1)->MAKE1(ReUse(FindTopic(__Create_Char_Font)->DoBody(
    new VN(1,new VN(10,
      new VN(1.0),
      new VN(1.0),
      new VN(700.0),
      new VN("F" ,2),
      new VN("F" ,2),
      new VN("F" ,2),
      new VN(0.0),
      new VN(1.0),
      new VN(34.0),
      new VN("Helv" ,5))))));
  
  // hyperFont is create_char_font ( [1,1,400,'F','F','F',0,1,34,'Helv']). 
  FindTopicCreate("hyperFont" ,-1)->MAKE1(ReUse(FindTopic(__Create_Char_Font)->DoBody(
    new VN(1,new VN(10,
      new VN(1.0),
      new VN(1.0),
      new VN(400.0),
      new VN("F" ,2),
      new VN("F" ,2),
      new VN("F" ,2),
      new VN(0.0),
      new VN(1.0),
      new VN(34.0),
      new VN("Helv" ,5))))));
  
  // boldFont is create_char_font ( [1,1,700,'F','F','F',0,1,34,'Helv']). 
  FindTopicCreate("boldFont" ,-1)->MAKE1(ReUse(FindTopic(__Create_Char_Font)->DoBody(
    new VN(1,new VN(10,
      new VN(1.0),
      new VN(1.0),
      new VN(700.0),
      new VN("F" ,2),
      new VN("F" ,2),
      new VN("F" ,2),
      new VN(0.0),
      new VN(1.0),
      new VN(34.0),
      new VN("Helv" ,5))))));
  
  // mainFont is create_char_font ( [0.82,0.71428,700,'F','F','F',0,1,34,'helv']). 
  FindTopicCreate("mainFont" ,-1)->MAKE1(ReUse(FindTopic(__Create_Char_Font)->DoBody(
    new VN(1,new VN(10,
      new VN(0.82),
      new VN(0.71428),
      new VN(700.0),
      new VN("F" ,2),
      new VN("F" ,2),
      new VN("F" ,2),
      new VN(0.0),
      new VN(1.0),
      new VN(34.0),
      new VN("helv" ,5))))));
  
  // use_font (?mainFont). 
  FindTopic(__Use_Font)->DoBody(
    new VN(1,FindTopic("mainFont" ,-1)->TV()));
  
  // if last (system_info ()) > 2 then 
  if (GRT(
    ReUse(FindTopic(__Last)->DoBody(
      new VN(1,ReUse(FindTopic(__System_Info)->DoBody(
        vnNL))))),
    new VN(2.0)))
  { 
    
    // color is green2
    //   else 
    FindTopicCreate("color" ,-1)->MAKE1(new VN("green2" ,7));
  }
  else
  { 
    
    // color is black. 
    FindTopicCreate("color" ,-1)->MAKE1(new VN("black" ,6));
  }
  
  // hyper_display (?color,,?mainFont). 
  FindTopic(__Hyper_Display)->DoBody(
    new VN(3,
      FindTopic("color" ,-1)->TV(),
      vnNL,FindTopic("mainFont" ,-1)->TV()));
  
End:
  ET->BodyOut( OldJmp );
}

