import java.util.*;

public class DateTest

{
	public static void main(String[] args) 
	{
		Date d1 = new Date();
		System.out.println(d1);
        System.out.println(d1.getTime());

		/*Date d2 = new Date();
		System.out.println(d2);
		System.out.println(d2.getTime());

		System.out.println(d1.after(d2));
		System.out.println(d1.before(d2));
		System.out.println(d1.equals(d2));*/

		int d11;
		//int d22;
		d11= d1.getSeconds();
		System.out.println(d1.getSeconds());
		for(int i = 0;i<10000;i++){System.out.println(i);}
		
		Date d2 = new Date();
		System.out.println(d2);
		System.out.println(d2.getTime());

		System.out.println(d1.after(d2));
		System.out.println(d1.before(d2));
		System.out.println(d1.equals(d2));
		
		System.out.println("d1: " + d11);
		System.out.println("d2: " + d2.getSeconds());	
		System.out.println("d1: " + d1.getSeconds());	
		
	}
}
