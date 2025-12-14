/***************************************************************************
Copyright (C) 1999 Thomas Brattli
Code made by and copyrighted to Thomas Brattli from 
www.bratta.com. Cannot be used anywere without my permission
****************************************************************************/
function keyboard_init(){if(n) document.captureEvents(Event.KEYPRESS | Event.KEYDOWN | Event.KEYUP)
document.onkeypress=kpress; document.onkeydown=kdown; document.onkeyup=kup;}
function kpress(e){ key=(n)?e.which:window.event.keyCode
switch(key){ case 49: menubig?mclick(0,0):mclickq(0);break;
case 50: menubig?mclick(1,1):mclickq(1); break;
case 51: menubig?mclick(2,2):mclickq(2); break;
case 52: menubig?mclick(3,3):mclickq(3); break;
case 53: menubig?mclick(4,4):mclickq(4); break;
case 53: menubig?mclick(5,5):mclickq(5); break;
case 110: topMenu(0); break; case 107: topMenu(1); break;
case 112: topMenu(2) ;break; case 109: changeMenu();break;
//case 108: changeLook();break;
case 115: location.href='scripts.html'; break;}}
function kdown(e){ key=n?e.which:window.event.keyCode
if(key==65 || key==97){checkscroll=true; scrollDown()
}else if(key==90 || key==122){checkscroll=true; scrollUp()}}
function kup(e){key=n?e.which:window.event.keyCode; if(key==65 || key==90 || key==122 || key==97) noScroll()}