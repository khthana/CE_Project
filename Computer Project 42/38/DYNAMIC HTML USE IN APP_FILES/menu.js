/***************************************************************************
Copyright (C) 1999 Thomas Brattli
Code made by and copyrighted to Thomas Brattli from 
www.bratta.com. Cannot be used anywere without my permission
****************************************************************************/
var n = (document.layers) ? 1:0;
var ie = (document.all) ? 1:0;
function makeMenu(obj,nest){nest=(!nest) ? '':'document.'+nest+'.'										
this.css=(n) ? eval(nest+'document.'+obj):eval('document.all.'+obj+'.style')					
this.ref=(n) ? eval(nest+'document.'+obj+'.document'):eval('document');		
this.height=n?this.ref.height:eval(obj+'.offsetHeight')
this.x=(n)? this.css.left:this.css.pixelLeft;this.y=(n)? this.css.top:this.css.pixelTop;							
this.hideIt=b_hideIt;	this.showIt=b_showIt; this.vis=b_vis;this.moveIt=b_moveIt											
return this}
function menuInit(){oMenuTop=new Array(); oMenuSub=new Array()
for(i=0;i<6;i++){oMenuTop[i]=new makeMenu('divMenuTop'+i,'divMenuCont')
oMenuSub[i]=new makeMenu('divMenuSub'+i,'divMenuCont.document.divMenuTop'+i)}
for(i=0;i<oMenuSub.length;i++){ oMenuSub[i].hideIt() }
for(i=1;i<oMenuTop.length;i++){ oMenuTop[i].moveIt(0,oMenuTop[i-1].y+oMenuTop[i-1].height) }}
function foldMenu(num){for(i=0;i<oMenuSub.length;i++){ if(i!=num) oMenuSub[i].hideIt() }
for(i=1;i<oMenuTop.length;i++){ oMenuTop[i].moveIt(0,oMenuTop[i-1].y+oMenuTop[i-1].height) }
oMenuSub[num].vis()?oMenuSub[num].showIt():oMenuSub[num].hideIt()
for(i=1;i<oMenuTop.length;i++){ 
if(!oMenuSub[i-1].vis()) oMenuTop[i].moveIt(0,oMenuTop[i-1].y+oMenuTop[i-1].height+oMenuSub[i-1].height) 
else oMenuTop[i].moveIt(0,oMenuTop[i-1].y+oMenuTop[i-1].height)}}
function mclickq(url,num){oLoading2.place();fadeHeading(num,5);goUrl('pages/'+url+'.html')}