// Library symbol "!Shop/!mc/pageflip_back"

// ---- layer "Actions", frame 1
if (!_root.enableAnimations) {
	this.gotoAndStop("end");
}

// ---- layer "Actions", frame 18 ("end")
delete this.onEnterFrame;
this.stop();
_root.pageFlipped();
