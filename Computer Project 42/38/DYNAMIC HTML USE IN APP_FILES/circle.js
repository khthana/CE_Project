/***************************************************************************
Copyright (C) 1999 Thomas Brattli
Code made by and copyrighted to Thomas Brattli from 
www.bratta.com. Cannot be used anywere without my permission
****************************************************************************/
radius=97 
startAngle=90
circleSpeed=10
moveAngle=5
var xcenter,ycenter,menuState,circleGoing;

function menu_init(){
	oBut=new Array()
	oBut[0]=new makeButton('div0','divExCont.document.divCont',0)
	oBut[1]=new makeButton('div1','divExCont.document.divCont',30)
	oBut[2]=new makeButton('div2','divExCont.document.divCont',-30)
	oBut[3]=new makeButton('div3','divExCont.document.divCont',-90)
	oBut[4]=new makeButton('div4','divExCont.document.divCont',-150)
	oBut[5]=new makeButton('div5','divExCont.document.divCont',-215)
	if(ie) oBut[0].moveIt(98,0)
	oSub=new Array()
	oSub[0]=new makeObj('divSub0','divExCont.document.divCont')
	oSub[1]=new makeObj('divSub1','divExCont.document.divCont')
	oSub[2]=new makeObj('divSub2','divExCont.document.divCont')
	oCenter=new makeObj('divCenter','divExCont.document.divCont')
	oCont=new makeObj('divCont','divExCont',page.x2-270,page.y50-110)
	oSubText=new makeObj('divSubText','divExCont.document.divCont')
	oHide=new makeObj('divHide','divExCont.document.divCont')
	oHide.clipTo(0,135,0,0)
	xcenter = oBut[0].x - radius*Math.cos(startAngle*Math.PI/180)
	ycenter = oBut[0].y + radius*Math.sin(startAngle*Math.PI/180)	
}
function makeButton(obj,nest,stop){
	nest=(!nest) ? '':'document.'+nest+'.'										
	this.css=(n) ? eval(nest+'document.'+obj):eval('document.all.'+obj+'.style')								
    this.ref=(n) ? eval(nest+'document.'+obj+'.document'):eval('document');		
	this.x=(n)? this.css.left:this.css.pixelLeft;
	this.y=(n)? this.css.top:this.css.pixelTop;													
	this.moveIt=b_moveIt										
	this.stop=stop		
	return this
}
function circleGo(radius,angleinc,angle,endangle,xcenter,ycenter,fn) {
	if ((Math.abs(angleinc)<Math.abs(endangle-angle))) {
		angle += angleinc
		var x = xcenter + radius*Math.cos(angle*Math.PI/180)
		var y = ycenter - radius*Math.sin(angle*Math.PI/180)
		for(i=1;i<oBut.length;i++){
			if(angle>=oBut[i].stop)	oBut[i].moveIt(x,y)
		}
		setTimeout("circleGo("+radius+","+angleinc+","+angle+","+endangle+","+xcenter+","+ycenter+",'"+fn+"')",circleSpeed)
	}else{
		if(angleinc<0) circleGoing=false; 
		eval(fn)
	}
}
var zIndex=5
function mclick(num){
	if(intro_ready){
		if(!circleGoing){
			mout(num)
			circleGoing=true
			activeButton=num
			if(menuState){
				oLoad.clipIt(0,oArrowDown.x+30,oTextBottom.y+80,0,20)
				circleGo(radius,moveAngle,oBut[5].stop,startAngle+5,xcenter,ycenter,'oHide.clipIt(0,135,130,0,5,"oHide.clipTo(0,135,135,0)"); fadeHeading('+num+'); moveCenter('+num+')')
			}else moveFromCenter(0)
		}
	}else{
		fadeHeading(num)
		circleGo(radius,moveAngle,oBut[5].stop,startAngle+5,xcenter,ycenter,'circle_intro('+num+')') 
	}
}
function circle_intro(num){
	mout(num)
	activeButton=num
	oHide.clipIt(0,135,130,0,5,"oHide.clipTo(0,135,135,0)")
	moveCenter(num)
	noIntro_init();
}	
function circle_intro2(num){
	oCont.slideIt(page.x2-270,page.y50-110,15,30,'placeAll(); intro_ready=true')
}
function moveCenter(num){
	if(oBut[0].y<95){
		circleGoing=true
		for(i=0;i<oBut.length;i++){
			oBut[i].moveIt(oBut[i].x+(i-2.5),oBut[i].y+3)
		}
		setTimeout("moveCenter("+num+")",30)
	}else changeToMenuText(num,0)
}
function changeToMenuText(num,i){
	if(i<oBut.length){
		oBut[i].ref["img"+i].src=prec[i].src; i++
		setTimeout("changeToMenuText("+num+","+i+")",70)
	}else moveSubMenus(num)
}
function moveSubMenus(num){
	oSub[0].moveIt(oBut[num].x,oBut[num].y)
	oSub[1].moveIt(oBut[num].x,oBut[num].y)
	oSub[2].moveIt(oBut[num].x,oBut[num].y)
	oSub[0].slideIt(20,55,5,30)
	oSub[1].slideIt(105,5,5,30)
	oSub[2].slideIt(190,55,5,30,'circleGoing=false; if(!intro_ready){circle_intro2('+num+')}')
	goUrl('pages/'+num+'.html')
	menuState=0
}
function moveFromCenter(){
	circleGoing=true
	oSub[0].slideIt(oBut[activeButton].x,oBut[activeButton].y,10,30,'oSub[0].moveIt(-50,0)')
	oSub[1].slideIt(oBut[activeButton].x,oBut[activeButton].y,10,30,'oSub[1].moveIt(-50,0)')
	oSub[2].slideIt(oBut[activeButton].x,oBut[activeButton].y,10,30,'oSub[2].moveIt(-50,0); oHide.clipIt(0,135,0,0,5,"oHide.clipTo(0,135,0,0)"); moveFromCenter1(0)')
}
function moveFromCenter1(i){
	if(i<oBut.length){
		oBut[i].ref["img"+i].src=pre[i].src
		i++
		setTimeout("moveFromCenter1("+i+")",70)
	}else moveFromCenter2()
}
function moveFromCenter2(){
	if(oBut[0].y>0){
		for(i=0;i<oBut.length;i++){
			oBut[i].moveIt(oBut[i].x-(i-2.5),oBut[i].y-3)
		}
		setTimeout("moveFromCenter2()",30)
	}else circleGo(radius,-moveAngle,startAngle,oBut[5].stop,xcenter,ycenter,'menuState=1')
}
function preLoad(num,path,path2){
	for(i=0; i<=num; i++){
		this[i]=new Image()
		this[i].src='images/'+path+(i+1)+path2+'.gif'
	}
	return this
}
preCenter=new preLoad(5,'center',''); pre=new preLoad(5,'',''); 
preb=new preLoad(5,'','_b'); prec=new preLoad(5,'','_c')

function mover(num){
	if(!circleGoing && menuState){
		oBut[num].ref["img"+num].src=preb[num].src
		oCenter.ref["imgCenter"].src=preCenter[num].src
	}
}
function mout(num){
	if(!circleGoing && menuState){
		oBut[num].ref["img"+num].src=pre[num].src
		oCenter.ref["imgCenter"].src='images/center.gif'
	}
}
subText=new Array()
subText[0]=new Array('Me','Site','Link')
subText[1]=new Array('DHTML','Books','Software')
subText[2]=new Array('Scripts','Tutorials','Demos')
subText[3]=new Array('TutorialSites','Demos&Scripts','Others')
subText[4]=new Array('Join','Leave','Archive')
subText[5]=new Array('Bugs','Feedback','Hire')

function subOver(num){
	if(!loading){
		x=(num==0)?30:(num==1)?110:190;
		y=(num==0)?50:(num==1)?5:55;
		oSubText.writeIt('<font face="arial,helvetica" size="2" color="#6380BB"><b>'+subText[activeButton][num]+'</b></font>')
		lwidth=n?oSubText.ref.width:oSubText.evnt.scrollWidth
		oSubText.moveIt(x-(lwidth/2),y+20)
		oSubText.showIt()
	}
}
function subOut(num){
	oSubText.hideIt()
}
function subClick(num){
	if(oLoad.clipactive==false) oLoad.clipIt(0,oArrowDown.x+30,oTextBottom.y+80,0,50,'goUrl("pages/"+subText[activeButton]['+num+']+".html")')
}