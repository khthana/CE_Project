// Class Echo

import java.io.*;

public class Echo implements HttpClassProcessor {
    
    protected String message,data,b;
    int z; 
    public void initRequest (HttpInputStream in) throws IOException 
    {
      if (in.getMethod () != HTTP.METHOD_POST)
         throw new HttpException (HTTP.STATUS_NOT_ALLOWED,"Request method<TT>" + in.getMethod() + " </TT> not allowed.");
         message = HTTP.decodeString (in.getQueryString() );
         data =  in.getHeader("Content-length");
          b = in.readLine();
    }
    
    //--------------------------------------------------
    
    public void processRequest(HttpOutputStream out) throws IOException 
    {
        out.setHeader("Content-type","text/plain");
        if (out.sendHeaders() )
        out.write (message + "\r\n");
        out.write (data + "\r\n");
        z = Integer.parseInt(data);
        if (z == 33 )  out.write("true\r\n");
        else out.write("false\r\n");
        out.write(b);
        out.write(13);
     }
    
    
  }  // end class echo
