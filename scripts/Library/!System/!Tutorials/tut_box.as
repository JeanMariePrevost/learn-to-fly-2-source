// Library symbol "!System/!Tutorials/tut_box"

// ---- layer "Layer 1", frame 1
this.onMouseDown = function() {
	if (_root.tutorialIsReady<>true) {
		_root.tutorialIsReady = true;
		this.onMouseDown = null;
	}
};

// ---- layer "Layer 1", frame 15
stop();

_root.tutorialIsReady=true;
