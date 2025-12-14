import java.awt.*;
import java.awt.event.*;
public class RunFrame extends MyFrame implements ActionListener  {
    Button runButton=new Button("Run");
    Button loadPictureButton=new Button("Load Picture");
    Button loadNeuralButton=new Button("Load Neural");
    TextField answerTextField=new TextField();
    PictureArea pictureArea=new PictureArea();
    Frame frameParentForFileDialog=new Frame();
    TheFileDialog theFileDialog;
    FileNeuralManager fnm=new FileNeuralManager();
    Backpropagation back=new Backpropagation();
    public RunFrame()  {
        setLayout(null);
        setSize(600,500);
        loadPictureButton.setLocation(10,30);
        loadPictureButton.setSize(100,20);
        loadPictureButton.addActionListener(this);

        loadNeuralButton.setLocation(10,50);
        loadNeuralButton.setSize(100,20);
        loadNeuralButton.addActionListener(this);

        runButton.setLocation(10,70);
        runButton.setSize(100,20);
        runButton.addActionListener(this);
        runButton.setEnabled(false);

        pictureArea.setLocation(120,30);
        

        answerTextField.setLocation(120,435);
        answerTextField.setSize(400,20);

        add(loadPictureButton);
        add(loadNeuralButton);
        add(runButton);
        add(pictureArea);
        add(answerTextField);
    }

    private void clickLoadPictureButton()  {
        theFileDialog=new
           TheFileDialog(frameParentForFileDialog
           ,"Load Picture",FileDialog.LOAD);
        theFileDialog.show();
        if(theFileDialog.getFile()!=null)  {
            String thePictureFile=theFileDialog.getDirectory()
              +theFileDialog.getFile();
            pictureArea.removeAll();
            pictureArea.loadImage(thePictureFile);
            pictureArea.segmentation();
        }
    }

    private void clickLoadNeuralButton()  {
        theFileDialog=new
           TheFileDialog(frameParentForFileDialog
           ,"Load Neural",FileDialog.LOAD);
        theFileDialog.show();
        if(theFileDialog.getFile()!=null)  {
           FileManager fileManager=new
               FileManager(theFileDialog.getFile(),"r");
           back=fnm.loadData(fileManager);
           runButton.setEnabled(true);
        }
    }

    private void clickRunButton()  {
        back.setInputLayer(pictureArea.getData());
        back.feedforward();
        double temp[]=back.getOutputLayer();
        for(int i=0;i<temp.length;i++)  {
            if(temp[i]>=0.8) temp[i]=1;
            else {
             if(temp[i]<=0.2) temp[i]=0;
             else System.out.print(2);
            }
        }
        answerTextField.setText(answerTextField.getText()+Code.decode(temp));
    }

    public void actionPerformed(ActionEvent e)  {
        if(e.getActionCommand().equals("Load Picture"))
           clickLoadPictureButton();
        else {
          if(e.getActionCommand().equals("Load Neural"))
             clickLoadNeuralButton();
          else {
            if(e.getActionCommand().equals("Run"))
               clickRunButton();
          }

        } 
    }
}
