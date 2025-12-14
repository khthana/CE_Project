
/* --------------------------------------------------------------------
 * Library.c  16-03-98
 *
 *---------------------------------------------------------------------
 */

#include <stdio.h>
#include <string.h>
#include "libpq-fe.h"

static PGconn*   conn;
static PGresult* res = NULL;

static void exit_nicely(PGconn* conn)
{
  PQfinish(conn);
  exit(1);
}

static void show_data(char *Query)
{
    int i,j,nFields;
    char strTemp[2000] = "DECLARE tempcursor CURSOR FOR ";
 	
    res = PQexec(conn,"BEGIN");
    PQclear(res);		
    strcat(strTemp,Query);
    res = PQexec(conn,strTemp);
    PQclear(res);
    sprintf(strTemp,"FETCH ALL in tempcursor");
    res = PQexec(conn,strTemp);
    nFields = PQnfields(res);
	
    for (i=0;i < nFields;i++) printf("%-11s",PQfname(res,i));
    printf("\n");

    for (i=0;i < PQntuples(res); i++) {
        for(j=0;j < nFields;j++) {
            printf("%-11s",PQgetvalue(res,i,j));
        }
        printf("\n");
    }
    PQclear(res);
    res = PQexec(conn,"CLOSE tempcursor");
    PQclear(res);
    res = PQexec(conn,"END");
    PQclear(res);	
}

void main()
{
    char       ckey,User_ID[9],Book_ID[9],Query[2000];
    char       delkey,Table_Name[15],tempkey; 
    char*      dbname;
    char       Fname[40],Lname[40],Bdate[10],Sex[2];
    char       Major[40],Faculty[40],User_Year[5],Class_Room[3];
    char       Department[40],Mtype[20],Degree[20];
    char       Title[40],Author[40],Edition[4],Publisher[40];
    char       Issue[5],Book_Year[5];
    int        nFields,i,j;	

/*  PGconn*    conn;
    PGresult*  res;
    PGnotify*  notify;
*/
   /* Make a connection to the database */
   dbname = "Library";	
   conn = PQsetdb(NULL,NULL,NULL,NULL,dbname);

   /* Check to see that the backend connection was successfully made. */ 
   if (PQstatus(conn) == CONNECTION_BAD)
   {
        fprintf(stderr,"Connection to database '%s'failed. \n ",dbname);
        fprintf(stderr,"%s",PQerrorMessage(conn));
        exit_nicely(conn);
   }  

   printf("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n");
   printf("===================================================\n");
   printf("=                    MENU                         =\n");
   printf("===================================================\n");
   printf("=           1.Borrow  Book                        =\n");
   printf("=           2.Restore Book                        =\n");          
   printf("=           3.Add User into database              =\n");
   printf("=           4.Add Book into database              =\n");
   printf("=           5.Show data in user                   =\n");
   printf("=           6.Show data in book                   =\n");	
   printf("=           7.Exit                                =\n");		
   printf("===================================================\n");
   printf("\n\n\n\n\n\n");
   printf("Press number [1,2,3,4,5,6,7] to process : ");
   ckey = getchar(); 
   while (ckey != '7')
   {
	if (ckey == '1') 
	{
	    while(1)
	    {
		/* Borrow BOOK */
		printf("=========================================================\n");
		printf("=                Press enter to continue                =");
		printf("\n=========================================================\n");
		delkey = getchar();
		printf("\n User ID : ");
		gets(User_ID);
		res = PQexec(conn,"BEGIN");
		PQclear(res);
	
		sprintf(Query,"select * from users* where u_id = '%s';",User_ID);
	        res = PQexec(conn,Query);

		if (PQresultStatus(res) != PGRES_TUPLES_OK)
		{
		    fprintf(stderr,"FETCH ALL command didn't return tuples properly \n");  			
  		    PQclear(res);
		    exit_nicely(conn);
		}
	   	nFields = PQnfields(res);
		sprintf(Table_Name,"12345678901234");
		if (PQntuples(res) > 0 )
		{
		    PQclear(res);
		    while(1)
		    {
			printf(" Book ID : ");
			gets(Book_ID);				
			sprintf(Query,"select * from book* where book_id = '%s';",Book_ID);
			res = PQexec(conn,Query);
			if (PQntuples(res) > 0)
			{
			    PQclear(res);
			    sprintf(Query,"select * from text_book where book_id = '%s';",Book_ID);
			    res = PQexec(conn,Query);
			    if (PQntuples(res) > 0)
			    {
		    		sprintf(Query,"select * from Bachelor where u_id = '%s';",User_ID);
		    		res = PQexec(conn,Query);
		    		if  (PQntuples(res) > 0 )
		    		{
				    sprintf(Table_Name,"Bachelor");
		    		}
		    		PQclear(res);
		    		sprintf(Query,"select * from Master_Degree where u_id = '%s';",User_ID);
		    		res = PQexec(conn,Query);
		    		if (PQntuples(res) > 0 )
		    		{
				    sprintf(Table_Name,"Master_Degree");
		    		}	    
		
		    		PQclear(res);		    
 		    		sprintf(Query,"select * from Student where u_id = '%s';",User_ID);
		    		res = PQexec(conn,Query);
		    		if (PQntuples(res) > 0 ) 
		    		{
				    sprintf(Table_Name,"Student");
		   
		    		}
		    		PQclear(res);

		    		sprintf(Query,"select * from Teacher where u_id = '%s';",User_ID);	
		    		res = PQexec(conn,Query);
		    		if (PQntuples(res) > 0)
		    		{
				    sprintf(Table_Name,"Teacher");
		    		}	
		    		PQclear(res);

		    		sprintf(Query,"select * from Users where u_id = '%s';",User_ID);
		    		res = PQexec(conn,Query);
		    		if (PQntuples(res) > 0)
		    		{
				     sprintf(Table_Name,"Users");
		    		}
		    		PQclear(res);
    
				/* Show Dataname */
		    		printf("\n Table Name = %s \n ",Table_Name);
		    		if (Table_Name != "12345678901234")
		    		{
				    sprintf(Query,"select Borrow(%s,'%s','%s',
				    'now') from %s;",Table_Name,User_ID,
				    Book_ID,Table_Name);	
				    res = PQexec(conn,Query);
	 			    PQclear(res);

				    sprintf(Query,"DECLARE myportal CURSOR FOR select Book_ID,Title,StartDate,Amount,U_ID from text_book where U_ID = '%s';",User_ID);
				    res = PQexec(conn,Query);  
				    PQclear(res);
				    printf("Query : %s \n",Query);

				    sprintf(Query,"FETCH ALL in myportal");
				    res = PQexec(conn,Query);
				    nFields = PQnfields(res);	
		        	
	 	        	    for (i=0;i < nFields;i++)
		        	    {
		            		printf("%-15s",PQfname(res,i));
		    		    }
		    		    printf("\n");

		    		    for (i=0;i < PQntuples(res); i++) {
		            		for(j=0;j < nFields;j++) {
			    		    printf("%-15s",PQgetvalue(res,i,j));
		    	    		}
		    	    		printf("\n");
		     		    }
				    PQclear(res);
			            res = PQexec(conn,"CLOSE myportal");
				    PQclear(res);
		    		}
				break;
			    }
			    else
			    {
				printf(" <===== This book you can't borrow =====>\n");
			        break;
			    }
			}	
			else
			{
			    printf("\n <===== No found book in database =====>\n");
			    printf(" <===== Please try again  =====>\n"); 	
			}
		    }
		}
		else
		{
		    printf("\n <===== Not found User_ID in database ! =====>\n");
		}
		res = PQexec(conn,"END");
		PQclear(res);			
		break;		    					
	    }	
	}
	if (ckey == '2') 
	{
	    res = PQexec(conn,"BEGIN");
	    PQclear(res);	
	    printf("\n Press Enter To continue \n");
	    delkey = getchar();	
	    printf("Book ID to Restore : ");
	    gets(Book_ID);
	    sprintf(Query,"select * from book* where book_id = '%s';",Book_ID);	
	    res = PQexec(conn,Query);
	    if 	(PQntuples(res) > 0 )
	    {
		PQclear(res);
		sprintf(Query,"select * from text_book where book_id = '%s';",Book_ID);
		res = PQexec(conn,Query);
		if (PQntuples(res) > 0) 
		{
		    PQclear(res);
		    sprintf(Query,"select restore('%s');",Book_ID);
		    res = PQexec(conn,Query);
		    PQclear(res);			
		    sprintf(Query,"DECLARE myportal CURSOR FOR select
Book_ID,Title,StartDate,Amount,U_ID from text_book where book_id =
'%s';",Book_ID);		
		    res = PQexec(conn,Query);
		    PQclear(res);
		    res = PQexec(conn,"FETCH ALL in myportal");
		    nFields = PQnfields(res);
		    for (i=0;i < nFields; i++) {
			printf("%-15s",PQfname(res,i));
		    }
		    printf("\n");
		    for (i=0; i < PQntuples(res); i++) {
			for (j=0; j < nFields; j++) {
			    printf("%-15s",PQgetvalue(res,i,j));
			}
			printf("/n");
		    }
		    PQclear(res);
		    
		    res = PQexec(conn,"CLOSE myportal");
		    PQclear(res);	
		}
		else
		{
		    PQclear(res);
		    printf("This book can't borrow so this book can't restore\n");		
		}
	    }
	    else 
	    {	
		PQclear(res);
		printf(" <===== Not book in database =====>\n");
	    }	
	    res = PQexec(conn,"END");
	    PQclear(res);	
	}
	if (ckey == '3')
	{
	    printf(" Press enter to continue \n");
	    delkey = getchar(); 
	    printf(" Add new user into database \n");
	    printf(" 1.Users                    \n");
	    printf(" 2.Student                  \n");
	    printf(" 3.Bachelor Degree          \n");
            printf(" 4.Master Degree            \n");
            printf(" 5.Teacher                  \n");
            printf(" 6.Exit                     \n\n\n\n\n\n");
	    printf(" Please choice number of type user : ");
	    delkey = getchar();
	    printf(" Press Enter to continue \n");
	    tempkey = getchar();
	    switch(delkey) 
	    {
		case '1': {
				printf("\n User ID : ");
				gets(User_ID);
				printf(" First Name : ");
				gets(Fname);
				printf(" Last Name : ");
				gets(Lname);
				printf(" Birthday [MM-DD-YYYY] : ");
				gets(Bdate);
				printf(" Sex [M,F] : ");
				gets(Sex);
				sprintf(Query,"Insert into Users values( \
						'%s','%s','%s','%s','%s' \
						)",User_ID,Fname,Lname,  \
						Bdate,Sex); 
				res = PQexec(conn,Query);
				PQclear(res);
				printf("Add users OK \n");
				break;
			}
		case '2': {
				printf("\n User ID : ");
				gets(User_ID);
				printf(" First Name : ");
				gets(Fname);
				printf(" Last Name : ");
				gets(Lname);
				printf(" Birthday [MM-DD-YYYY] : ");
				gets(Bdate);
				printf(" Sex [M,F] : ");
				gets(Sex);
				printf(" Major : ");
				gets(Major);
				printf(" Faculty :");
				gets(Faculty);
				printf(" Year : ");
				gets(User_Year);
				sprintf(Query," Insert into student values (\
				'%s','%s','%s','%s','%s','%s','%s','%s');",User_ID,Fname,Lname,Bdate,Sex,Major,Faculty,User_Year);
				res = PQexec(conn,Query);
				PQclear(res);	
				printf("Add Student OK \n");
				break;
			  }
		case '3': {
                		printf("\n User ID : ");
				gets(User_ID);
				printf(" First Name : ");
				gets(Fname);
				printf(" Last Name : ");
				gets(Lname);
				printf(" Birthday [MM-DD-YYYY] : ");
				gets(Bdate);
				printf(" Sex [M,F] : ");
				gets(Sex);
				printf(" Major : ");
				gets(Major);
				printf(" Faculty :");
				gets(Faculty);
				printf(" Year : ");
				gets(User_Year);
                		printf(" Class : ");
               		 	gets(Class_Room);
                		printf(" Department : ");
                		gets(Department);
                		sprintf(Query," Insert into bachelor values (\
                		'%s','%s','%s','%s','%s','%s','%s','%s',    \
                		'%s','%s');",User_ID,Fname,Lname,Bdate,Sex,Major,Faculty,User_Year,Class_Room,Department);
				res = PQexec(conn,Query);
				PQclear(res);	
                		printf("Add Bachelor OK \n");
                		break;
			  }
        	case '4':{
                		printf("\n User ID : ");
				gets(User_ID);
				printf(" First Name : ");
				gets(Fname);
				printf(" Last Name : ");
				gets(Lname);
				printf(" Birthday [MM-DD-YYYY] : ");
				gets(Bdate);
				printf(" Sex [M,F] : ");
				gets(Sex);
				printf(" Major : ");
				gets(Major);
				printf(" Faculty :");
				gets(Faculty);
				printf(" Year : ");
				gets(User_Year);
                		printf(" Type Of Master Degree : ");
                		gets(Mtype);
                		sprintf(Query," Insert into master_degree values (\
                		'%s','%s','%s','%s','%s','%s','%s','%s','%s'\
                		);",User_ID,Fname,Lname,Bdate,Sex,Major,Faculty,User_Year,Mtype);
				res = PQexec(conn,Query);
				PQclear(res);	
                		printf("Add Master Degree OK \n");
                		break;
                	}
        	case '5':{
				printf("\n User ID : ");
				gets(User_ID);
				printf(" First Name : ");
				gets(Fname);
				printf(" Last Name : ");
				gets(Lname);
				printf(" Birthday [MM-DD-YYYY] : ");
				gets(Bdate);
				printf(" Sex [M,F] : ");
				gets(Sex);
                		printf(" Degree : ");
                		gets(Degree);
				printf(" Faculty :");
				gets(Faculty);
                		sprintf(Query," Insert into teacher values (\
                		'%s','%s','%s','%s','%s','%s','%s');",User_ID,Fname,Lname,Bdate,Sex,Degree,Faculty);
				res = PQexec(conn,Query);
				PQclear(res);	
               	 		printf("Add Teacher OK \n");
				break;
              		}
        		case '6' : break;
        	}
	}
       if (ckey == '4')
       {
           printf("Press enter to continue \n");
           delkey = getchar();
           printf(" Add new book into database \n");
           printf(" 1.Book                     \n");
           printf(" 2.Text Book                \n");
           printf(" 3.Magazine                 \n");
           printf(" 4.Exit                     \n\n\n\n\n\n");
           printf(" Please choice number of book type : ");
	   delkey = getchar();
	   printf(" Press Enter to continue \n");
	   tempkey = getchar();
	   switch(delkey) 
	   {
		case '1': {
                		printf("\n Book ID : ");
                		gets(Book_ID);
                		printf(" Title : ");
                		gets(Title);
                		sprintf(Query,"Insert into Book values( \
                        	'%s','%s',NULL,NULL,NULL)",Book_ID,Title);
				res = PQexec(conn,Query);
				PQclear(res);
                		printf("Add Book OK \n");
				break;
            		}

        	case '2': {
                		printf("\n Text Book ID [TBxxxxxx] : ");
                		gets(Book_ID);
                		printf(" Title : ");
                		gets(Title);
                		printf(" Author : ");
                		gets(Author);
                		printf(" Edition : ");
                		gets(Edition);
                		printf(" Publisher : ");
                		gets(Publisher);
                		sprintf(Query,"Insert into text_book values('%s','%s',NULL,NULL,NULL,'%s','%s','%s')",Book_ID,Title,Author,Edition,Publisher);
				res = PQexec(conn,Query);
				PQclear(res);
                		printf(" Add Text Book OK \n");
				break;
            		}

        	case '3': {
                		printf("\n Magazine ID [MGxxxxxx] : ");
                		gets(Book_ID);
               	 		printf(" Title : ");
                		gets(Title);
                		printf(" Issue : ");
                		gets(Issue);
                		printf(" Magazine Year : ");
                		gets(Book_Year);
                		sprintf(Query,"Insert into Magazine values( \
                        	'%s','%s',NULL,NULL,NULL,'%s',  \
                        	'%s')",Book_ID,Title,Issue,Book_Year);
				res = PQexec(conn,Query);
				PQclear(res);
                		printf("Add Magazine OK \n");
				break;
            		}
        	case '4': break;
        	}
    	}
        if (ckey == '5')
        {
           printf("Press enter to continue \n");
           delkey = getchar();
           printf(" Show Data in table  \n");
           printf(" 1.Users             \n");
           printf(" 2.Student           \n");
           printf(" 3.Bachelor Degree   \n");
           printf(" 4.Master Degree     \n");
           printf(" 5.Teacher           \n");
           printf(" 6.Exit     \n\n\n\n\n\n\n\n");
           printf(" Please choice number of table to show : ");
           delkey = getchar();
           printf(" Press Enter to continue \n");
           tempkey = getchar();
	   switch(delkey) 
	   {
		case '1': {
                    sprintf(Query,"select * from Users");
                    show_data(Query);
                    break;
            		}
	        case '2': {
                    sprintf(Query,"select * from student");
                    show_data(Query);
                    break;
            		}
        	case '3': {
                    sprintf(Query,"select * from bachelor");
                    show_data(Query);
                    break;
                    }
            case '4': {
                    sprintf(Query,"select * from master_degree");
                    show_data(Query);
                    break;
                    }
            case '5' : {
                    sprintf(Query,"select * from teacher");
                    show_data(Query);
                    break;
                    }
            case '6' : break;
            }
    	}
    	if (ckey == '6')
    	{
           printf("Press enter to continue \n");
           delkey = getchar();
           printf(" Show Data in table  \n");
           printf(" 1.Book              \n");
           printf(" 2.Text Book         \n");
           printf(" 3.Magazine          \n");
           printf(" 4.Exit     \n\n\n\n\n\n\n\n");
           printf(" Please choice number of table to show : ");
           delkey = getchar();
           printf(" Press Enter to continue \n");
           tempkey = getchar();
	   switch(delkey) 
	   {
		case '1': {
                    sprintf(Query,"select * from Book");
                    show_data(Query);
                    break;
            		}
        	case '2': {
                    sprintf(Query,"select * from text_book");
                    show_data(Query);
                    break;
            		}

        	case '3': {
                    sprintf(Query,"select * from Magazine");
                    show_data(Query);
                    break;
                    }
            case '4': break;
	    }
    	}
	printf("\n Press Enter to Continue ");
	delkey = getchar();
   	printf("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n");
   	printf("===================================================\n");
   	printf("=                    MENU                         =\n");
   	printf("===================================================\n");
   	printf("=           1.Borrow  Book                        =\n");
   	printf("=           2.Restore Book                        =\n");
	printf("=           3.Add User into database              =\n");
        printf("=           4.Add Book into database              =\n");
   	printf("=           5.Show data in users                  =\n");
	printf("=           6.Show data in book                   =\n");
	printf("=           7.Exit                                =\n");
   	printf("===================================================\n");
   	printf("\n\n\n\n\n\n");
   	printf("Press number [1,2,3,4,5,6,7] to process : ");  
	ckey = getchar();
    if (ckey == '7') break;
   }
   printf("Exit to main program \n");
   printf("Good bye \n");
   exit_nicely(conn);
}
