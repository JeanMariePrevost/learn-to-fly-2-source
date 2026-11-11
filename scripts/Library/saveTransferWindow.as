// Library symbol "saveTransferWindow"

// ---- layer "Layer 2", frame 1
stop();

// ---- layer "Layer 2", frame 33
frame.btnYes.onRelease = function() {
	_root.saveTransferWindow.gotoAndPlay("out");
	_root.saveTransferWindow.frame.btnYes.onRelease = null;
};

frame.btnNo.onRelease = function() {
	_root.saveTransferWindow.gotoAndPlay("out");
	_root.saveTransferWindow.frame.btnNo.onRelease = null;
};

// ---- layer "Layer 2", frame 40
stop();

// ---- layer "Layer 2", frame 58
stop();
this._visible = false;
this._x = 10000;
catcher = null;
this = null;

// ---- layer "Layer 4", frame 8
catcher.onRelease = catcher.onMouseDown = catcher.onMouseUp = catcher.onRollOver = catcher.onRollOut = function () {
	//Catch!
};
