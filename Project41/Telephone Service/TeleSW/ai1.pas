unit ai1;
      
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  FileCtrl, StdCtrls, ExtCtrls, FmxUtils, Buttons, MMsystem, Grids, MPlayer,
  Db, DBTables, DBGrids, DBCtrls;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Edit1: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    DirectoryListBox1: TDirectoryListBox;
    FileListBox1: TFileListBox;
    DriveComboBox1: TDriveComboBox;
    FilterComboBox1: TFilterComboBox;
    Timer1: TTimer;
    Panel2: TPanel;
    Label1: TLabel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    Label2: TLabel;
    Timer2: TTimer;
    procedure BitBtn3Click(Sender: TObject);
    procedure FileListBox1Change(Sender: TObject);
    procedure FileListBox1DblClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FileListBox1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure DirectoryListBox1Change(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
  private
    TheFileName: string;
   { Private declarations }
  public
    maindir:string;// for start expersystem
    e_state:string;// flag state reture maindir
    keystore:integer;
    procedure clrlist;
    procedure ffile(var name:string;var meet:boolean);
    procedure addsound(name:string);
    procedure pass;
    procedure inkey;
   { Public declarations }
  end;

var
  //first_s,last_s,new_s,temp_s:soundpoint;
  Form1: TForm1;

implementation

uses ai2, psound, ts_1;
{$R *.DFM}
type
    soundpoint = ^soundrec;
    soundrec   = record
                   name:string[50];
                   next:soundpoint;
                 end;

var
    first_s,last_s,new_s,temp_s:soundpoint;

procedure TForm1.FormCreate(Sender: TObject);
var s:string;
begin
 first_s:=nil;
 e_state:='';
 keystore:=0;
 getdir(0,s);
 panel1.Caption:=s;

end;
procedure Tform1.clrlist;
begin
          Dispose(first_s);
          first_s:=nil;
          temp_s:=first_s;
          last_s:=first_s;
end;

procedure TForm1.BitBtn3Click(Sender: TObject);
var s:string;
begin
     Form2.visible:=True;
     GetDir(0,s);
     Form2.Edit1.Text:=s;
end;

procedure TForm1.FileListBox1Change(Sender: TObject);
begin
  with FileListbox1 do
  begin
    if ItemIndex >= 0 then
    begin
      TheFileName := Items[ItemIndex];
      Edit1.text:=TheFileName;
      label1.Caption := Format('%s ', [TheFileName]);
    end
    else label1.Caption := '';
  end;
end;

procedure TForm1.FileListBox1DblClick(Sender: TObject);
begin
 with FileListbox1 do
  begin
     mainform.Playwave(thefilename);
    //ExecuteFile(theFileName, '', Directory, SW_SHOW);
    //FileListbox1.Cursor:= loadcursor(hInstance,'speaker1.cur');
    //PlaySound(PChar(theFileName),0,SND_ASYNC);
    //WinExec('Astream.exe',1);
    {GetDir(0,s);
    mediaplayer1.FileName:=s+'\'+thefilename;
    label2.caption:=mediaplayer1.FileName;
    label3.caption:=s+'\'+thefilename;
    mediaplayer1.Play;
    }
  end;
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
var s:string;
begin
      getdir(0,s);
      mkdir(s+'\'+edit1.text);{rmdir}
      if IOResult<>0then
       messagedlg('Cannot create directory',mtWarning,[mbOk],0)
      else
        DirectoryListBox1.Update;
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
var s:string;
    isu:integer;
begin
{$I-}
     GetDir(0,s);
     rmdir(s+'\'+Edit1.Text);{rmdir}
{$I+}
      isu:=IOResult;
      if isu<>0then
       messagedlg('Cannot Remove directory ',mtWarning,[mbOk],0)
      else
       DirectoryListBox1.Update;
end;

procedure TForm1.FileListBox1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key=vk_delete then
  begin
   with FileListbox1 do
    if MessageDlg('Delete ' + FileName + '?', mtConfirmation,
      [mbYes, mbNo], 0) = mrYes then
      if DeleteFile(theFileName) then Update;
  end;
end;

procedure TForm1.ffile(var name:string;var meet:boolean);
var  found:integer;
     stemp,sd:string;
     l:integer;
     S:TSearchRec;
begin
 GetDir(0,sd);
 name:=AnsiUpperCase(name);
 l:=length(name);
 Found := FindFirst(sd+'\*',faDirectory,s);
 while Found = 0 do
    begin
         Found:= Findnext(s);
         stemp:=s.name;
         stemp:=AnsiUpperCase(stemp);
         if ExtractFileExt(stemp)='.WAV' then
             begin
             stemp:=Copy(stemp,1,l);
             if stemp=name then
               begin
               Found:=1;
               name:=s.name;
               meet:=true;
               end
             else meet:=false;
             end;
     end;
FindClose(S);
end;

procedure Tform1.addsound(name:string);
begin
     new(new_s);
     new_s^.name:=name;
     if first_s = nil then
          begin
          first_s:=new_s;
          temp_s:=first_s;
          end

        else last_s^.next:=new_s;

      last_s:=new_s;
      last_s^.next:=nil;
    if temp_s=nil then temp_s:=last_s;// Good for live temp
end;

procedure Tform1.pass;
var meet:boolean;
    name:string;
    i:integer;
begin
 if not(timer1.Enabled) then
   begin
   name:='ask.wav';
   ffile(name,meet);
   if meet then
    begin
    addsound(name);
     for i:=1 to 5000 do
      begin
      name:=inttostr(i)+'_';
      ffile(name,meet);
      if meet then
      addsound(name)
      else break;
      end;
    end;
   name:='ans.wav';
   ffile(name,meet);
   if meet then
    begin
    addsound(name);
    e_state:='main dir';
    end
    else e_state:='';
   timer1.enabled:=true; // final tick timer
   end;
end;

procedure Tform1.inkey;
var
 name,dir:string;
 meet:boolean;
 l:integer;
begin
 form1.show;
 if (ts1.buff>=0) and (ts1.buff<=9) then
  begin
  keystore:=(keystore*10)+ts1.buff;
  end;
 if (ts1.buff=ent) then //  '#'phone key
  begin
  //
  form2.bitbtn2click(self);
  temp_s:=nil;

  //
  name:=inttostr(keystore)+'_';
  keystore:=0;
  ffile(name,meet);
      if meet then
      begin
      l:=length(name);
      name:=Copy(name,1,l-4);// cut '.wav'
      getdir(0,dir);
      dir:=dir+'\'+name;
      Directorylistbox1.Directory:=dir;
      pass;
      end;
  end;
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
 getdir(0,maindir);
 pass;
end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
begin
    mainform.show;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var name:string;
begin
     if temp_s=nil then
      begin
       timer1.Enabled:=false;
       Dispose(first_s);
       first_s:=nil;
       if e_state='main dir'then
       begin
       chdir(maindir);
       directorylistbox1.Directory:=maindir;
       end;
      end;
     if (mainform.Label1.caption='Stop') and
        (temp_s{^.next}<>nil) then
      begin
       mainform.show;
       name:=temp_s.name;
       mainform.Playwave(name);
       temp_s:=temp_s^.next;
      // if(temp_s=nil)then temp_s:=last_s; //replay last again
       ts1.sendint(cmand7);
       ts1.sendint(cmand13); // ena busy
//       ts1.sendint(cmand7);
      end;
end;

procedure TForm1.DirectoryListBox1Change(Sender: TObject);
begin
Panel1.caption:=DirectoryListbox1.Directory;
end;


procedure TForm1.Timer2Timer(Sender: TObject);
var s:string;
begin
getdir(0,s);
label2.caption:=s;
end;

end.
