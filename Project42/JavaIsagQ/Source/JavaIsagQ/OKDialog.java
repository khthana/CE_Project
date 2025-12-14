package IsecQ;

import java.awt.*;
import java.awt.Button;

public class OKDialog extends Dialog
{
  protected Button okButton;
  protected static Frame createdFrame;

  public OKDialog(Frame parent, String message)
  {
    super(parent, true);        

    // สร้าง GridLayout
    GridBagLayout gridbag = new GridBagLayout();
    GridBagConstraints constraints = new GridBagConstraints();

    // สร้างปุ่ม OK พร้อมข้อความ
    okButton = new Button("     OK     ");
    Label messageLabel = new Label(message);

    setLayout(gridbag);

    // กำหนด constraints ให้กับ GridBagConstraints
    constraints.fill = GridBagConstraints.NONE;
    constraints.anchor = GridBagConstraints.CENTER;
    constraints.ipadx = 20;
    constraints.ipady = 20;
    constraints.weightx = 1.0;
    constraints.weighty = 1.0;
    constraints.gridwidth = GridBagConstraints.REMAINDER;
    constraints.gridheight = GridBagConstraints.RELATIVE;

    gridbag.setConstraints(messageLabel, constraints);
    add(messageLabel);

    constraints.ipadx = 0;
    constraints.ipady = 0;
    constraints.weightx = 0.0;
    constraints.weighty = 0.0;
    constraints.gridwidth = 1;
    constraints.gridheight = GridBagConstraints.REMAINDER;

    gridbag.setConstraints(okButton, constraints);
    add(okButton);

    pack();	// Pack เป็น Method ที่ใช้ทำให้จอภาพ ใช้เนื้อที่น้อยที่สุดเท่าที่จำเป็นในการแสดง Components
  }

  // ตรวจสอบเหตุการณ์การ Click ที่ปุ่ม OK
  public boolean action(Event evt, Object whichAction)
  {
    if (evt.target == okButton)
    {
      hide();
      if (createdFrame != null)
      {
        createdFrame.hide();
      }
    }
    return true;
  }

  // Shortcut to ในการสร้าง frame โดยอัตโนมัติ
  public static void createOKDialog(String dialogString)
  {    // ถ้ายังไม่ได้สร้าง Frame ก็ให้สร้างเสียก่อน
    if (createdFrame == null)
    {
      createdFrame = new Frame("Dialog");
    }

  // สร้าง Dialog Box
  OKDialog okDialog = new OKDialog(createdFrame, dialogString);

  // ย่อ Frame ให้พอเหมาะกับ Dialog Box
  createdFrame.resize(okDialog.size().width, okDialog.size().height);

  // แสดง Dialog Box
  okDialog.show();
  } 
}
