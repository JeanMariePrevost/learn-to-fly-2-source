// Library symbol "!Shop/save_game_confirm"

// ---- layer "Layer 2", frame 2
if (!_root.enableAnimations) {
	this.gotoAndStop("ready");
}

blocker.onRollOver = blocker.onRollOut = blocker.onRelease = blocker.onMouseMove = blocker.onMouseDown = blocker.onMouseUp = function () {

};

// ---- layer "Layer 1", frame 7 ("ready")
stop();

// ---- layer "Layer 1", frame 8 ("out")
if (!_root.enableAnimations) {
	this.gotoAndStop("outend");
}

// ---- layer "Layer 1", frame 20 ("outend")
stop();
