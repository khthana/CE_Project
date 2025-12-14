import java.awt.*;
import java.awt.event.*;
import java.io.*;
import java.util.*;
public class Neural extends MyFrame implements ActionListener  {
   Button trainButton=new Button("Train");
   Button runButton=new Button("Run");
   TrainFrame trainFrame;
   RunFrame runFrame;

   public Neural()   {
        setLayout(null);
        setSize(400,400);

        trainButton.addActionListener(this);
        trainButton.setLocation(10,30);
        trainButton.setSize(70,20);

        runButton.addActionListener(this);
        runButton.setLocation(10,50);
        runButton.setSize(70,20);

        add(trainButton);
        add(runButton);

   }

   public void actionPerformed(ActionEvent e)   {
      if(e.getActionCommand().equals("Train"))   {
        trainFrame=new TrainFrame();
        trainFrame.show();
         //Button LOAD Clicked
      }  else  {
           if(e.getActionCommand().equals("Run")) {
               runFrame=new RunFrame();
               runFrame.show();
           }
         }
   }

   public static void main(String arg[])  {
      Neural neural=new Neural();
      neural.show();
   }

 

}
