/*
 * Java Network Programming, Second Edition
 * Merlin Hughes, Michael Shoffner, Derek Hamner
 * Manning Publications Company; ISBN 188477749X
 *
 * http://nitric.com/jnp/
 *
 * Copyright (c) 1997-1999 Merlin Hughes, Michael Shoffner, Derek Hamner;
 * all rights reserved; see license.txt for details.
 */


import java.io.*;

public class HttpFile implements HttpProcessor {
  protected File file;
  
  public HttpFile (HttpInputStream in) throws IOException {
    if (in.getMethod () == HTTP.METHOD_POST)
      throw new HttpException (HTTP.STATUS_NOT_ALLOWED,
                               "<TT>" + in.getMethod () + " " + in.getPath () + "</TT>");
	
	System.out.println("getPath: " + in.getPath());
//    System.out.println("translateFilename (in.getPath ()) : " + HTTP.translateFilename (in.getPath ()));
//	System.out.println("HTTP.HTML_ROOT : " + HTTP.HTML_ROOT.getPath());
	
	file = new File (HTTP.HTML_ROOT, HTTP.translateFilename (in.getPath ()));
//		System.out.println("nameFile_HTML_ROOT0 : " + file.getName());
//	System.out.println("namePath_HTML_ROOT0 : " + file.getPath());
	/*if (in.getPath().length() > 1)
	{
		System.out.println(">1");
		file = new File (HTTP.HTML_ROOT(in.getPath()), HTTP.translateFilename (in.getPath ()));
	}*/
	
//	System.out.println("nameFile_HTML_ROOT1 : " + file.getName());
//	System.out.println("namePath_HTML_ROOT1 : " + file.getPath());
	
	System.out.println("getFileName : " + file.getName());
    
	String a  =  in.getPath().substring(1);
	int      index  =  a.indexOf("/");

 if (in.getPath().endsWith("class")  &&  (in.getPath().startsWith("/class-bin/") ) )
 {
file = new File (HTTP.HTML_ROOT,file.getName ());
 }

else	if (in.getPath ().endsWith ("/"))
      file = new File (file, HTTP.DEFAULT_INDEX);

  else  if (!file.exists ())
      throw new HttpException (HTTP.STATUS_NOT_FOUND,
                               "File <TT>" + in.getPath () + "</TT> not found.");
   else  if (file.isDirectory ())
      throw new RedirectException (HTTP.STATUS_MOVED_PERMANENTLY,
                                   in.getPath () + "/");
    else if (!file.isFile () || !file.canRead ())
      throw new HttpException (HTTP.STATUS_FORBIDDEN, in.getPath ());
  }

  public void processRequest (HttpOutputStream out) throws IOException {
    out.setHeader ("Content-type", HTTP.guessMimeType (file.getName ()));
    out.setHeader ("Content-length", String.valueOf (file.length ()));
	System.out.println("do processRequest   "+ file.getName() );
    if (out.sendHeaders ()) {
      FileInputStream in = new FileInputStream (file);
      out.write (in);
      in.close ();
    }
  }
}
