/***************************************************************************
Copyright (C) 1999 Thomas Brattli
All scripts here are made by and copyrighted to Thomas Brattli from
www.bratta.com and can under no circumstances be used anywhere else, if
you want to use this or something, please take contact with me at
dhtml@bratta.com.
****************************************************************************/
function intro_init(){
	if(ie) oBanner.hideIt()
	oExCont.clipTo(0,200,200,0)
	oEx=new makeObj('divEx','divExCont')
	oEx.writeIt('<span style="font-family:Impact,arial black,arial,helvetica; font-size:'+(page.x2*3/100)+'pt; color:#CCCCCC">'+ex_text+'</span>')
	oEx.scrollWidth=n?oEx.ref.width:oEx.evnt.scrollWidth
	oEx.scrollHeight=n?oEx.ref.height:oEx.evnt.scrollHeight
	oEx.moveIt(page.x50-(oEx.scrollWidth/2),page.y50-(oEx.scrollHeight/2))
	oCircle=new makeObj('divCircle','divExCont')
	oCircle.showIt(); oExplain=new makeObj('divExplain','divExCont',50,80)
	oExplain.place(); oCircle.moveIt(0,0)
	if(n)document.captureEvents(Event.MOUSEMOVE)
	document.onmousemove=moveCircle;
	oCircleBottom=new makeObj('divCircleBottom','divExCont')
	oCircleBottom.moveIt(page.x50-200,page.y50+2)
	oCircleTop=new makeObj('divCircleTop','divExCont')
	oCircleTop.moveIt(page.x50-200,page.y50-42)
	oEnter=new Array()
	for(i=0;i<=5;i++){oEnter[i]=new makeObj('divEnter'+i,'divExCont')}
}
function moveCircle(e){	
	x=(n)?e.pageX:event.x; y=(n)?e.pageY:event.y
	oExCont.clipTo(y-100,x+100,y+100,x-100)
	oCircle.moveIt(x-100,y-100)
}
function showCont(){
	document.onmousemove=null; oExplain.moveIt(10,10)
	if(ie) oBanner.showIt()
	oExplain.writeIt('<font face="arial,helvetica" size="3"><a href="index.html?noanim,pages/0.html">[skip intro]</A></font>')
	oCircle.hideIt(); oExCont.clipIt(-20,page.x2+20,page.y2+20,-20,20,'writeOutEx()')
}
ex_text="Have you ever experienced DHTML?"
function writeOutEx(){
	if(ex_text.length>0){
		ex_text=ex_text.slice(0,ex_text.length-1)
		oEx.writeIt('<p style="font-family:Impact,arial black,arial,helvetica; font-size:'+(page.x2*3/100)+'pt; color:#CCCCCC">'+ex_text+'</p>')
		setTimeout("writeOutEx()",50)
	}else draw_circle()	
}
function draw_circle(){
	if(ie){ oCircleBottom.clipTo(0,0,100,0); oCircleTop.clipTo(0,400,100,400)}
	oCircleBottom.clipIt(0,400,100,0,20,'oCircleTop.clipIt(0,1000,100,0,20)'); next(0)
}
anim_0_x=new Array(-520,-515,-510,-490,-480,-470,-450,-440,-430,-420,-410,-398,-388,-375,-361,-346,-329,-311,-292,-272,-251,-230,-209,-187,-165,-142,-118,-94,-69,-44,-19,5,29,52,74,94,112,129,144,158,171,184,196,209,221,233,245,257,268,278,287,296,303,309,313,316,317,316,314,309,302,293,283,271,257,242,226,209,191,173,154,135,116,97,78,60,43,26,9,-8,-24,-41,-58,-75,-93,-112,-130,-148,-164,-180,-193,-204,-212,-218,-222,-224,-224,-222,-220,-216,-211,-206,-200,-193,-185,-177,-168,-155,-142,-127,-115,-95,-85,-70,-50,-40,-25,-10,0,4,7,10,14,16,20,26,30,35,37,41,45,47,51,56,60,63,66,71,75)
anim_0_y=new Array(-150,-160,-170,-180,-190,-200,-200,-205,-195,-185,-175,-165,-160,-155,-149,-143,-136,-130,-123,-118,-113,-109,-105,-102,-100,-98,-98,-97,-97,-98,-100,-102,-104,-107,-111,-116,-121,-126,-132,-137,-141,-145,-147,-148,-147,-144,-139,-133,-125,-116,-105,-93,-80,-66,-50,-34,-16,3,23,45,67,90,112,133,152,168,181,189,191,189,184,177,169,160,152,146,142,141,142,144,147,151,155,158,161,162,163,162,160,157,152,146,138,129,119,108,97,86,76,66,57,50,43,37,32,28,24,21,17,15,12,10,8,6,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)
function next(num){
	if(num<anim_0_x.length-20){
		oEnter[0].moveIt(anim_0_x[num]+page.x50-35,anim_0_y[num]+page.y50-13)	
		oEnter[1].moveIt(anim_0_x[num+4]+page.x50-35,anim_0_y[num+4]+page.y50-13)
		oEnter[2].moveIt(anim_0_x[num+8]+page.x50-35,anim_0_y[num+8]+page.y50-13)
		oEnter[3].moveIt(anim_0_x[num+12]+page.x50-35,anim_0_y[num+12]+page.y50-13)
		oEnter[4].moveIt(anim_0_x[num+16]+page.x50-35,anim_0_y[num+16]+page.y50-13)
		oEnter[5].moveIt(anim_0_x[num+20]+page.x50-35,anim_0_y[num+20]+page.y50-13)
		num++; setTimeout("next("+num+")",50)
	}
}
function next2(){
	oCircleBottom.clipIt(0,0,100,0,20,'oCircleTop.clipIt(0,400,100,400,20,"freespace()")')
	moveEnter(0)
}
function freespace(){
	anim_0_x=null;anim_0_y=null; oEx=null;oCircle=null;oCircleBottom=null;oCircleTop=null;
}
function moveEnter(num){
	if(num<15){
		for(i=0;i<oEnter.length;i++){oEnter[i].moveBy(-5+(i*2),-5)}
		num++; setTimeout("moveEnter("+num+")",50)
	}else next3(0)
}
function next3(num){
	if(num<oEnter.length){
		oEnter[num].writeIt('<a href="#" onclick="return false"><img src="images/'+(num+1)+'.gif" width=26 height=26 border="0"></a>')
		num++; setTimeout("next3("+num+")",300)
	}else{c_left=oEnter[2].x+25; c_top=oEnter[2].y; next4(0)}
}
var c_left,c_top; var angle=0
var angles=new Array(-120,-75,-22,22,75,120)
function next4(num){
	if(num<49){
		for(i=0;i<oEnter.length;i++){oEnter[i].moveIt(Math.round(c_left + angles[i]*Math.cos(angle*Math.PI/180)),Math.round(c_top + angles[i]*Math.sin(angle*Math.PI/180)))}
		angle+=15;num++;setTimeout("next4("+num+")",20)
	}else{next5(0)}
}
function next5(num){
	if(num<24){
		for(i=0;i<oEnter.length;i++){oEnter[i].moveBy(4.3-(2*i),-1.6)};num++
		if(num==23){oEnter[0].hideIt();oEnter[1].hideIt()
		oEnter[2].hideIt();oEnter[3].hideIt();oEnter[4].hideIt()}
		setTimeout("next5("+num+")",20)
	}else{
		oExplain.hideIt()
		oCont.clipTo(0,220,0,0)
		oCont.moveIt(page.x50-111,page.y50-127)
		oCont.showIt()
		oCont.clipIt(0,220,220,0,10,'oEnter[5].hideIt(); oEnter=null; circleGo(radius,-moveAngle,startAngle,oBut[5].stop,xcenter,ycenter,"menuState=1")')
	}
}