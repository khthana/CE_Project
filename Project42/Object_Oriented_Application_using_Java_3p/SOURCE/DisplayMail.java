import java.awt.*;  
import SenderMessage;
import coding_quoted;

public class DisplayMail extends Frame {

  private MenuItem quitItem;
  private Font myFont;
  private TextField toText,fromText,subjectText;
  private TextArea messageText;
  private Button sendMessage;
  private Label toLabel,fromLabel,subjectLabel,messageLabel;
  private String emailSender,emailRecipient,subject,message;

//===========================DisplayMail()=================================

    DisplayMail(){
      menu_1();
      myFont = new Font("Cordia New",Font.BOLD,18);
      setLayout(null);
      setFont(myFont);
      setBackground(new Color(200,0,250));

      add(sendMessage = new Button("Send"));
      add(fromLabel = new Label("Mail form: "));
      add(fromText = new TextField(10));
      add(toLabel = new Label("Rcpt to: "));
      add(toText = new TextField(10));
      add(subjectLabel = new Label("Subject: "));
      add(subjectText = new TextField(10));
      add(messageLabel = new Label("Message: "));
      add(messageText = new TextArea(10,10));

      fromLabel.setBounds(50,70,65,30);
      fromText.setBounds(120,70,200,30);
      toLabel.setBounds(50,100,65,30);
      toText.setBounds(120,100,200,30);
      subjectLabel.setBounds(50,130,65,30);
      subjectText.setBounds(120,130,200,30);
      messageLabel.setBounds(50,160,65,30);
      messageText.setBounds(120,160,200,230);
      sendMessage.setBounds(50,190,60,200);
      setBounds(150,80,400,400);
  }

//===========================menu_1()==================================

  private void menu_1(){
    MenuBar menu = new MenuBar();
    Menu file = new Menu("File",true);
    file.add(new MenuItem("New"));
    file.add(new MenuItem("Open"));
    file.add(new MenuItem("Save"));
    file.add(new MenuItem("Save As"));
    file.addSeparator();
    file.add(quitItem = new MenuItem("Quit"));
    menu.add(file);
    setMenuBar(menu);
  }

//===========================handleEvent(Event)=============================

  public boolean handleEvent(Event e) {
    if(e.id == Event.WINDOW_DESTROY)
      System.exit(0);
    if(e.target instanceof MenuItem){
      MenuItem item = (MenuItem)e.target;
      if(item == quitItem)
        System.exit(0);
    }
    return super.handleEvent(e);
  }//end handleEvent()

//===========================main(String)==================================

  public static void main(String args[]){
    DisplayMail f = new DisplayMail();
    f.setVisible(true);
  }

//===========================action(Event,Oject)================================

  public boolean action(Event evt,Object whatAction){
    if(!(evt.target instanceof MenuItem)&&!(evt.target instanceof Button)){
      return false;
    }
    if(evt.target instanceof Button){
      String buttonLabel=(String)whatAction;
      if(buttonLabel == "Send"){
        emailSender = fromText.getText();
        emailRecipient = toText.getText();
        subject = subjectText.getText();
        message = messageText.getText();
        //message = coding_quoted.coding(message);
        try{
          SenderMessage senderMessage
            = new SenderMessage(emailSender,emailRecipient,subject,message);
          }
        catch(Exception ex){
          System.out.println("SenderMessage Error: " + ex);
        }
      }
    }
    return true;
  }

}


