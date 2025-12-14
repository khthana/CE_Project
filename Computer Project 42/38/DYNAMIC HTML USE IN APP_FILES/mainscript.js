/***************************************************************************
Copyright (C) 1999 Thomas Brattli
All scripts here are made by and copyrighted to Thomas Brattli from
www.bratta.com and can under no circumstances be used anywhere else, if
you want to use this or something, please take contact with me at
dhtml@bratta.com.
****************************************************************************/
var n = (document.layers) ? 1:0;
var ie = (document.all) ? 1:0;
function makePageCoords(){this.x=0;this.x2=(n)?innerWidth:document.body.offsetWidth;
this.y=0;this.y2=(n)?innerHeight:document.body.offsetHeight;
this.x50=this.x2/2;	this.y50=this.y2/2;
this.x10=(this.x2*10)/100-5;this.y10=(this.y2*10)/100-5
this.x15=(this.x2*15)/100-5;this.y15=(this.y2*15)/100-5; return this;}
function makeObj(obj,nest,x,y){nest=(!nest) ? '':'document.'+nest+'.'										
this.css=(n) ? eval(nest+'document.'+obj):eval('document.all.'+obj+'.style')		
this.evnt=(n)? eval(nest+'document.'+obj):eval(obj);						
this.ref=(n) ? eval(nest+'document.'+obj+'.document'):eval('document');		
if(x && y) { this.pagex=x; this.pagey=y; this.place=b_place;}
this.writeIt=b_writeIt;
this.scrollHeight=n?this.ref.height:this.evnt.offsetHeight
this.scrollWidth=n?this.ref.width:this.evnt.offsetWidth
this.x=(n)? this.css.left:this.css.pixelLeft;
this.y=(n)? this.css.top:this.css.pixelTop;							
this.hideIt=b_hideIt;	this.showIt=b_showIt; this.vis=b_vis								
this.moveIt=b_moveIt; this.moveBy=b_moveBy;										
this.slide=b_slide; this.slideIt=b_slideIt;	this.bgChange=b_bgChange;					
this.clipIt=b_clipIt; this.clip=b_clip; this.clipactive=false;this.clipTo=b_clipTo;				
this.obj = obj + "Object"; 	eval(this.obj + "=this"); return this}
function b_showIt(){this.css.visibility="visible"}
function b_hideIt(){this.css.visibility="hidden"}
function b_vis(){if(this.css.visibility=="hidden" || this.css.visibility=="hide") return true;}
function b_bgChange(color){
if(ie) this.css.backgroundColor=color
else this.css.bgColor=color	}
function b_moveIt(x,y){this.x=x; this.y=y;
this.css.left=this.x;this.css.top=this.y}
function b_moveBy(x,y){this.x=this.x+x; this.y=this.y+y; 
this.css.left=this.x;this.css.top=this.y}
function b_place(){this.moveIt(this.pagex,this.pagey); this.showIt()}
function b_writeIt(text){if(n){this.ref.write(text);this.ref.close()}
if(ie) this.evnt.innerHTML=text}
function b_slideIt(endx,endy,inc,speed,fn,wh) {
if (!this.slideactive) {var distx = endx - this.x;var disty = endy - this.y
var num = Math.sqrt(Math.pow(distx,2) + Math.pow(disty,2))/inc
var dx = distx/num;var dy = disty/num
this.slideactive = 1; this.slide(dx,dy,endx,endy,speed,fn,wh)}}
function b_slide(dx,dy,endx,endy,speed,fn,wh) {
if (!fn) fn = null; if(!wh) wh=null
if (this.slideactive && (Math.floor(Math.abs(dx))<Math.floor(Math.abs(endx-this.x)) || Math.floor(Math.abs(dy))<Math.floor(Math.abs(endy-this.y)))) {
this.moveIt(this.x+dx,this.y+dy); eval(wh)
setTimeout(this.obj+".slide("+dx+","+dy+","+endx+","+endy+","+speed+",'"+fn+"','"+wh+"')",speed)
}else{this.slideactive = 0;this.moveIt(endx,endy);eval(fn)}}
function b_clipTo(t,r,b,l){if(n){this.css.clip.top=t;this.css.clip.right=r
this.css.clip.bottom=b;this.css.clip.left=l
}else{this.css.clip="rect("+t+","+r+","+b+","+l+")";}}
function b_clipIt(tstop,rstop,bstop,lstop,step,fn){
if(!fn) fn=null; var clipval=new Array()
if(ie) {clipval=this.css.clip; clipval=clipval.slice(5,clipval.length-1);
clipval=clipval.split(' '); for(var i=0;i<4;i++){clipval[i]=parseInt(clipval[i])}
}else{clipval[0]=this.css.clip.top; clipval[1]=this.css.clip.right
clipval[2]=this.css.clip.bottom; clipval[3]=this.css.clip.left}
totantstep=Math.max(Math.max(Math.abs((tstop-clipval[0])/step),Math.abs((rstop-clipval[1])/step)),
Math.max(Math.abs((bstop-clipval[2])/step),Math.abs((lstop-clipval[3])/step)))
if(!this.clipactive)this.clip(clipval[0],clipval[1],clipval[2],clipval[3],(tstop-clipval[0])/totantstep,
(rstop-clipval[1])/totantstep,(bstop-clipval[2])/totantstep,
(lstop-clipval[3])/totantstep,totantstep,0, fn)}
function b_clip(tcurr,rcurr,bcurr,lcurr,tperstep,rperstep,bperstep,lperstep,totantstep,antstep, fn){
tcurr=tcurr+tperstep; rcurr=rcurr+rperstep
bcurr=bcurr+bperstep; lcurr=lcurr+lperstep
this.clipTo(tcurr,rcurr,bcurr,lcurr)
if(antstep<totantstep){this.clipactive=true;	antstep++
setTimeout(this.obj+".clip("+tcurr+","+rcurr+","+bcurr+","+lcurr+","+tperstep+","
+rperstep+","+bperstep+","+lperstep+","+totantstep+","+antstep+",'"+fn+"')",50)	
}else{this.clipactive=false; eval(fn)}
}