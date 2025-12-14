package IsecQ;
import java.io.*;
import java.awt.*;
// import java.util.Vector;
import IsecQ.*;

class CheckSearchResultThread extends Thread
{

	List	searchList;
	Search search;
	ServerConnect sconnect;
	
	public CheckSearchResultThread(ServerConnect sconnect ,Search search)
	{	this.sconnect=sconnect;
		this.search = search;
		this.searchList = search.getSearchList();
	}

	UserInfo uinfo =new UserInfo();

	public void run()
	{	int num_found=0;
		while (!sconnect.isSearchComplete())
		{	
			try
			{	this.sleep(100);	
				if (sconnect.haveNewFound())
				{	
					uinfo = sconnect.getFoundInfo();
					UserInfo uinfo2 =new UserInfo();
					
					uinfo2.setUIN(uinfo.getUIN());
					uinfo2.setNick(uinfo.getNick());
					uinfo2.setFirst(uinfo.getFirst());
					uinfo2.setLast(uinfo.getLast());
					uinfo2.setEmail(uinfo.getEmail());
					uinfo2.setAuth(uinfo.getAuth());

					System.out.println("user "+uinfo.getUIN() +" added");
					search.addFoundUser(uinfo2);
					String userDisplay	 = uinfo2.getUIN()+"";
					if (uinfo2.getNick().equals(""))
					{	userDisplay +="  N/A";
					}
					else {userDisplay+="  "+uinfo2.getNick();}
					if (uinfo2.getFirst().equals(""))
					{	userDisplay +="  N/A";
					}
					else {userDisplay+="  "+uinfo2.getFirst();}
					if (uinfo2.getLast().equals(""))
					{	userDisplay +="  N/A";
					}
					else {userDisplay+="  "+uinfo2.getLast();}
					if (uinfo2.getEmail().equals(""))
					{	userDisplay +="  N/A";
					}
					else {userDisplay+="  "+uinfo2.getEmail();}
					if (uinfo2.getAuth() == 0)
					{	userDisplay +="  Authorize";
					}
					else {userDisplay+="  Alway";}

					searchList.add(userDisplay);

					System.out.println("number user found "+num_found);
					System.out.println("user info "+userDisplay);
					num_found++;
				}
			}
			catch (InterruptedException i)
			{ System.out.println("IOException "+i);
			}
			System.out.println(" Search user running ");
		} // end while
		System.out.println("Search Complete");
	}// end run

}