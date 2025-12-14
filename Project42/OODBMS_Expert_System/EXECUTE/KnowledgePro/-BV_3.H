/**** File: stat-ex.kb , Line 34 , Topic : &Quit ****/

void B_Quit ( Topic* ET )
{ 
  CB Jmp,* OldJmp;
  if (Catch(Jmp))
    goto End;
  
  OldJmp = ET->BodyIn(&Jmp);
  
  // exit_kp(). 
  FindTopic(__Exit_Kp)->DoBody(
    vnNL);
  
End:
  ET->BodyOut( OldJmp );
}

/**** File: stat-ex.kb , Line 37 , Topic : &File WAS EMPTY ****/ 

/**** File: stat-ex.kb , Line 41 , Topic : &Consultant ****/

void B_Consultant ( Topic* ET )
{ 
  CB Jmp,* OldJmp;
  if (Catch(Jmp))
    goto End;
  
  OldJmp = ET->BodyIn(&Jmp);
  
  // if NOT(exists(w1)) 
  // 		 then 
  if (IsTrue(ReUse(FindTopic(__Not)->DoBody(
    new VN(1,ReUse(FindTopic(__Exists)->DoBody(
      new VN(1,new VN("w1" ,3)))))))))
  { 
    
    // w1 is window (,5,4,85,13,'Working Window',[overlapped,disabled,thickFrame] ). 
    FindTopicCreate("w1" ,-1)->MAKE1(ReUse(FindTopic(__Window)->DoBody(
      new VN(7,
        vnNL,new VN(5.0),
        new VN(4.0),
        new VN(85.0),
        new VN(13.0),
        new VN("Working Window" ,15),
        new VN(3,
          new VN("overlapped" ,11),
          new VN("disabled" ,9),
          new VN("thickFrame" ,11))))));
  }
  
  // (* *)
  // 		type_explain=?TypeOfTesting. 
  FindTopicCreate("type_explain" ,-1)->MAKE1(FindTopic("TypeOfTesting" ,-1)->TV());
  
  // text ('#e The type of Testing Hypothesis should be:   #s#fred', ?type_explain). 
  FindTopic(__Text)->DoBody(
    new VN(2,
      new VN("#e The type of Testing Hypothesis should be:   #s#fred" ,55),
      FindTopic("type_explain" ,-1)->TV()));
  
  // text('#n#n#n Do you want to know WHY  I give you this recommendation ?'). 
  FindTopic(__Text)->DoBody(
    new VN(1,new VN("#n#n#n Do you want to know WHY  I give you this recommend"
                    "ation ?" ,65)));
  
  // bt_ask is button(No,retu,12,6,,t). 
  FindTopicCreate("bt_ask" ,-1)->MAKE1(ReUse(FindTopic(__Button)->DoBody(
    new VN(6,
      new VN("No" ,3),
      new VN("retu" ,5),
      new VN(12.0),
      new VN(6.0),
      vnNL,new VN("t" ,2)))));
  
  // button (Yes,retu). 
  FindTopic(__Button)->DoBody(
    new VN(2,
      new VN("Yes" ,4),
      new VN("retu" ,5)));
  
  // set_focus(?bt_ask). 
  FindTopic(__Set_Focus)->DoBody(
    new VN(1,FindTopic("bt_ask" ,-1)->TV()));
  
End:
  ET->BodyOut( OldJmp );
}

/**** File: stat-ex.kb , Line 240 , Topic : TypeOfTesting ****/

void B_TypeOfTesting ( Topic* ET )
{ 
  CB Jmp,* OldJmp;
  if (Catch(Jmp))
    goto End;
  
  OldJmp = ET->BodyIn(&Jmp);
  
  // window(?w1). 
  FindTopic(__Window)->DoBody(
    new VN(1,FindTopic("w1" ,-1)->TV()));
  
  // set_number_of_values (TypeOfTesting,1). 
  FindTopic(__Set_Number_Of_Values)->DoBody(
    new VN(2,
      new VN("TypeOfTesting" ,14),
      new VN(1.0)));
  
  // (* Rule 1*)
  // 			if ?KindOfTest1 is Population and
  // 			 ?NumberPopulation is 'One Population' and
  // 			 ?KindOfTest2 is Mean and
  // 			 ?variance_known is Known
  // 			then 
  if ((((bEQU(
    FindTopic("KindOfTest1" ,-1)->TV(),
    new VN("Population" ,11)) && bEQU(
    FindTopic("NumberPopulation" ,-1)->TV(),
    new VN("One Population" ,15))) && bEQU(
    FindTopic("KindOfTest2" ,-1)->TV(),
    new VN("Mean" ,5))) && bEQU(
    FindTopic("variance_known" ,-1)->TV(),
    new VN("Known" ,6))))
  { 
    
    // TypeOfTesting  is  'Z - test for one Population'. 
    FindTopicCreate("TypeOfTesting" ,-2)->MAKE1(new VN("Z - test for one Population" ,28));
  }
  
  // (* Rule 2*)
  // 			if ?KindOfTest1 is Population and
  // 			 ?NumberPopulation is 'One Population' and
  // 			 ?KindOfTest2 is Mean and
  // 			 ?variance_known is UnKnown and
  // 			 ?samplesize is 'n <= 30'
  // 			then 
  if (((((bEQU(
    FindTopic("KindOfTest1" ,-1)->TV(),
    new VN("Population" ,11)) && bEQU(
    FindTopic("NumberPopulation" ,-1)->TV(),
    new VN("One Population" ,15))) && bEQU(
    FindTopic("KindOfTest2" ,-1)->TV(),
    new VN("Mean" ,5))) && bEQU(
    FindTopic("variance_known" ,-1)->TV(),
    new VN("UnKnown" ,8))) && bEQU(
    FindTopic("samplesize" ,-1)->TV(),
    new VN("n <= 30" ,8))))
  { 
    
    // TypeOfTesting  is  't - test for one Population'. 
    FindTopicCreate("TypeOfTesting" ,-2)->MAKE1(new VN("t - test for one Population" ,28));
  }
  
  // (* Rule 3*)
  // 			if ?KindOfTest1 is Population and
  // 			 ?NumberPopulation is 'One Population' and
  // 			 ?KindOfTest2 is Mean and
  // 			 ?variance_known is UnKnown and
  // 			 ?samplesize is 'n > 30'
  // 			then 
  if (((((bEQU(
    FindTopic("KindOfTest1" ,-1)->TV(),
    new VN("Population" ,11)) && bEQU(
    FindTopic("NumberPopulation" ,-1)->TV(),
    new VN("One Population" ,15))) && bEQU(
    FindTopic("KindOfTest2" ,-1)->TV(),
    new VN("Mean" ,5))) && bEQU(
    FindTopic("variance_known" ,-1)->TV(),
    new VN("UnKnown" ,8))) && bEQU(
    FindTopic("samplesize" ,-1)->TV(),
    new VN("n > 30" ,7))))
  { 
    
    // TypeOfTesting  is  'Z - test for one Population- Large Sample size'. 
    FindTopicCreate("TypeOfTesting" ,-2)->MAKE1(new VN(
      "Z - test for one Population- Large Sample size" ,47));
  }
  
  // (* Rule 4*)
  // 			if ?KindOfTest1 is Population and
  // 			 ?NumberPopulation is 'Two Populations' and
  // 			 ?KindOfTest2 is Mean and
  // 			 ?independence is 'Paired Comparison' and
  // 			 ?distribution is Normal or
  // 			 ?distribution is 'Not Normal' or		
  // 			 ?variance_known is Known or
  // 			?variance_known is UnKnown and	 
  // 			 ?samplesize is 'n > 30'
  // 			then 
  if ((((((((bEQU(
    FindTopic("KindOfTest1" ,-1)->TV(),
    new VN("Population" ,11)) && bEQU(
    FindTopic("NumberPopulation" ,-1)->TV(),
    new VN("Two Populations" ,16))) && bEQU(
    FindTopic("KindOfTest2" ,-1)->TV(),
    new VN("Mean" ,5))) && bEQU(
    FindTopic("independence" ,-1)->TV(),
    new VN("Paired Comparison" ,18))) && bEQU(
    FindTopic("distribution" ,-1)->TV(),
    new VN("Normal" ,7))) || bEQU(
    FindTopic("distribution" ,-1)->TV(),
    new VN("Not Normal" ,11))) || bEQU(
    FindTopic("variance_known" ,-1)->TV(),
    new VN("Known" ,6))) || (bEQU(
    FindTopic("variance_known" ,-1)->TV(),
    new VN("UnKnown" ,8)) && bEQU(
    FindTopic("samplesize" ,-1)->TV(),
    new VN("n > 30" ,7)))))
  { 
    
    // TypeOfTesting  is  'Z - test for two Populations - using Paired comparison.'. 
    FindTopicCreate("TypeOfTesting" ,-2)->MAKE1(new VN(
      "Z - test for two Populations - using Paired comparison." ,56));
  }
  
  // (* Rule 5*)
  // 			if ?KindOfTest1 is Population and
  // 			 ?NumberPopulation is 'Two Populations' and
  // 			 ?KindOfTest2 is Mean and
  // 			 ?independence is Independent and
  // 			 ?distribution is Normal or
  // 			  ?distribution is 'Not Normal' or
  // 			 ?variance_known is Known or
  // 			 ?variance_known is UnKnown and
  // 			 ?samplesize is 'n > 30'
  // 			then 
  if ((((((((bEQU(
    FindTopic("KindOfTest1" ,-1)->TV(),
    new VN("Population" ,11)) && bEQU(
    FindTopic("NumberPopulation" ,-1)->TV(),
    new VN("Two Populations" ,16))) && bEQU(
    FindTopic("KindOfTest2" ,-1)->TV(),
    new VN("Mean" ,5))) && bEQU(
    FindTopic("independence" ,-1)->TV(),
    new VN("Independent" ,12))) && bEQU(
    FindTopic("distribution" ,-1)->TV(),
    new VN("Normal" ,7))) || bEQU(
    FindTopic("distribution" ,-1)->TV(),
    new VN("Not Normal" ,11))) || bEQU(
    FindTopic("variance_known" ,-1)->TV(),
    new VN("Known" ,6))) || (bEQU(
    FindTopic("variance_known" ,-1)->TV(),
    new VN("UnKnown" ,8)) && bEQU(
    FindTopic("samplesize" ,-1)->TV(),
    new VN("n > 30" ,7)))))
  { 
    
    // TypeOfTesting  is  'Z - test for two Populations - using Independent sampling.'.	
    FindTopicCreate("TypeOfTesting" ,-2)->MAKE1(new VN(
      "Z - test for two Populations - using Independent sampling." ,59));
  }
  
  // (* Rule 9*)
  // 			if ?KindOfTest1 is Population and
  // 			 ?NumberPopulation is 'Two Populations' and
  // 			 ?KindOfTest2 is Mean and
  // 			 ?independence is 'Paired Comparison' and
  // 			 ?distribution is Normal and
  // 			 ?variance_known is Known
  // 			then 
  if ((((((bEQU(
    FindTopic("KindOfTest1" ,-1)->TV(),
    new VN("Population" ,11)) && bEQU(
    FindTopic("NumberPopulation" ,-1)->TV(),
    new VN("Two Populations" ,16))) && bEQU(
    FindTopic("KindOfTest2" ,-1)->TV(),
    new VN("Mean" ,5))) && bEQU(
    FindTopic("independence" ,-1)->TV(),
    new VN("Paired Comparison" ,18))) && bEQU(
    FindTopic("distribution" ,-1)->TV(),
    new VN("Normal" ,7))) && bEQU(
    FindTopic("variance_known" ,-1)->TV(),
    new VN("Known" ,6))))
  { 
    
    // TypeOfTesting  is  'Z - test for two Normal, known Variance  Populations - using Paired Comparison sampling.'. 
    FindTopicCreate("TypeOfTesting" ,-2)->MAKE1(new VN(
      "Z - test for two Normal, known Variance  Populations - using Paired Com"
      "parison sampling." ,89));
  }
  
  // (* Rule 10*)
  // 			if ?KindOfTest1 is Population and
  // 			 ?NumberPopulation is 'Two Populations' and
  // 			 ?KindOfTest2 is Mean and
  // 			 ?independence is 'Paired Comparison' and
  // 			 ?distribution is Normal and
  // 			 ?variance_known is UnKnown and
  // 			 ?samplesize is 'n <= 30'
  // 			then 
  if (((((((bEQU(
    FindTopic("KindOfTest1" ,-1)->TV(),
    new VN("Population" ,11)) && bEQU(
    FindTopic("NumberPopulation" ,-1)->TV(),
    new VN("Two Populations" ,16))) && bEQU(
    FindTopic("KindOfTest2" ,-1)->TV(),
    new VN("Mean" ,5))) && bEQU(
    FindTopic("independence" ,-1)->TV(),
    new VN("Paired Comparison" ,18))) && bEQU(
    FindTopic("distribution" ,-1)->TV(),
    new VN("Normal" ,7))) && bEQU(
    FindTopic("variance_known" ,-1)->TV(),
    new VN("UnKnown" ,8))) && bEQU(
    FindTopic("samplesize" ,-1)->TV(),
    new VN("n <= 30" ,8))))
  { 
    
    // TypeOfTesting  is  't - test for two Populations - using Paired comparison.'. 
    FindTopicCreate("TypeOfTesting" ,-2)->MAKE1(new VN(
      "t - test for two Populations - using Paired comparison." ,56));
  }
  
  // (* Rule 11*)
  // 			if ?KindOfTest1 is Population and
  // 			 ?NumberPopulation is 'Two Populations' and
  // 			 ?KindOfTest2 is Mean and
  // 			 ?independence is Independent and
  // 			 ?distribution is Normal and
  // 			 ?variance_known is UnKnown and
  // 			 ?samplesize is 'n <= 30'
  // 			then 
  if (((((((bEQU(
    FindTopic("KindOfTest1" ,-1)->TV(),
    new VN("Population" ,11)) && bEQU(
    FindTopic("NumberPopulation" ,-1)->TV(),
    new VN("Two Populations" ,16))) && bEQU(
    FindTopic("KindOfTest2" ,-1)->TV(),
    new VN("Mean" ,5))) && bEQU(
    FindTopic("independence" ,-1)->TV(),
    new VN("Independent" ,12))) && bEQU(
    FindTopic("distribution" ,-1)->TV(),
    new VN("Normal" ,7))) && bEQU(
    FindTopic("variance_known" ,-1)->TV(),
    new VN("UnKnown" ,8))) && bEQU(
    FindTopic("samplesize" ,-1)->TV(),
    new VN("n <= 30" ,8))))
  { 
    
    // TypeOfTesting  is  't - test for two Populations - using Independent sampling'. 
    FindTopicCreate("TypeOfTesting" ,-2)->MAKE1(new VN(
      "t - test for two Populations - using Independent sampling" ,58));
  }
  
  // (* Rule 6*)
  // 			if ?KindOfTest1 is Population and
  // 			 ?NumberPopulation is 'More than two Populations' and
  // 			 ?KindOfTest2 is Mean and
  // 			 ?independence is Independent and	
  // 			 ?distribution is Normal  and
  // 			 ?equal_variance is Equal
  // 			 then 
  if ((((((bEQU(
    FindTopic("KindOfTest1" ,-1)->TV(),
    new VN("Population" ,11)) && bEQU(
    FindTopic("NumberPopulation" ,-1)->TV(),
    new VN("More than two Populations" ,26))) && bEQU(
    FindTopic("KindOfTest2" ,-1)->TV(),
    new VN("Mean" ,5))) && bEQU(
    FindTopic("independence" ,-1)->TV(),
    new VN("Independent" ,12))) && bEQU(
    FindTopic("distribution" ,-1)->TV(),
    new VN("Normal" ,7))) && bEQU(
    FindTopic("equal_variance" ,-1)->TV(),
    new VN("Equal" ,6))))
  { 
    
    // TypeOfTesting  is  'ANOVA  test '. 
    FindTopicCreate("TypeOfTesting" ,-2)->MAKE1(new VN("ANOVA  test " ,13));
  }
  
  // (* Rule 7*)
  // 			if ?KindOfTest1 is Population and
  // 			 ?NumberPopulation is 'More than two Populations' and
  // 			 ?KindOfTest2 is Mean and
  // 			 ?independence is Independent and	
  // 			 ?distribution is 'Not Normal'  or
  // 			 ?equal_variance is 'Not equal'
  // 			 then 
  if ((((((bEQU(
    FindTopic("KindOfTest1" ,-1)->TV(),
    new VN("Population" ,11)) && bEQU(
    FindTopic("NumberPopulation" ,-1)->TV(),
    new VN("More than two Populations" ,26))) && bEQU(
    FindTopic("KindOfTest2" ,-1)->TV(),
    new VN("Mean" ,5))) && bEQU(
    FindTopic("independence" ,-1)->TV(),
    new VN("Independent" ,12))) && bEQU(
    FindTopic("distribution" ,-1)->TV(),
    new VN("Not Normal" ,11))) || bEQU(
    FindTopic("equal_variance" ,-1)->TV(),
    new VN("Not equal" ,10))))
  { 
    
    // TypeOfTesting  is  'Non Parametric ANOVA  test '. 
    FindTopicCreate("TypeOfTesting" ,-2)->MAKE1(new VN("Non Parametric ANOVA  test " ,28));
  }
  
End:
  ET->BodyOut( OldJmp );
}

