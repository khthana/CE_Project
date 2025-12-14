/**** File: stat-ex.kb , Line 88 , Topic : exp1 ****/

void B_Exp1 ( Topic* ET )
{ 
  CB Jmp,* OldJmp;
  if (Catch(Jmp))
    goto End;
  
  OldJmp = ET->BodyIn(&Jmp);
  
  // (* Rule 1*)
  // 					text('#e Because you have answered me that:
  // 	- You want to test about #fred population#d
  // 	- #fred And #dnumber of population is #fred One #d
  // 	- #fred And #d the parameter you want to test is #fred Mean of Population#d
  // 	- #fred And #d the variance is #fred known#d. So the Z-test is appropriate. '). 
  FindTopic(__Text)->DoBody(
    new VN(1,new VN("#e Because you have answered me that:\n\t- You want to te"
                    "st about #fred population#d\n\t- #fred And #dnumber of p"
                    "opulation is #fred One #d\n\t- #fred And #d the paramete"
                    "r you want to test is #fred Mean of Population#d\n\t- #f"
                    "red And #d the variance is #fred known#d. So the Z-test "
                    "is appropriate. " ,298)));
  
  // reset([type_explain,&Consultant,TypeOfTesting]). 
  FindTopic(__Reset)->DoBody(
    new VN(1,new VN(3,
      new VN("type_explain" ,13),
      new VN("&Consultant" ,12),
      new VN("TypeOfTesting" ,14))));
  
  // button(OK,continue_ve,10,9). 
  FindTopic(__Button)->DoBody(
    new VN(4,
      new VN("OK" ,3),
      new VN("continue_ve" ,12),
      new VN(10.0),
      new VN(9.0)));
  
  // wait().	
  FindTopic(__Wait)->DoBody(
    vnNL);
  
  // do (continue_ve). 
  FindTopic(__Do)->DoBody(
    new VN(1,new VN("continue_ve" ,12)));
  
End:
  ET->BodyOut( OldJmp );
}

/**** File: stat-ex.kb , Line 101 , Topic : exp2 ****/

void B_Exp2 ( Topic* ET )
{ 
  CB Jmp,* OldJmp;
  if (Catch(Jmp))
    goto End;
  
  OldJmp = ET->BodyIn(&Jmp);
  
  // (* Rule 2*)
  // 					text('#e Because you have answered me that:
  // 	- You want to test about #fred population#d
  // 	- #fred And #dnumber of population is #fred One #d
  // 	- #fred And #d the parameter you want to test is #fred Mean of Population#d
  // 	- #fred And #d the variance is #fred Unknown#d and sample size is #fred less than 30#d. So the t-test is appropriate. '). 
  FindTopic(__Text)->DoBody(
    new VN(1,new VN("#e Because you have answered me that:\n\t- You want to te"
                    "st about #fred population#d\n\t- #fred And #dnumber of p"
                    "opulation is #fred One #d\n\t- #fred And #d the paramete"
                    "r you want to test is #fred Mean of Population#d\n\t- #f"
                    "red And #d the variance is #fred Unknown#d and sample si"
                    "ze is #fred less than 30#d. So the t-test is appropriate"
                    ". " ,340)));
  
  // reset([type_explain,&Consultant,TypeOfTesting]). 
  FindTopic(__Reset)->DoBody(
    new VN(1,new VN(3,
      new VN("type_explain" ,13),
      new VN("&Consultant" ,12),
      new VN("TypeOfTesting" ,14))));
  
  // button(OK,continue_ve,10,9). 
  FindTopic(__Button)->DoBody(
    new VN(4,
      new VN("OK" ,3),
      new VN("continue_ve" ,12),
      new VN(10.0),
      new VN(9.0)));
  
  // wait().	
  FindTopic(__Wait)->DoBody(
    vnNL);
  
  // do (continue_ve). 
  FindTopic(__Do)->DoBody(
    new VN(1,new VN("continue_ve" ,12)));
  
End:
  ET->BodyOut( OldJmp );
}

/**** File: stat-ex.kb , Line 114 , Topic : exp3 ****/

void B_Exp3 ( Topic* ET )
{ 
  CB Jmp,* OldJmp;
  if (Catch(Jmp))
    goto End;
  
  OldJmp = ET->BodyIn(&Jmp);
  
  // (* Rule 3*)
  // 					text('#e Because you have answered me that:
  // 	- You want to test about #fred population#d
  // 	- #fred And #dnumber of population is #fred One #d
  // 	- #fred And #d the parameter you want to test is #fred Mean of Population#d
  // 	- #fred And #d the variance is #fred Unknown#d and sample size is #fred bigger than 30#d. 
  // 	  So the Z-test is appropriate. '). 
  FindTopic(__Text)->DoBody(
    new VN(1,new VN("#e Because you have answered me that:\n\t- You want to te"
                    "st about #fred population#d\n\t- #fred And #dnumber of p"
                    "opulation is #fred One #d\n\t- #fred And #d the paramete"
                    "r you want to test is #fred Mean of Population#d\n\t- #f"
                    "red And #d the variance is #fred Unknown#d and sample si"
                    "ze is #fred bigger than 30#d. \n\t  So the Z-test is app"
                    "ropriate. " ,348)));
  
  // reset([type_explain,&Consultant,TypeOfTesting]). 
  FindTopic(__Reset)->DoBody(
    new VN(1,new VN(3,
      new VN("type_explain" ,13),
      new VN("&Consultant" ,12),
      new VN("TypeOfTesting" ,14))));
  
  // button(OK,continue_ve,10,9). 
  FindTopic(__Button)->DoBody(
    new VN(4,
      new VN("OK" ,3),
      new VN("continue_ve" ,12),
      new VN(10.0),
      new VN(9.0)));
  
  // wait().	
  FindTopic(__Wait)->DoBody(
    vnNL);
  
  // do (continue_ve). 
  FindTopic(__Do)->DoBody(
    new VN(1,new VN("continue_ve" ,12)));
  
End:
  ET->BodyOut( OldJmp );
}

/**** File: stat-ex.kb , Line 127 , Topic : exp4 ****/

void B_Exp4 ( Topic* ET )
{ 
  CB Jmp,* OldJmp;
  if (Catch(Jmp))
    goto End;
  
  OldJmp = ET->BodyIn(&Jmp);
  
  // (* Rule 4*)
  // 					text('#e Because you have answered me that:
  // 	- You want to test about #fred population#d
  // 	- #fred And #dnumber of population is #fred Two #d
  // 	- #fred And #d the parameter you want to test is #fred Mean of Population#d
  // 	- #fred And #d the sampling is taken by #fred Paired Comparison#d
  // 	- #fred And #d the sample size is #fred bigger than 30 -  (Apply Central Limit Theorem #d).
  // 	 So the Z-test using Paired Comparison is appropriate. '). 
  FindTopic(__Text)->DoBody(
    new VN(1,new VN("#e Because you have answered me that:\n\t- You want to te"
                    "st about #fred population#d\n\t- #fred And #dnumber of p"
                    "opulation is #fred Two #d\n\t- #fred And #d the paramete"
                    "r you want to test is #fred Mean of Population#d\n\t- #f"
                    "red And #d the sampling is taken by #fred Paired Compari"
                    "son#d\n\t- #fred And #d the sample size is #fred bigger "
                    "than 30 -  (Apply Central Limit Theorem #d).\n\t So the "
                    "Z-test using Paired Comparison is appropriate. " ,441)));
  
  // reset([type_explain,&Consultant,TypeOfTesting]). 
  FindTopic(__Reset)->DoBody(
    new VN(1,new VN(3,
      new VN("type_explain" ,13),
      new VN("&Consultant" ,12),
      new VN("TypeOfTesting" ,14))));
  
  // button(OK,continue_ve,10,9). 
  FindTopic(__Button)->DoBody(
    new VN(4,
      new VN("OK" ,3),
      new VN("continue_ve" ,12),
      new VN(10.0),
      new VN(9.0)));
  
  // wait().	
  FindTopic(__Wait)->DoBody(
    vnNL);
  
  // do (continue_ve). 
  FindTopic(__Do)->DoBody(
    new VN(1,new VN("continue_ve" ,12)));
  
End:
  ET->BodyOut( OldJmp );
}

/**** File: stat-ex.kb , Line 141 , Topic : exp5 ****/

void B_Exp5 ( Topic* ET )
{ 
  CB Jmp,* OldJmp;
  if (Catch(Jmp))
    goto End;
  
  OldJmp = ET->BodyIn(&Jmp);
  
  // (* Rule 5*)
  // 					text('#e Because you have answered me that:
  // 	- You want to test about #fred population#d
  // 	- #fred And #dnumber of population is #fred Two #d
  // 	- #fred And #d the parameter you want to test is #fred Mean of Population#d
  // 	- #fred And #d the sampling is taken by #fred Independently#d
  // 	- #fred And #d the  sample size is #fred bigger than 30 -  (Apply Central Limit Theorem #d). 
  // 	So the Z-test using Independent Sampling is appropriate. '). 
  FindTopic(__Text)->DoBody(
    new VN(1,new VN("#e Because you have answered me that:\n\t- You want to te"
                    "st about #fred population#d\n\t- #fred And #dnumber of p"
                    "opulation is #fred Two #d\n\t- #fred And #d the paramete"
                    "r you want to test is #fred Mean of Population#d\n\t- #f"
                    "red And #d the sampling is taken by #fred Independently#"
                    "d\n\t- #fred And #d the  sample size is #fred bigger tha"
                    "n 30 -  (Apply Central Limit Theorem #d). \n\tSo the Z-t"
                    "est using Independent Sampling is appropriate. " ,441)));
  
  // reset([type_explain,&Consultant,TypeOfTesting]). 
  FindTopic(__Reset)->DoBody(
    new VN(1,new VN(3,
      new VN("type_explain" ,13),
      new VN("&Consultant" ,12),
      new VN("TypeOfTesting" ,14))));
  
  // button(OK,continue_ve,10,9). 
  FindTopic(__Button)->DoBody(
    new VN(4,
      new VN("OK" ,3),
      new VN("continue_ve" ,12),
      new VN(10.0),
      new VN(9.0)));
  
  // wait().	
  FindTopic(__Wait)->DoBody(
    vnNL);
  
  // do (continue_ve). 
  FindTopic(__Do)->DoBody(
    new VN(1,new VN("continue_ve" ,12)));
  
End:
  ET->BodyOut( OldJmp );
}

/**** File: stat-ex.kb , Line 155 , Topic : exp6 ****/

void B_Exp6 ( Topic* ET )
{ 
  CB Jmp,* OldJmp;
  if (Catch(Jmp))
    goto End;
  
  OldJmp = ET->BodyIn(&Jmp);
  
  // (* Rule 6*)
  // 					text('#e Because you have answered me that:
  // 	- You want to test about #fred population#d
  // 	- #fred And #dnumber of populations is #fred More than Two #d
  // 	- #fred And #d the parameter you want to test is #fred Mean of Population#d
  // 	- #fred And #d the sampling is taken by #fred Independently#d
  // 	- #fred And #d the population distribution is  #fred Normal#d
  // 	- #fred And #d the variances are assumed #fred Equally#d.  So the ANOVA is appropriate. '). 
  FindTopic(__Text)->DoBody(
    new VN(1,new VN("#e Because you have answered me that:\n\t- You want to te"
                    "st about #fred population#d\n\t- #fred And #dnumber of p"
                    "opulations is #fred More than Two #d\n\t- #fred And #d t"
                    "he parameter you want to test is #fred Mean of Populatio"
                    "n#d\n\t- #fred And #d the sampling is taken by #fred Ind"
                    "ependently#d\n\t- #fred And #d the population distributi"
                    "on is  #fred Normal#d\n\t- #fred And #d the variances ar"
                    "e assumed #fred Equally#d.  So the ANOVA is appropriate."
                    " " ,451)));
  
  // reset([type_explain,&Consultant,TypeOfTesting]). 
  FindTopic(__Reset)->DoBody(
    new VN(1,new VN(3,
      new VN("type_explain" ,13),
      new VN("&Consultant" ,12),
      new VN("TypeOfTesting" ,14))));
  
  // button(OK,continue_ve,10,9). 
  FindTopic(__Button)->DoBody(
    new VN(4,
      new VN("OK" ,3),
      new VN("continue_ve" ,12),
      new VN(10.0),
      new VN(9.0)));
  
  // wait().	
  FindTopic(__Wait)->DoBody(
    vnNL);
  
  // do (continue_ve). 
  FindTopic(__Do)->DoBody(
    new VN(1,new VN("continue_ve" ,12)));
  
End:
  ET->BodyOut( OldJmp );
}

/**** File: stat-ex.kb , Line 169 , Topic : exp7 ****/

void B_Exp7 ( Topic* ET )
{ 
  CB Jmp,* OldJmp;
  if (Catch(Jmp))
    goto End;
  
  OldJmp = ET->BodyIn(&Jmp);
  
  // (* Rule 7*)
  // 					text('#e Because you have answered me that:
  // 	- You want to test about #fred population#d
  // 	- #fred And #dnumber of populations is #fred More than Two #d
  // 	- #fred And #d the parameter you want to test is #fred Mean of Population#d
  // 	- #fred And #d the sampling is taken by #fred Independently#d
  // 	- #fred And #d the population distribution is  #fred Not Normal#d
  // 	- #fred Or #d the variances are #fred Not Equal#d.  
  // 	So the ANOVA is not appropriate, you have to use Non-Parametric ANOVA. '). 
  FindTopic(__Text)->DoBody(
    new VN(1,new VN("#e Because you have answered me that:\n\t- You want to te"
                    "st about #fred population#d\n\t- #fred And #dnumber of p"
                    "opulations is #fred More than Two #d\n\t- #fred And #d t"
                    "he parameter you want to test is #fred Mean of Populatio"
                    "n#d\n\t- #fred And #d the sampling is taken by #fred Ind"
                    "ependently#d\n\t- #fred And #d the population distributi"
                    "on is  #fred Not Normal#d\n\t- #fred Or #d the variances"
                    " are #fred Not Equal#d.  \n\tSo the ANOVA is not appropr"
                    "iate, you have to use Non-Parametric ANOVA. " ,494)));
  
  // reset([type_explain,&Consultant,TypeOfTesting]). 
  FindTopic(__Reset)->DoBody(
    new VN(1,new VN(3,
      new VN("type_explain" ,13),
      new VN("&Consultant" ,12),
      new VN("TypeOfTesting" ,14))));
  
  // button(OK,continue_ve,10,9). 
  FindTopic(__Button)->DoBody(
    new VN(4,
      new VN("OK" ,3),
      new VN("continue_ve" ,12),
      new VN(10.0),
      new VN(9.0)));
  
  // wait().	
  FindTopic(__Wait)->DoBody(
    vnNL);
  
  // do (continue_ve). 
  FindTopic(__Do)->DoBody(
    new VN(1,new VN("continue_ve" ,12)));
  
End:
  ET->BodyOut( OldJmp );
}

/**** File: stat-ex.kb , Line 185 , Topic : exp9 ****/

void B_Exp9 ( Topic* ET )
{ 
  CB Jmp,* OldJmp;
  if (Catch(Jmp))
    goto End;
  
  OldJmp = ET->BodyIn(&Jmp);
  
  // (* Rule 9*)
  // 					text('#e Because you have answered me that:
  // 	- You want to test about #fred population#d
  // 	- #fred And #dnumber of population is #fred Two #d
  // 	- #fred And #d the parameter you want to test is #fred Mean of Population#d
  // 	- #fred And #d the sampling is taken by #fred Paired Comparison#d
  // 	- #fred And #d the population distribution is  #fred Normal#d
  // 	- #fred And #d the variance is #fred Known#d  
  // 	 So the Z - test for two Normal, known Variance  Populations - 
  // 		using Paired Comparison sampling is appropriate'). 
  FindTopic(__Text)->DoBody(
    new VN(1,new VN("#e Because you have answered me that:\n\t- You want to te"
                    "st about #fred population#d\n\t- #fred And #dnumber of p"
                    "opulation is #fred Two #d\n\t- #fred And #d the paramete"
                    "r you want to test is #fred Mean of Population#d\n\t- #f"
                    "red And #d the sampling is taken by #fred Paired Compari"
                    "son#d\n\t- #fred And #d the population distribution is  "
                    "#fred Normal#d\n\t- #fred And #d the variance is #fred K"
                    "nown#d  \n\t So the Z - test for two Normal, known Varia"
                    "nce  Populations - \n\t\tusing Paired Comparison samplin"
                    "g is appropriate" ,522)));
  
  // reset([type_explain,&Consultant,TypeOfTesting]). 
  FindTopic(__Reset)->DoBody(
    new VN(1,new VN(3,
      new VN("type_explain" ,13),
      new VN("&Consultant" ,12),
      new VN("TypeOfTesting" ,14))));
  
  // button(OK,continue_ve,10,9). 
  FindTopic(__Button)->DoBody(
    new VN(4,
      new VN("OK" ,3),
      new VN("continue_ve" ,12),
      new VN(10.0),
      new VN(9.0)));
  
  // wait().	
  FindTopic(__Wait)->DoBody(
    vnNL);
  
  // do (continue_ve). 
  FindTopic(__Do)->DoBody(
    new VN(1,new VN("continue_ve" ,12)));
  
End:
  ET->BodyOut( OldJmp );
}

/**** File: stat-ex.kb , Line 201 , Topic : exp10 ****/

void B_Exp10 ( Topic* ET )
{ 
  CB Jmp,* OldJmp;
  if (Catch(Jmp))
    goto End;
  
  OldJmp = ET->BodyIn(&Jmp);
  
  // (* Rule 10*)
  // 					text('#e Because you have answered me that:
  // 	- You want to test about #fred population#d
  // 	- #fred And #dnumber of population is #fred Two #d
  // 	- #fred And #d the parameter you want to test is #fred Mean of Population#d
  // 	- #fred And #d the sampling is taken by #fred Paired Comparison#d
  // 	- #fred And #d the population distribution is  #fred Normal#d
  // 	- #fred And #d the variance is #fred UnKnown#d  and Sample size is #fred less than 30#d.
  // 	 So the t-test using Paired Comparison Sampling is appropriate. '). 
  FindTopic(__Text)->DoBody(
    new VN(1,new VN("#e Because you have answered me that:\n\t- You want to te"
                    "st about #fred population#d\n\t- #fred And #dnumber of p"
                    "opulation is #fred Two #d\n\t- #fred And #d the paramete"
                    "r you want to test is #fred Mean of Population#d\n\t- #f"
                    "red And #d the sampling is taken by #fred Paired Compari"
                    "son#d\n\t- #fred And #d the population distribution is  "
                    "#fred Normal#d\n\t- #fred And #d the variance is #fred U"
                    "nKnown#d  and Sample size is #fred less than 30#d.\n\t S"
                    "o the t-test using Paired Comparison Sampling is appropr"
                    "iate. " ,512)));
  
  // reset([type_explain,&Consultant,TypeOfTesting]). 
  FindTopic(__Reset)->DoBody(
    new VN(1,new VN(3,
      new VN("type_explain" ,13),
      new VN("&Consultant" ,12),
      new VN("TypeOfTesting" ,14))));
  
  // button(OK,continue_ve,10,9). 
  FindTopic(__Button)->DoBody(
    new VN(4,
      new VN("OK" ,3),
      new VN("continue_ve" ,12),
      new VN(10.0),
      new VN(9.0)));
  
  // wait().	
  FindTopic(__Wait)->DoBody(
    vnNL);
  
  // do (continue_ve). 
  FindTopic(__Do)->DoBody(
    new VN(1,new VN("continue_ve" ,12)));
  
End:
  ET->BodyOut( OldJmp );
}

/**** File: stat-ex.kb , Line 217 , Topic : exp11 ****/

void B_Exp11 ( Topic* ET )
{ 
  CB Jmp,* OldJmp;
  if (Catch(Jmp))
    goto End;
  
  OldJmp = ET->BodyIn(&Jmp);
  
  // (* Rule 11*)
  // 					text('#e Because you have answered me that:
  // 	- You want to test about #fred population#d
  // 	- #fred And #dnumber of population is #fred Two #d
  // 	- #fred And #d the parameter you want to test is #fred Mean of Population#d
  // 	- #fred And #d the sampling is taken by #fred Independent Sampling#d
  // 	- #fred And #d the population distribution is  #fred Normal#d
  // 	- #fred And #d the variance is #fred UnKnown#d  and Sample size is #fred less than 30#d.
  // 	 So the t-test using Independent Sampling is appropriate. '). 
  FindTopic(__Text)->DoBody(
    new VN(1,new VN("#e Because you have answered me that:\n\t- You want to te"
                    "st about #fred population#d\n\t- #fred And #dnumber of p"
                    "opulation is #fred Two #d\n\t- #fred And #d the paramete"
                    "r you want to test is #fred Mean of Population#d\n\t- #f"
                    "red And #d the sampling is taken by #fred Independent Sa"
                    "mpling#d\n\t- #fred And #d the population distribution i"
                    "s  #fred Normal#d\n\t- #fred And #d the variance is #fre"
                    "d UnKnown#d  and Sample size is #fred less than 30#d.\n\t"
                    " So the t-test using Independent Sampling is appropriate"
                    ". " ,509)));
  
  // reset([type_explain,&Consultant,TypeOfTesting]). 
  FindTopic(__Reset)->DoBody(
    new VN(1,new VN(3,
      new VN("type_explain" ,13),
      new VN("&Consultant" ,12),
      new VN("TypeOfTesting" ,14))));
  
  // button(OK,continue_ve,10,9). 
  FindTopic(__Button)->DoBody(
    new VN(4,
      new VN("OK" ,3),
      new VN("continue_ve" ,12),
      new VN(10.0),
      new VN(9.0)));
  
  // wait().	
  FindTopic(__Wait)->DoBody(
    vnNL);
  
  // do (continue_ve). 
  FindTopic(__Do)->DoBody(
    new VN(1,new VN("continue_ve" ,12)));
  
End:
  ET->BodyOut( OldJmp );
}

/**** File: stat-ex.kb , Line 233 , Topic : continue_ve ****/

void B_Continue_Ve ( Topic* ET )
{ 
  CB Jmp,* OldJmp;
  if (Catch(Jmp))
    goto End;
  
  OldJmp = ET->BodyIn(&Jmp);
  
  // close_window(). 
  FindTopic(__Close_Window)->DoBody(
    vnNL);
  
End:
  ET->BodyOut( OldJmp );
}

