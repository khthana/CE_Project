import java.awt.*;
import java.awt.event.*;
import java.awt.Button;
import javax.swing.*;
class TextInput2 extends Frame implements ActionListener{
        private TextField tf1,tf2,tf3;
        private Button addBT,subBT,mulBT,divBT,quitBT;

        public static void main(String[] args)
        {       TextInput2 f = new TextInput2();
                f.setSize(400,150);
                f.setVisible(true);  
		           
        }
        public TextInput2()
        {       setTitle("Calculator");
                setBackground(Color.yellow);
                setForeground(Color.red);
                setLayout(new FlowLayout());
                add(new Label("Number 1"));
                add(tf1 = new TextField(" ",3));
                add(new Label("Number 2"));
                add(tf2 = new TextField(" ",3));
                add(new Label("Result"));
                add(tf3 = new TextField(" ",4));
                tf3.setEditable(false);
                add(addBT = new Button("Add"));
                add(subBT = new Button("Subtract"));
                add(mulBT = new Button("Multiply"));       
                add(divBT = new Button("Devide"));
                add(quitBT = new Button("Quit"));
                addBT.addActionListener(this);
                subBT.addActionListener(this);
                mulBT.addActionListener(this);
                divBT.addActionListener(this);
                quitBT.addActionListener(this);
        }

public void actionPerformed(ActionEvent e)
{       String arg = e.getActionCommand();

        if (e.getSource() instanceof Button)
        {       if("Add".equals(arg))
                          calculate('+');
                else if ("Subtract".equals(arg))
                          calculate('-');
                else if ("Multiply".equals(arg))
                          calculate('*');      
                else if ("Devide".equals(arg))
                          calculate('/');      
                else if ("Quit".equals(arg))
                          System.exit(0);
          }
}

private void calculate(char operator)
{
        int num1 = (Integer.parseInt(tf1.getText().trim()));
        int num2 = (Integer.parseInt(tf2.getText().trim()));
        int num3 = 0;

        switch (operator)
        {
               case'+':num3 = num1 + num2;      break;
               case'-':num3 = num1 - num2;      break;
               case'*':num3 = num1 * num2;      break;
               case'/':num3 = num1 / num2;
        }


        tf3.setText(String.valueOf(num3));
 }
 }
