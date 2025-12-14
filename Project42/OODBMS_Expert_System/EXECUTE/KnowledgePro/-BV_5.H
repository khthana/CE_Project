/**** File: stat-ex.kb , Line 58 , Topic : explain_TypeOfTesting ****/

void B_Explain_TypeOfTesting ( Topic* ET )
{ 
  CB Jmp,* OldJmp;
  if (Catch(Jmp))
    goto End;
  
  OldJmp = ET->BodyIn(&Jmp);
  
  // if ?type_explain is 'Z - test for one Population'
  // 				then 
  if (bEQU(
    FindTopic("type_explain" ,-1)->TV(),
    new VN("Z - test for one Population" ,28)))
  { 
    
    // do (exp1). 
    FindTopic(__Do)->DoBody(
      new VN(1,new VN("exp1" ,5)));
  }
  
  // if ?type_explain is 't - test for one Population'
  // 				then 
  if (bEQU(
    FindTopic("type_explain" ,-1)->TV(),
    new VN("t - test for one Population" ,28)))
  { 
    
    // do (exp2). 
    FindTopic(__Do)->DoBody(
      new VN(1,new VN("exp2" ,5)));
  }
  
  // if ?type_explain is 'Z - test for one Population- Large Sample size'
  // 				then 
  if (bEQU(
    FindTopic("type_explain" ,-1)->TV(),
    new VN("Z - test for one Population- Large Sample size" ,47)))
  { 
    
    // do (exp3). 
    FindTopic(__Do)->DoBody(
      new VN(1,new VN("exp3" ,5)));
  }
  
  // if ?type_explain is 'Z - test for two Populations - using Paired comparison.'
  // 				then 
  if (bEQU(
    FindTopic("type_explain" ,-1)->TV(),
    new VN("Z - test for two Populations - using Paired comparison." ,56)))
  { 
    
    // do (exp4). 
    FindTopic(__Do)->DoBody(
      new VN(1,new VN("exp4" ,5)));
  }
  
  // if ?type_explain is 'Z - test for two Populations - using Independent sampling.'				
  // 				then 
  if (bEQU(
    FindTopic("type_explain" ,-1)->TV(),
    new VN("Z - test for two Populations - using Independent sampling." ,59)))
  { 
    
    // do (exp5). 
    FindTopic(__Do)->DoBody(
      new VN(1,new VN("exp5" ,5)));
  }
  
  // if ?type_explain is 'ANOVA  test '
  // 				then 
  if (bEQU(
    FindTopic("type_explain" ,-1)->TV(),
    new VN("ANOVA  test " ,13)))
  { 
    
    // do (exp6). 
    FindTopic(__Do)->DoBody(
      new VN(1,new VN("exp6" ,5)));
  }
  
  // if ?type_explain is 'Non Parametric ANOVA  test '							
  // 				then 
  if (bEQU(
    FindTopic("type_explain" ,-1)->TV(),
    new VN("Non Parametric ANOVA  test " ,28)))
  { 
    
    // do (exp7). 
    FindTopic(__Do)->DoBody(
      new VN(1,new VN("exp7" ,5)));
  }
  
  // if ?type_explain is 'Z - test for two Normal, known Variance  Populations - using Paired Comparison sampling.'
  // 				then 
  if (bEQU(
    FindTopic("type_explain" ,-1)->TV(),
    new VN("Z - test for two Normal, known Variance  Populations - using Paire"
           "d Comparison sampling." ,89)))
  { 
    
    // do (exp9). 
    FindTopic(__Do)->DoBody(
      new VN(1,new VN("exp9" ,5)));
  }
  
  // if ?type_explain is 't - test for two Populations - using Paired comparison.'
  // 				then 
  if (bEQU(
    FindTopic("type_explain" ,-1)->TV(),
    new VN("t - test for two Populations - using Paired comparison." ,56)))
  { 
    
    // do (exp10). 
    FindTopic(__Do)->DoBody(
      new VN(1,new VN("exp10" ,6)));
  }
  
  // if ?type_explain is 't - test for two Populations - using Independent sampling'
  // 				then 
  if (bEQU(
    FindTopic("type_explain" ,-1)->TV(),
    new VN("t - test for two Populations - using Independent sampling" ,58)))
  { 
    
    // do (exp11). 
    FindTopic(__Do)->DoBody(
      new VN(1,new VN("exp11" ,6)));
  }
  
End:
  ET->BodyOut( OldJmp );
}

