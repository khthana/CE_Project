/**** File: stat-ex.kb , Line 30 , Topic : GetOption ****/

void B_GetOption ( Topic* ET )
{ 
  CB Jmp,* OldJmp;
  if (Catch(Jmp))
    goto End;
  
  OldJmp = ET->BodyIn(&Jmp);
  
  // do (?item). 
  FindTopic(__Do)->DoBody(
    new VN(1,FindTopic("item" ,-1)->TV()));
  
  // reset([&Consultant, &Testing]). 
  FindTopic(__Reset)->DoBody(
    new VN(1,new VN(2,
      new VN("&Consultant" ,12),
      new VN("&Testing" ,9))));
  
End:
  ET->BodyOut( OldJmp );
}

/**** File: stat-ex.kb , Line 383 , Topic : &Testing ****/

void B_Testing ( Topic* ET )
{ 
  CB Jmp,* OldJmp;
  if (Catch(Jmp))
    goto End;
  
  OldJmp = ET->BodyIn(&Jmp);
  
  // (*	if ?TypeOfTesting is 'Z - test for one Population'
  // 		 then run('D:\kpwin2\ztest.exe ztest'). *)
  // 		 
  // 	(*	if ?TypeOfTesting is  't - test for one Population'
  // 		 then run('D:\kpwin2\ztest.exe ttest'). *)
  // 
  // 		run('D:\kpwin2\ztest.exe ztest',1). 
  FindTopic(__Run)->DoBody(
    new VN(2,
      new VN("D:\\kpwin2\\ztest.exe ztest" ,28),
      new VN(1.0)));
  
End:
  ET->BodyOut( OldJmp );
}

