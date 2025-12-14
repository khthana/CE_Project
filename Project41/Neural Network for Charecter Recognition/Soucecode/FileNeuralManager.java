import java.io.*;
public class FileNeuralManager {
    public int numberOfPattern;
    public int numberOfOutput;
    public int numberOfData;
    public double patternInput[][];
    public double requireOutput[][];
    public Backpropagation b;

    public void loadDataForTrain(FileTrainData file)  {
        int i,j;
        numberOfPattern=file.getNumberOfData();
        numberOfOutput=file.getNumberCode();
        numberOfData=file.getNumberPerData();
        patternInput=new double[numberOfPattern][numberOfData];
        requireOutput=new double[numberOfPattern][numberOfOutput];
        file.readFormat();
        for(i=0;i<numberOfPattern;i++) {
           for(j=0;j<numberOfData;j++) 
              patternInput[i][j]=file.readData();
          
           for(j=0;j<numberOfOutput;j++) 
              requireOutput[i][j]=file.readData();

           if(file.readCode().equals("\n")) {}
           else System.out.println("ERROR");
        }
    }

    public int getNumberOutput()  {
        return numberOfOutput;
    }

    public int getNumberInput()  {
        return numberOfData;
    }
     
    public double[][] getPatternInput()  {
        return patternInput;
    }

    public double[][] getRequireOutput()  {
        return requireOutput;
    }


    public void saveData(FileManager file,Backpropagation back)  {
        int i,j;
        double wih[][]=back.getWeightInputToHidden();
        double who[][]=back.getWeightHiddenToOutput();
        double bh[]=back.getBiasHidden();
        double bo[]=back.getBiasOutput();

        file.writeInt(wih.length);
        file.writeInt(wih[0].length);
        file.writeInt(who[0].length);
        file.writeInt(bh.length);
        file.writeInt(bo.length);

        for(i=0;i<wih.length;i++)
           for(j=0;j<wih[0].length;j++)
               file.write(wih[i][j]);

        for(i=0;i<who.length;i++)
           for(j=0;j<who[0].length;j++)
               file.write(who[i][j]);

        for(i=0;i<bh.length;i++)
           file.write(bh[i]);

        for(i=0;i<bo.length;i++)
           file.write(bo[i]);
    }

    public Backpropagation loadData(FileManager file)  {
        int i,j;
        int numberOfInput=file.readInt();
        int numberOfHidden=file.readInt();
        int numberOfOutput=file.readInt();
        int numberOfBiasH=file.readInt();
        int numberOfBiasO=file.readInt();

        double wih[][]=new double[numberOfInput][numberOfHidden];
        double who[][]=new double[numberOfHidden][numberOfOutput];
        double bh[]=new double[numberOfBiasH];
        double bo[]=new double[numberOfBiasO];
        for(i=0;i<numberOfInput;i++)
           for(j=0;j<numberOfHidden;j++)
              wih[i][j]=file.read();

        for(i=0;i<numberOfHidden;i++)
           for(j=0;j<numberOfOutput;j++)
              who[i][j]=file.read();

        for(i=0;i<numberOfBiasH;i++)
           bh[i]=file.read(); 
              
        for(i=0;i<numberOfBiasO;i++)
           bo[i]=file.read(); 
       
        Backpropagation back=new Backpropagation(numberOfInput
           ,numberOfOutput);


        back.setWeightInputToHidden(wih);
        back.setWeightHiddenToOutput(who);
        back.setNumberHiddenLayer(numberOfHidden);
        back.setBiasHidden(bh);
        back.setBiasOutput(bo);
        return back;
    }
}


