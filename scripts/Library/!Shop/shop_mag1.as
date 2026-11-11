// Library symbol "!Shop/shop_mag1"

// ---- layer "Layer 3", frame 3
if (!_root.enableAnimations) {
	this.gotoAndStop("ready");
	this.anim.gotoAndStop("ready");
}

// ---- layer "Layer 1", frame 1
if (_root.bonusItemOwn[9]<=0) {
	this.anim.right.gotoAndStop(1);
	this.anim.left.gotoAndStop(1);
} else {
	this.anim.right.gotoAndStop(2);
	this.anim.left.gotoAndStop(2);
}

// ---- layer "Layer 1", frame 2
if (_root.bonusItemOwn[9]<=0) {
	this.anim.right.gotoAndStop(1);
	this.anim.left.gotoAndStop(1);
} else {
	this.anim.right.gotoAndStop(2);
	this.anim.left.gotoAndStop(2);
}

//Catalog tutorial
//showTut
_root.tutorial.showTut("catalog");

// ---- layer "Layer 1", frame 30 ("ready")
stop();

_root._quality = storedQuality;
storedQuality = null;

// ---- layer "Layer 1", frame 31 ("out")
if (!_root.enableAnimations) {
	this.gotoAndStop("outend");
}

// ---- layer "Layer 1", frame 45 ("outend")
stop();
_root.hideMag(_root);

// ---- layer "Layer 2", frame 2
blocker.onRelease = blocker.onRollOver = blocker.onRollOut = function () {
	//
};
