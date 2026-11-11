// Library symbol "!System/!Tutorials/tut"

// ---- layer "Over", frame 6
hideTut();

// ---- layer "Over", frame 12
hideTut();

// ---- layer "Over", frame 16
hideTut();

// ---- layer "Over", frame 22
hideTut();

// ---- layer "Over", frame 27
hideTut();

// ---- layer "Over", frame 30
hideTut();

// ---- layer "Over", frame 33
hideTut();

// ---- layer "Over", frame 36
hideTut();

// ---- layer "catcher", frame 1
this.showTut = function(data) {
	switch (data) {
		case "shop" :
			if (_root.tutorialsDone[0]) {
				//Already did this tutorial
				return;
			}
			_root.tutorialsDone[0] = true;
			break;
		case "catalog" :
			if (_root.tutorialsDone[1]) {
				//Already did this tutorial
				return;
			}
			_root.tutorialsDone[1] = true;
			break;
		case "bonus" :
			if (_root.tutorialsDone[2]) {
				//Already did this tutorial
				return;
			}
			_root.tutorialsDone[2] = true;
			break;
		case "story" :
			if (_root.tutorialsDone[3]) {
				//Already did this tutorial
				return;
			}
			_root.tutorialsDone[3] = true;
			break;
		case "classic" :
			if (_root.tutorialsDone[4]) {
				//Already did this tutorial
				return;
			}
			_root.tutorialsDone[4] = true;
			break;
		case "sleigh" :
			if (_root.tutorialsDone[5]) {
				//Already did this tutorial
				return;
			}
			_root.tutorialsDone[5] = true;
			break;
		case "boost" :
			if (_root.tutorialsDone[6]) {
				//Already did this tutorial
				return;
			}
			_root.tutorialsDone[6] = true;
			break;
		case "story_reminder" :
			if (_root.tutorialsDone[7]) {
				//Already did this tutorial
				return;
			}
			_root.tutorialsDone[7] = true;
			break;
		default:
			//not a correct case
			trace("showTut - Incorrect frame label");
			return;
	}
	_root.tutFreeze = true;
	_root.tutorialIsReady = false;
	this.gotoAndStop(data);
	this.shade.gotoAndStop(this._currentframe);
	this._visible = true;
	_root.callKeyDown = function(data) {
		if (_root.tutorialIsReady) {
			currentTutorialFrame = _root.tutorial._currentframe;
			_root.tutorial.gotoAndStop("buffer");
			_root.tutorial.shade.gotoAndStop(currentTutorialFrame+1);
			_root.tutorial.gotoAndStop(currentTutorialFrame+1);
			currentTutorialFrame = null;
		}
	};
	this.onRelease = function() {
		_root.callKeyDown(null);
	};
	this.catcher.onMouseMove = this.catcher.onMouseDown=this.catcher.onMouseUp=this.catcher.onPress=this.catcher.onRollOver=function () {
		//
	};
};

this.hideTut = function() {
	this.tutSnap.fillRect(this.tutSnap.rect,0x000000);
	this._visible = false;
	this.stop();
	callKeyDown = null;
	this.onRelease = null;
	_root.tutFreeze = false;
};

hideTut();
