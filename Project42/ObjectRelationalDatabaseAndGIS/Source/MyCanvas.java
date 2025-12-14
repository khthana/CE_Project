
//Title:        GIS
//Version:      
//Copyright:    Copyright (c) 1998
//Author:       Sakshart Ngamluan
//Company:      KMITL
//Description:  Your description


package KCOM;
import java.awt.*;
class MyCanvas extends Canvas
{
	Image mi;
	public MyCanvas(Image img){
		mi=img;
	}
	public void paint(Graphics g){
		g.drawImage(mi,0,0,this);
	}

}

