
function funk(){
n = (document.layers) ? 1:0
ie = (document.all) ? 1:0
speed = 0
statdyn = "dynamic"
started = 0
if (n){
	s1 = document.bilder
	maxw = s1.clip.width
	}
if (ie){
	s1 = document.all.bilder.style
	maxw = s1.pixelWidth
	}
document.onmousemove = mouseMove

if (n) document.captureEvents(Event.MOUSEMOVE)
}
function mouseMove(e) {
if (n) {var x=e.pageX; var y=e.pageY}
if (ie) {var x=event.x; var y=event.y}
if(x > 50 && x < 219 && y > 10 && y < 30){
	speed = Math.round((x-135)/4)
	if (started == 0) {
		started = 1
		slide()
		}
	}
	else {
		speed = 0
		started = 0

		}
}
function slide(){
if(statdyn == "dynamic"){
	if(parseInt(s1.left) <= - ((maxw/3)*2) + 40) {
		s1.left = - ((maxw/3) - 50)
		}	if(parseInt(s1.left) >= - 40) {
		s1.left = - ((maxw/3) + 50)
		}
	s1.left = parseInt(s1.left) - speed
	}
if (started != 0) setTimeout("slide()",10)
}
