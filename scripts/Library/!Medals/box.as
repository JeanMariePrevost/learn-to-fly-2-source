// Library symbol "!Medals/box"

// ---- layer "lid", frame 1
if (!_root.enableAnimations) {
	this.gotoAndStop("end");
}

// ---- layer "lid", frame 26 ("end")
stop();

lidBtn.onRelease = function() {
	this.onRelease = null;
	_root.fadeTo("back");
};
