import java.awt.*;
import java.awt.event.*;
import java.util.*;
import java.io.*;
import java.lang.*;
public class TrainFrame extends MyFrame implements ActionListener,Runnable {

  PictureArea pictureArea;
  Button loadButton;
  Button nextButton;
  Button saveButton;
  Button trainButton;
  Button saveBackButton;
  TheFileDialog theFileDialog;
  String thePictureFile;
  TextField patternTextField;
  Frame  frameParentForFileDialog=new Frame();
  LoadCharacter loadCharacter;
  FileTrainData fileData;
  Vector dataCharacter=new Vector();
  Vector typeCharacter=new Vector();
  boolean lastCharacter=false;
  double[]  dataToken;
  int[]     displayData;
  FileNeuralManager fnm=new FileNeuralManager();
  Backpropagation backpropagation;
  
  double errorRate=0.01*Code.SIZE;

  Thread trainThread;

  Dialog trainProcess=new Dialog(this,"Train Process");
  Label dialogLabel=new Label();
  Label numberHiddenNode=new Label("0");
  Label completeDialog=new Label();
  Button okDialogButton=new Button("OK");

  public TrainFrame() {
      super("TRAINING FRAME");
      setLayout(null);
      setSize(600,500);

      loadButton=new Button("Load");
      loadButton.addActionListener(this);
      loadButton.setLocation(20,30);
      loadButton.setSize(70,30);

      nextButton=new Button("Next");
      nextButton.addActionListener(this);
      nextButton.setLocation(61,310);
      nextButton.setSize(50,20);
      nextButton.setEnabled(false);

      saveButton=new Button("Save");
      saveButton.addActionListener(this);
      saveButton.setLocation(5,350);
      saveButton.setSize(110,20);
      saveButton.setEnabled(false);

      trainButton=new Button("Train");
      trainButton.addActionListener(this);
      trainButton.setLocation(5,370);
      trainButton.setSize(110,20);

      saveBackButton=new Button("Save Network");
      saveBackButton.addActionListener(this);
      saveBackButton.setLocation(5,390);
      saveBackButton.setSize(110,20);
      saveBackButton.setEnabled(false);

      patternTextField=new TextField();
      patternTextField.setLocation(10,310);
      patternTextField.setSize(50,20);

      loadCharacter=new LoadCharacter();
      loadCharacter.setLocation(10,200);

      pictureArea=new PictureArea();
      pictureArea.setLocation(120,30);

      trainProcess.setLayout(null);
      trainProcess.setSize(300,120);
      trainProcess.setLocation(200,200);
      Label displayAVE=new Label("Average error per pattern:");
      trainProcess.add(displayAVE);
      displayAVE.setLocation(10,25);
      displayAVE.setSize(150,15);
      trainProcess.add(dialogLabel);
      dialogLabel.setLocation(160,25);
      dialogLabel.setSize(150,15);
      Label displayHN;
      trainProcess.add(displayHN=new Label("Hidden node:"));
      displayHN.setLocation(10,45);
      displayHN.setSize(150,15);
      trainProcess.add(numberHiddenNode);
      numberHiddenNode.setLocation(160,45);
      numberHiddenNode.setSize(150,15);
      Button cancelDialogButton=new Button("CANCEL");
      trainProcess.add(okDialogButton);
      trainProcess.add(cancelDialogButton);
      okDialogButton.setLocation(65,80);
      okDialogButton.setSize(75,20);
      cancelDialogButton.setLocation(150,80);
      cancelDialogButton.setSize(75,20);
      okDialogButton.addActionListener(this);
      okDialogButton.setEnabled(false);
      cancelDialogButton.addActionListener(this);
      trainProcess.add(completeDialog);
      completeDialog.setSize(150,15);
      completeDialog.setLocation(65,65);

      add(loadButton);
      add(nextButton);
      add(saveButton);
      add(trainButton);
      add(saveBackButton);
      add(patternTextField);
      add(loadCharacter);
      add(pictureArea);
      this.pack();
   }

   private void clickLoadButton()  {
      theFileDialog=new
       TheFileDialog(frameParentForFileDialog,"Load Picture",FileDialog.LOAD);
      theFileDialog.show();
      if(theFileDialog.getFile()!=null)  {
          thePictureFile=theFileDialog.getDirectory()+theFileDialog.getFile();
          pictureArea.removeAll();
          pictureArea.loadImage(thePictureFile);
          this.setCursor(new Cursor(Cursor.WAIT_CURSOR));
          pictureArea.segmentation();
          this.setCursor(new Cursor(Cursor.DEFAULT_CURSOR));

          loadCharacter.load(pictureArea.getCharacter());
          dataCharacter.addElement(pictureArea.getData());


          lastCharacter=false;
          nextButton.setEnabled(true);
          saveButton.setEnabled(true);
      }
   }

   private void clickNextButton()  {
       if(!lastCharacter)  {
         if(pictureArea.haveAnyCharacter()) {
            loadCharacter.load(pictureArea.getCharacter());
            dataCharacter.addElement(pictureArea.getData());
            typeCharacter.addElement(patternTextField.getText());
            if(!pictureArea.haveAnyCharacter())  
               lastCharacter=true;
         }
       } else {
             typeCharacter.addElement(patternTextField.getText());
             nextButton.setEnabled(false);
         }  
   }

   private void clickSaveButton()  {
       if(!lastCharacter)
          typeCharacter.addElement(patternTextField.getText());
          theFileDialog=new TheFileDialog(frameParentForFileDialog,
              "Save Datatoken",FileDialog.SAVE);
          theFileDialog.show();
          if(theFileDialog.getFile()!=null)  {
              dataToken=(double[])dataCharacter.elementAt(0);
              int numberPerData=dataToken.length;
              fileData =new FileTrainData(theFileDialog.getDirectory()
                       ,theFileDialog.getFile(),"rw");
              fileData.setNumberPerData(numberPerData);
              fileData.setFormat();
              String type;
              for(int i=0;i<typeCharacter.size();i++)  {
                 dataToken=(double[])dataCharacter.elementAt(i);
                 type=(String)typeCharacter.elementAt(i);
                 fileData.save(dataToken,type);
              }
              typeCharacter.removeAllElements();
              dataCharacter.removeAllElements();
          }
   }

   private void clickTrainButton()  {
       theFileDialog=new TheFileDialog(frameParentForFileDialog,
            "Load DataFromTrain",FileDialog.LOAD);
       theFileDialog.show();
       if(theFileDialog.getFile()!=null)  {
          fileData =new FileTrainData(theFileDialog.getDirectory()
               ,theFileDialog.getFile(),"r");
          fnm.loadDataForTrain(fileData);
//          this.setCursor(new Cursor(Cursor.WAIT_CURSOR));
          backpropagation=new  Backpropagation(fnm.getNumberInput()
              ,fnm.getNumberOutput());
          if(trainThread==null)  {
             trainProcess.show();
             
             trainThread=new Thread(this);
             trainThread.start();
          }

//          this.setCursor(new Cursor(Cursor.DEFAULT_CURSOR));
//          saveBackButton.setEnabled(true);

       }
   }

   private void clickSaveBackButton()  {
       theFileDialog=new TheFileDialog(frameParentForFileDialog,
             "Save NeuralNetwork",FileDialog.SAVE);
       theFileDialog.show();
       if(theFileDialog.getFile()!=null)  {
          FileManager fileData =new FileManager(theFileDialog.getFile(),"rw");
          fnm.saveData(fileData,backpropagation);
       }
   }

   public void actionPerformed(ActionEvent e)   {
      if(e.getActionCommand().equals("Load"))   
         clickLoadButton();
      else {
        if(e.getActionCommand().equals("Next"))  
           clickNextButton();
        else {
          if(e.getActionCommand().equals("Save")) 
             clickSaveButton();
          else {
            if(e.getActionCommand().equals("Train"))  
               clickTrainButton();
            else {
              if(e.getActionCommand().equals("Save Network"))  
                 clickSaveBackButton();
              else {
                if(e.getActionCommand().equals("CANCEL"))  {
                   trainThread.stop();
                   trainProcess.dispose();          
                   saveBackButton.setEnabled(true);
                }
                else {
                  if(e.getActionCommand().equals("CANCEL"))  {
                     trainProcess.dispose();
                     trainProcess.dispose();          
                     saveBackButton.setEnabled(true);
                  }
                }
              }
            }
          }
        }
      }
      
   }

   public void run()  {
          backpropagation.train(fnm.getPatternInput()
              ,fnm.getRequireOutput(),errorRate);
          while(true) {
             dialogLabel.setText(Double.toString(backpropagation.getAverageError()));
             numberHiddenNode.setText(Integer.toString(backpropagation.getNumberHiddenNode()));
             if(backpropagation.trainComplete()) {
                completeDialog.setText("-------------Complete-------------");
                okDialogButton.setEnabled(true);
                trainThread.stop();
             }
          }
   }

}
    

