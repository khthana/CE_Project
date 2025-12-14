import java.awt.*;
import java.lang.*;

public class Backpropagation implements Runnable {
  public int numberInput;
  public int numberOutput;
  public int numberHidden;
  public double[][] weightInputToHidden;
  public double[][] weightHiddenToOutput;
  public double[] biasHidden;
  public double[] biasOutput;
  public double[] inputLayer;
  public double[] outputLayer;
  public double[] activationOutput;
  public double[] hiddenLayer;
  public double[] activationHidden;
  public double[] desireOutput;
  public double learningRate=0.5;

  private double inputPattern[][];
  private double targetPattern[][];
  private double acceptError;

  private Thread trainThread;
  private double avgError;
  private boolean trainComplete=false;

  public Backpropagation()  {
  }

  public Backpropagation(int i,int o)  {
     numberInput=i;
     numberOutput=o;
     numberHidden=1;
     inputLayer=new double[numberInput];
     hiddenLayer=new double[numberHidden];
     outputLayer=new double[numberOutput];
     desireOutput=new double[numberOutput];

     activationOutput=new double[numberOutput];
     activationHidden=new double[numberHidden];

     biasOutput=new double[numberOutput];
     biasHidden=new double[numberHidden];

     weightInputToHidden=new double[numberInput][numberHidden];
     weightHiddenToOutput=new double[numberHidden][numberOutput];
  }

  public void feedforward()  {
    int i,j;
    reset();
    for(i=0;i<numberHidden;i++)
      for(j=0;j<numberInput;j++)
        activationHidden[i]+=inputLayer[j]*weightInputToHidden[j][i];

    for(i=0;i<numberHidden;i++)
        hiddenLayer[i]=sigmoid(biasHidden[i]+activationHidden[i]);

    for(i=0;i<numberOutput;i++)
      for(j=0;j<numberHidden;j++)
        activationOutput[i]+=hiddenLayer[j]*weightHiddenToOutput[j][i];

    for(i=0;i<numberOutput;i++)
        outputLayer[i]=sigmoid(biasOutput[i]+activationOutput[i]);
  }

  public void update()  {
     int i,j;
     double errorOutput[]=new double[numberOutput];

     //Update Hidden To Output Weight
     for(i=0;i<numberOutput;i++) {
       errorOutput[i]=(desireOutput[i]-outputLayer[i])*outputLayer[i]*
                  (1-outputLayer[i]);
       for(j=0;j<numberHidden;j++)
           weightHiddenToOutput[j][i]+=learningRate*errorOutput[i]*hiddenLayer[j];
       biasOutput[i]=learningRate*errorOutput[i];
     }

     double errorIn[]=new double[numberHidden];
     double errorHidden[]=new double[numberHidden];

     for(i=0;i<numberHidden;i++)
        for(j=0;j<numberOutput;j++)
           errorIn[i]+=errorOutput[j]*weightHiddenToOutput[i][j];

     for(i=0;i<numberHidden;i++) {
        errorHidden[i]=errorIn[i]*(1-hiddenLayer[i])*hiddenLayer[i];
        for(j=0;j<numberInput;j++)
           weightInputToHidden[j][i]+=learningRate*errorHidden[i]*inputLayer[j];
        biasHidden[i]=learningRate*errorHidden[i];
     }
  }   

  public void train(double input[][],double desire[][],double e)  {
     inputPattern=input;
     targetPattern=desire;
     acceptError=e;

     if(trainThread==null) {
        trainThread=new Thread(this);
        trainThread.start();
     }

  }

  public void randomWeight()  {
     int i,j;
     for(i=0;i<numberInput;i++)
       for(j=0;j<numberHidden;j++)
         weightInputToHidden[i][j]=randRange();

     for(i=0;i<numberHidden;i++)
       for(j=0;j<numberOutput;j++)
         weightHiddenToOutput[i][j]=randRange();
  }

  private double randRange()  {
     double result=Math.random();
     if(Math.random()>0.5) result=-result;
     return result;
  }
  public void setInputLayer(double[] input)  {
     for(int i=0;i<numberInput;i++)
        inputLayer[i]=input[i];
  }

  public void setLearnRate(double rate)  {
     learningRate=rate;
  }

  public void setDesireOutput(double[] desire)  {
        for(int i=0;i<numberOutput;i++)
          desireOutput[i]=desire[i];
  }

  public void setWeightInputToHidden(double[][] weight)  {
      weightInputToHidden=weight;
  }

  public void setNumberHiddenLayer(int number) {
      numberHidden=number;
      activationHidden=new double[number];
      hiddenLayer=new double[number];
  }
  public void setWeightHiddenToOutput(double[][] weight)  {
      weightHiddenToOutput=weight;
  }

  public void setBiasHidden(double[] weight)  {
      biasHidden=weight;
  }

  public void setBiasOutput(double[] weight)  {
      biasOutput=weight;
  }

  private double sigmoid(double s)  {
    return 1/(1+Math.pow(Math.E,-s));
  }

  private void addNode()  {
     int i,j;
     numberHidden++;
     double temp1[][]=new double[numberInput][numberHidden];
     double temp2[][]=new double[numberHidden][numberOutput];
     double tempActivation[]=new double[numberHidden];
     double tempBias[]=new double[numberHidden];
     double tempHidden[]=new double[numberHidden];

     int temp=numberHidden-1;

     System.out.println("NUMBER OF HIDDEN "+numberHidden);
     for(i=0;i<numberInput;i++)
        for(j=0;j<numberHidden;j++)  {
           if(j!=temp) 
              temp1[i][j]=weightInputToHidden[i][j];
           else
              temp1[i][j]=0.0;
        }

     for(i=0;i<numberHidden;i++)
        for(j=0;j<numberOutput;j++)
           if(i!=temp)
              temp2[i][j]=weightHiddenToOutput[i][j];
           else
              temp2[i][j]=0.0;

     for(i=0;i<numberHidden;i++)
         if(i!=temp)
            tempBias[i]=biasHidden[i];
         else
            tempBias[i]=0.0;
        

     weightInputToHidden=temp1;
     weightHiddenToOutput=temp2;
     activationHidden=tempActivation;
     biasHidden=tempBias;
     hiddenLayer=tempHidden;
  }

  private void removeNode()  {
     int i,j;
     numberHidden--;
     double temp1[][]=new double[numberInput][numberHidden];
     double temp2[][]=new double[numberHidden][numberOutput];
     double tempActivation[]=new double[numberHidden];
     double tempBias[]=new double[numberHidden];
     double tempHidden[]=new double[numberHidden];

     for(i=0;i<numberInput;i++)
        for(j=0;j<numberHidden;j++)
              temp1[i][j]=weightInputToHidden[i][j];

     for(i=0;i<numberHidden;i++)
        for(j=0;j<numberOutput;j++)
              temp2[i][j]=weightHiddenToOutput[i][j];

     for(i=0;i<numberHidden;i++)
         tempBias[i]=biasHidden[i];

    
     weightInputToHidden=temp1;
     weightHiddenToOutput=temp2;
     activationHidden=tempActivation;
     biasHidden=tempBias;
     hiddenLayer=tempHidden;
  }


  public void displayWeight()  {
     int i,j;
     for(i=0;i<numberInput;i++)
        for(j=0;j<numberHidden;j++)
          System.out.println(weightInputToHidden[i][j]);
     System.out.println();
  }

  public double getError()  {
     double totalError=0;
     for(int i=0;i<numberOutput;i++) 
//         totalError+=
//         (desireOutput[i]-outputLayer[i])*(desireOutput[i]-outputLayer[i]);
           totalError+=Math.abs(desireOutput[i]-outputLayer[i]);
     return totalError;
  }


  public double[] getOutputLayer()  {
    return outputLayer;
  }


  private void reset()  {
    int i;
    for(i=0;i<numberHidden;i++) {
      activationHidden[i]=0;
      hiddenLayer[i]=0;
    }

    for(i=0;i<numberOutput;i++) {
      activationOutput[i]=0;
      outputLayer[i]=0;
    }
  }

  public double[][] getWeightInputToHidden()  {
     return   weightInputToHidden;
  }

  public double[][] getWeightHiddenToOutput()  {
     return   weightHiddenToOutput;
  }

  public double[] getBiasHidden()  {
     return   biasHidden;
  }

  public double[] getBiasOutput()  {
     return   biasOutput;
  }

  public int getInput()  {
    return numberInput;
  }

  public int getOutput()  {
    return numberOutput;
  }

  public int getHidden()  {
    return numberHidden;
  }

  public void run() {
     int numberPattern=inputPattern.length;
     int i,j;

     int count=0;  /////
     
     double sumError=0;
     double sumError1=0;
     double sumError2=0;
     boolean converge=false;

     //check error input.length and desire.length

     while(true)  {
        while(!converge) {
            if(count!=100) {
                 sumError=0;
                 for(i=0;i<numberPattern;i++)  {
                     setInputLayer(inputPattern[i]);
                     setDesireOutput(targetPattern[i]);
                     feedforward();
                     sumError+=getError();
                     update();
                 }

                 sumError=sumError/numberPattern;
                 if(sumError<acceptError) {
                 System.out.println(sumError);

                     converge=true;
                     trainComplete=true;
                     trainThread.stop();
                 }
                 count++;
                 if(count==1)
                     sumError1=sumError;
            }   else    {
                    count=0;
                    sumError2=sumError;
                    avgError=sumError2;
                    if(sumError1-sumError2<0.01*sumError1)  
                        addNode();
                }
        }
     }
  }

  public double getAverageError()  {
    return avgError;
  }

  public int getNumberHiddenNode() {
    return numberHidden;
  }

  public boolean trainComplete()  {
    return trainComplete;
  }

}
                                                                          
