// Library symbol "!Shop/save_game"

// ---- layer "Layer 2", frame 2
if (!_root.enableAnimations) {
	this.gotoAndStop("ready");
}

// ---- layer "Layer 1", frame 20 ("ready")
stop();

// ---- layer "Layer 1", frame 21 ("out")
if (!_root.enableAnimations) {
	this.gotoAndStop("outend");
}

// ---- layer "Layer 1", frame 40 ("outend")
stop();
