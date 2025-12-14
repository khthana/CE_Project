public class DataMail 
{
	private static String sender,recipient,subject,message,date;
	
	public static void setSender(String sender) 
	{
		sender = this.sender ;
	}
	public static void setRecipient(String recipient) 
	{
		this.recipient = recipient;
	}
	public static void setSubject(String subject) 
	{
		this.subject = subject;
	}
	public static void setMessage(String message) 
	{
		this.message = message;
	}
	public static void setDate(String date) 
	{
		this.date = date;
	}
	
	public static void main(String[] args) 
	{
		System.out.println("Hello World!");
	}
}
