/**** File: stat-ex.kb , Line 1 , Topic : !main ****/

void B_Main ( Topic* ET )
{ 
  CB Jmp,* OldJmp;
  if (Catch(Jmp))
    return;
  OldJmp = ET->pExit;
  ET->pExit=&Jmp;
  
  
  // (* ============================= STAT-EX.KB ===============================
  //    This application is a rule-based approach to a problem regarding
  //    Statistic Tetsting Hypothesis assistance.
  // 
  //    Developer:	Mr. Ho Thanh Phong
  //    Instructor:	Dr. Vatcharaporn
  // 		SAT - AIT	
  // =========================================================================*)
  // 
  //  menu ( [ [&File, &New, &Save,[], &Exit], &Consultant,&Testing ,&Help,&Quit ],GetOption). 
  FindTopic(__Menu)->DoBody(
    new VN(2,
      new VN(5,
        new VN(5,
          new VN("&File" ,6),
          new VN("&New" ,5),
          new VN("&Save" ,6),
          vnNL,
          new VN("&Exit" ,6)),
        new VN("&Consultant" ,12),
        new VN("&Testing" ,9),
        new VN("&Help" ,6),
        new VN("&Quit" ,6)),
      new VN("GetOption" ,10)));
  
  // text ('#fred  
  // 
  // 
  // 
  // 
  // 
  // 
  // 		Statistic Tetsting Hypothesis assistance
  // 
  // 
  // 
  // 
  // 
  // 		Developer:	Mr. Ho Thanh Phong 
  // 		Instructor:	Dr. Vatcharaporn
  // 				SAT - AIT	
  // 
  // ' ). 
  FindTopic(__Text)->DoBody(
    new VN(1,new VN("#fred  \n\n\n\n\n\n\n\t\tStatistic Tetsting Hypothesis as"
                    "sistance\n\n\n\n\n\n\t\tDeveloper:\tMr. Ho Thanh Phong \n"
                    "\t\tInstructor:\tDr. Vatcharaporn\n\t\t\t\tSAT - AIT\t\n"
                    "\n" ,173)));
  
End:
  ET->pExit = OldJmp;
  return;
}

