// Library symbol "!System/!SystemButtons/sys_options_menu"

// ---- layer "Control", frame 2
_root._y = 2000;
_root.opt._y = -2000;

//freeze main array
_root.stopMainArray = true;


if (_root.controlMode == "mouse") {
	optTop.controlType.gotoAndStop(2);
} else {
	optTop.controlType.gotoAndStop(1);
}


if (!_root.enableAnimations) {
	this.onEnterFrame = function() {
		for (i=0; i<=4; i++) {
			_root.addBlur(_root.optionsSnap);
		}
	};
	for (i=0; i<=4; i++) {
		_root.addBlur(_root.optionsSnap);
	}
	this.gotoAndPlay("inpreend");
}



this.onEnterFrame = function() {
	_root.addBlur(_root.optionsSnap);
};

if (_root.quality == "LOW") {
	optTop.gotoAndStop(1);
} else if (_root._quality == "MEDIUM") {
	optTop.gotoAndStop(2);
} else {
	optTop.gotoAndStop(3);
}

// ---- layer "Control", frame 18 ("inend")
this.onEnterFrame = null;
stop();

// ---- layer "Control", frame 21 ("control1")
control.gotoAndStop(1);

control.btnChange1.onRelease = null;
control.btnChange2.onRelease = function() {
	_root.opt.gotoAndStop("control2");
	_root.controlMode = "mouse";
	_root.refreshControlMode();
};

btnDone.onRelease = function() {
	_root.opt.gotoAndStop("inend");
};

btnCustom.onRelease = function() {
	_root.opt.gotoAndStop("control3");
};

// ---- layer "Control", frame 22 ("control2")
control.gotoAndStop(2);

control.btnChange1.onRelease = function() {
	_root.opt.gotoAndStop("control1");
	_root.controlMode = "classic";
	_root.refreshControlMode();
};
control.btnChange2.onRelease = null;

btnDone.onRelease = function() {
	_root.opt.gotoAndStop("inend");
};

btnCustom.onRelease = function() {
	_root.opt.gotoAndStop("control3");
};

// ---- layer "Control", frame 23 ("control3")
control.gotoAndStop(1);

this.refreshControlScreen = function() {
	if (_root.KEY_LEFT == 37 && _root.KEY_LEFT2 == 65 && _root.KEY_RIGHT == 39 && _root.KEY_RIGHT2 == 68 && _root.KEY_BOOST == 32) {
		//Keys are set to default
		_root.controlSet = "basic";
	} else {
		//Using custom keys, disable dual config
		_root.KEY_LEFT2 = _root.KEY_LEFT;
		_root.KEY_RIGHT2 = _root.KEY_RIGHT;
		_root.controlSet = "custom";
	}
	_root.KEY_LEFT_STRING = _root.keycode_array[_root.KEY_LEFT];
	_root.KEY_RIGHT_STRING = _root.keycode_array[_root.KEY_RIGHT];
	_root.KEY_BOOST_STRING = _root.keycode_array[_root.KEY_BOOST];

	this.control.keyLeft.text = _root.KEY_LEFT_STRING;
	this.control.keyRight.text = _root.KEY_RIGHT_STRING;
	this.control.keyBoost.text = _root.KEY_BOOST_STRING;
};

this.refreshControlScreen();

btnDone.onRelease = function() {
	if (_root.controlMode == "mouse") {
		_root.opt.gotoAndStop("control2");
	} else {
		_root.opt.gotoAndStop("control1");
	}
};

btnDefault.onRelease = function() {
	_root.resetKey();
	this._parent.refreshControlScreen();
};

control.btnLeft.onRelease = function() {
	_root.opt.gotoAndStop("control4");
	_root.opt.control.gotoAndStop("left");
	_root.opt.currentlySetting = "left";
};

control.btnRight.onRelease = function() {
	_root.opt.gotoAndStop("control4");
	_root.opt.control.gotoAndStop("right");
	_root.opt.currentlySetting = "right";
};

control.btnBoost.onRelease = function() {
	_root.opt.gotoAndStop("control4");
	_root.opt.control.gotoAndStop("boost");
	_root.opt.currentlySetting = "boost";
};

// ---- layer "Control", frame 24 ("control4")
_root.resetKeyDown();
this.onEnterFrame = function() {
	for (i=0; i<_root.keydown_array.length; i++) {
		if (_root.keydown_array[i]) {
			if (_root.opt.currentlySetting == "left") {
				_root.KEY_LEFT = KEY_LEFT2=i;
			} else if (_root.opt.currentlySetting == "right") {
				_root.KEY_RIGHT = KEY_RIGHT2=i;
			} else if (_root.opt.currentlySetting == "boost") {
				_root.KEY_BOOST = i;
			} else {
				//invalid key holder
				trace("Key Assignment - nothing to assign key to");
			}
			_root.resetKeyDown();
			this.onEnterFrame = null;
			_root.opt.gotoAndStop("control3");
		}
	}
};

// ---- layer "Control", frame 25
_root._y = 0;
_root.opt._y = 0;

//resume main array
//freeze main array
_root.stopMainArray = false;

if (!_root.enableAnimations) {
	this.gotoAndStop("outend");
}

// ---- layer "top", frame 43 ("outend")
_root._y = 0;
_root.opt._y = 0;

stop();
