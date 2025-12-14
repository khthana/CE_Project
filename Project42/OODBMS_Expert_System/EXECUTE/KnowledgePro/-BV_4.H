/**** File: stat-ex.kb , Line 52 , Topic : retu ****/

void B_Retu ( Topic* ET )
{ 
  CB Jmp,* OldJmp;
  if (Catch(Jmp))
    goto End;
  
  OldJmp = ET->BodyIn(&Jmp);
  
  // if  ?item is No
  // 			     then 
  if (bEQU(
    FindTopic("item" ,-1)->TV(),
    new VN("No" ,3)))
  { 
    
    // close_window()
    // 			 else 
    FindTopic(__Close_Window)->DoBody(
      vnNL);
  }
  else
  { 
    
    // do (explain_TypeOfTesting). 
    FindTopic(__Do)->DoBody(
      new VN(1,new VN("explain_TypeOfTesting" ,22)));
  }
  
  // reset([&Consultant,TypeOfTesting]). 
  FindTopic(__Reset)->DoBody(
    new VN(1,new VN(2,
      new VN("&Consultant" ,12),
      new VN("TypeOfTesting" ,14))));
  
End:
  ET->BodyOut( OldJmp );
}

/**** File: stat-ex.kb , Line 339 , Topic : independence ****/

void B_Independence ( Topic* ET )
{ 
  CB Jmp,* OldJmp;
  if (Catch(Jmp))
    goto End;
  
  OldJmp = ET->BodyIn(&Jmp);
  
  // ask('The Sampling is taken on the way of : ',independence,[Independent, 'Paired Comparison']). 
  FindTopic(__Ask)->DoBody(
    new VN(3,
      new VN("The Sampling is taken on the way of : " ,39),
      new VN("independence" ,13),
      new VN(2,
        new VN("Independent" ,12),
        new VN("Paired Comparison" ,18))));
  
End:
  ET->BodyOut( OldJmp );
}

/**** File: stat-ex.kb , Line 343 , Topic : equal_variance ****/

void B_Equal_Variance ( Topic* ET )
{ 
  CB Jmp,* OldJmp;
  if (Catch(Jmp))
    goto End;
  
  OldJmp = ET->BodyIn(&Jmp);
  
  // ask('  *** Note ****
  //    The following is question concerning assumption about the equality of variances.
  //     The Populations Variances are : ' ,equal_variance, [Equal, 'Not equal']). 
  FindTopic(__Ask)->DoBody(
    new VN(3,
      new VN("  *** Note ****\n   The following is question concerning assumpt"
             "ion about the equality of variances.\n    The Populations Varia"
             "nces are : " ,139),
      new VN("equal_variance" ,15),
      new VN(2,
        new VN("Equal" ,6),
        new VN("Not equal" ,10))));
  
End:
  ET->BodyOut( OldJmp );
}

/**** File: stat-ex.kb , Line 349 , Topic : distribution ****/

void B_Distribution ( Topic* ET )
{ 
  CB Jmp,* OldJmp;
  if (Catch(Jmp))
    goto End;
  
  OldJmp = ET->BodyIn(&Jmp);
  
  // ask('What are the population distributions ?',distribution,[Normal,'Not Normal',Unknown]). 
  FindTopic(__Ask)->DoBody(
    new VN(3,
      new VN("What are the population distributions ?" ,40),
      new VN("distribution" ,13),
      new VN(3,
        new VN("Normal" ,7),
        new VN("Not Normal" ,11),
        new VN("Unknown" ,8))));
  
End:
  ET->BodyOut( OldJmp );
}

/**** File: stat-ex.kb , Line 352 , Topic : NumberPopulation ****/

void B_NumberPopulation ( Topic* ET )
{ 
  CB Jmp,* OldJmp;
  if (Catch(Jmp))
    goto End;
  
  OldJmp = ET->BodyIn(&Jmp);
  
  // ask ('What is the number of Population ? ',NumberPopulation , ['One Population','Two Populations', 'More than two Populations']).	
  FindTopic(__Ask)->DoBody(
    new VN(3,
      new VN("What is the number of Population ? " ,36),
      new VN("NumberPopulation" ,17),
      new VN(3,
        new VN("One Population" ,15),
        new VN("Two Populations" ,16),
        new VN("More than two Populations" ,26))));
  
End:
  ET->BodyOut( OldJmp );
}

/**** File: stat-ex.kb , Line 356 , Topic : KindOfTest1 ****/

void B_KindOfTest1 ( Topic* ET )
{ 
  CB Jmp,* OldJmp;
  if (Catch(Jmp))
    goto End;
  
  OldJmp = ET->BodyIn(&Jmp);
  
  // ask ('Which kind of Parameters  do you want to test : ', KindOfTest1, [Population, Distribution, 'Relationship between Variables']). 
  FindTopic(__Ask)->DoBody(
    new VN(3,
      new VN("Which kind of Parameters  do you want to test : " ,49),
      new VN("KindOfTest1" ,12),
      new VN(3,
        new VN("Population" ,11),
        new VN("Distribution" ,13),
        new VN("Relationship between Variables" ,31))));
  
End:
  ET->BodyOut( OldJmp );
}

/**** File: stat-ex.kb , Line 360 , Topic : KindOfTest2 ****/

void B_KindOfTest2 ( Topic* ET )
{ 
  CB Jmp,* OldJmp;
  if (Catch(Jmp))
    goto End;
  
  OldJmp = ET->BodyIn(&Jmp);
  
  // (*	KindOfTest2 is Mean.*)
  // 			        ask ('Which kind of Parameters  do you want to test : ', KindOfTest2, [Mean, Proportion, Variance]). 
  FindTopic(__Ask)->DoBody(
    new VN(3,
      new VN("Which kind of Parameters  do you want to test : " ,49),
      new VN("KindOfTest2" ,12),
      new VN(3,
        new VN("Mean" ,5),
        new VN("Proportion" ,11),
        new VN("Variance" ,9))));
  
End:
  ET->BodyOut( OldJmp );
}

/**** File: stat-ex.kb , Line 366 , Topic : variance_known ****/

void B_Variance_Known ( Topic* ET )
{ 
  CB Jmp,* OldJmp;
  if (Catch(Jmp))
    goto End;
  
  OldJmp = ET->BodyIn(&Jmp);
  
  // ask ('The Variance of Population are : ', variance_known, [Known, UnKnown]). 
  FindTopic(__Ask)->DoBody(
    new VN(3,
      new VN("The Variance of Population are : " ,34),
      new VN("variance_known" ,15),
      new VN(2,
        new VN("Known" ,6),
        new VN("UnKnown" ,8))));
  
End:
  ET->BodyOut( OldJmp );
}

/**** File: stat-ex.kb , Line 370 , Topic : samplesize ****/

void B_Samplesize ( Topic* ET )
{ 
  CB Jmp,* OldJmp;
  if (Catch(Jmp))
    goto End;
  
  OldJmp = ET->BodyIn(&Jmp);
  
  // ask ('What is the Size of sample taken ? ', samplesize, ['n <= 30', 'n > 30']). 
  FindTopic(__Ask)->DoBody(
    new VN(3,
      new VN("What is the Size of sample taken ? " ,36),
      new VN("samplesize" ,11),
      new VN(2,
        new VN("n <= 30" ,8),
        new VN("n > 30" ,7))));
  
End:
  ET->BodyOut( OldJmp );
}

