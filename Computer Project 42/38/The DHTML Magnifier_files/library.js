// Copyright (C) 1999 Richard Goode
// Email <bigfat1@hotmail.com>
// If you use this code, please let me know.
// Please leave these comment lines intact.

function initLayers(n) {
	for (var i = 1; i <= n; i++) {
	if (n4) {
	div[i] = eval("document.div" + i);
	div[i].x = div[i].left;
	div[i].y = div[i].top;
	div[i].w = div[i].clip.width;
	div[i].h = div[i].clip.height;
	}
	if (ie4) {
	div[i] = eval("div" + i + ".style");
	div[i].x = div[i].pixelLeft;
	div[i].y = div[i].pixelTop;
	div[i].w = div[i].pixelWidth;
	div[i].h = div[i].pixelHeight;
	}
	if (ie5) {
	div[i] = eval("div" + i);
	div[i].x = div[i].offsetLeft;
	div[i].y = div[i].offsetTop;
	div[i].w = div[i].offsetWidth;
	div[i].h = div[i].offsetHeight;
	}}}

function shiftTo(object,x,y) {
	object.x = x;
	object.y = y;
	if (ie5) {
	object.style.pixelLeft = object.x;
	object.style.pixelTop = object.y;
	}
	else {
	object.pixelLeft = object.x;
	object.pixelTop = object.y;
	}}

function clipBy(object,t,r,b,l) {
	if (n4) {
	object.clip.top = t;
	object.clip.right = r;
	object.clip.bottom = b;
	object.clip.left = l;
	}
	if (ie4) {
	object.clip = "rect(" + t + "px "+ r + "px " + b + "px " + l + "px)";
	}
	if (ie5) {
	object.style.clip = "rect(" + t + "px "+ r + "px " + b + "px " + l + "px)";
	}
	}

function showObject(object) {
	if (n4) object.visibility = "show";
	if (ie4) object.visibility = "visible";
	if (ie5) object.style.visibility = "visible";
	}

function hideObject(object) {
	if (n4) object.visibility = "hide";
	if (ie4) object.visibility = "hidden";
	if (ie5) object.style.visibility = "hidden";
	}

function showNestedLayer(id,parent) {
	if (n4) document.layers[parent].document.layers[id].visibility = "show"
	else if (ie) document.all[id].style.visibility = "visible"
	}

function hideNestedLayer(id,parent) {
	if (n4) document.layers[parent].document.layers[id].visibility = "hide"
	else if (ie) document.all[id].style.visibility = "hidden"
	}

function eventXcoord(e) {
	if (n4) { var x = e.pageX }
	if (ie) { var x = event.x + document.body.scrollLeft }
	return x;
	}

function eventYcoord(e) {
	if (n4) { var y = e.pageY }
	if (ie) { var y = event.y+document.body.scrollTop }
	return y;
	}

function canvasWidth() {
	if(n4) {
	x = innerWidth;
	}
	if (ie) {
	x =document.body.clientWidth;
	}
	return x;
	}

function canvasHeight() {
	if(n4) {
	x = innerHeight;
	}
	if (ie) {
	x =document.body.clientHeight;
	}
	return x;
	}


