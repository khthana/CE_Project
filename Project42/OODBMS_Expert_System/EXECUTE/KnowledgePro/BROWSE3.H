/**** File: browse.kb , Line 105 , Topic : ReadLibraryParms ****/

void B_ReadLibraryParms ( Topic* ET )
{ 
  CB Jmp,* OldJmp;
  if (Catch(Jmp))
    goto End;
  
  OldJmp = ET->BodyIn(&Jmp);
  
  // (* This topic formats each of the topic definitions by reading the parameters
  //         from topic library. *)
  //      if string_where (?item, ' ') <> 0 then 
  if (bNEQ(
    ReUse(FindTopic(__String_Where)->DoBody(
      new VN(2,
        FindTopic("item" ,-1)->TV(),
        new VN(" " ,2)))),
    new VN(0.0)))
  { 
    
    // item is concat ('''', ?item, ''''). 
    FindTopicCreate("item" ,-1)->MAKE1(ReUse(FindTopic(__Concat)->DoBody(
      new VN(3,
        new VN("\'" ,3),
        FindTopic("item" ,-1)->TV(),
        new VN("\'" ,3)))));
  }
  
  // fullTopic is read (?file, concat (?topicHeader, ?item), '.'). 
  FindTopicCreate("fullTopic" ,-1)->MAKE1(ReUse(FindTopic(__Read)->DoBody(
    new VN(3,
      FindTopic("file" ,-1)->TV(),
      ReUse(FindTopic(__Concat)->DoBody(
        new VN(2,
          FindTopic("topicHeader" ,-1)->TV(),
          FindTopic("item" ,-1)->TV()))),
      new VN("." ,2)))));
  
  // if ?fullTopic is ?EOF then 
  if (bEQU(
    FindTopic("fullTopic" ,-1)->TV(),
    FindTopic("EOF" ,-1)->TV()))
  { 
    
    // fullTopic is []. 
    FindTopicCreate("fullTopic" ,-1)->MAKE1(vnNL);
  }
  
  // fullTopicList gets concat (?item, ?fullTopic). 
  FindTopicCreate("fullTopicList" ,-1)->GETS1(ReUse(FindTopic(__Concat)->DoBody(
    new VN(2,
      FindTopic("item" ,-1)->TV(),
      FindTopic("fullTopic" ,-1)->TV()))));
  
End:
  ET->BodyOut( OldJmp );
}

/**** File: browse.kb , Line 184 , Topic : checkEnd ****/

void B_CheckEnd ( Topic* ET )
{ 
  CB Jmp,* OldJmp;
  if (Catch(Jmp))
    goto End;
  
  OldJmp = ET->BodyIn(&Jmp);
  
  // if string_where (?item, 'end.') <> 0 then 
  if (bNEQ(
    ReUse(FindTopic(__String_Where)->DoBody(
      new VN(2,
        FindTopic("item" ,-1)->TV(),
        new VN("end." ,5)))),
    new VN(0.0)))
  { 
    
    // topicEnded is t. 
    FindTopicCreate("topicEnded" ,-1)->MAKE1(new VN("t" ,2));
  }
  
End:
  ET->BodyOut( OldJmp );
}

