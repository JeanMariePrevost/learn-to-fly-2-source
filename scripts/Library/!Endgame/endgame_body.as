// Library symbol "!Endgame/endgame_body"

// ---- layer "Layer 1", frame 1
if (_root.GAME_MODE == "story") {
	body.txtMode.text = "Story Mode";
} else {
	body.txtMode.text = "Classic Mode";
}

body.txtDays.text = _root.test_day+" days";


_root.onMouseDown = function() {
	_root.skipScene = null;
	_root.onMouseDown = null;
	_root.endGame.gotoAndStop("step1done");
};

_root.skipScene = function() {
	_root.endGame.onMouseDown();
};

// ---- layer "Layer 1", frame 41
body.txtPoints1.text = _root.endGameDaysReward;
body.txtPoints2.text = _root.endGameChallengesReward;
body.txtPoints3.text = _root.endGameDaysReward+_root.endGameChallengesReward;

_root.setBP(_root.endGameDaysReward+_root.endGameChallengesReward);
_root.completeAndSave();

// ---- layer "bg", frame 28 ("step1done")
stop();

_root.onMouseDown = function() {
	_root.skipScene = null;
	_root.onMouseDown = null;
	_root.endGame.gotoAndPlay("step2");
};

_root.skipScene = function() {
	_root.endGame.onMouseDown();
};

// ---- layer "bg", frame 29 ("step2")
_root.onMouseDown = function() {
	_root.skipScene = null;
	_root.onMouseDown = null;
	_root.endGame.gotoAndStop("step2done");
};

_root.skipScene = function() {
	_root.endGame.onMouseDown();
};

// ---- layer "bg", frame 56 ("step2done")
stop();

_root.onMouseDown = function() {
	_root.skipScene = null;
	_root.onMouseDown = null;
	_root.endGame.gotoAndPlay("step3");
};

_root.skipScene = function() {
	_root.endGame.onMouseDown();
};

// ---- layer "bg", frame 57 ("step3")
_root.onMouseDown = function() {
	_root.skipScene = null;
	_root.onMouseDown = null;
	if (_root.modesUnlocked) {
		_root.endGame.gotoAndPlay("step5");
	} else {
		_root.endGame.gotoAndStop("step3done");
	}
};

_root.skipScene = function() {
	_root.endGame.onMouseDown();
};

// ---- layer "bg", frame 67
//if already unlocked, skip to end
if (_root.modesUnlocked) {
	this.gotoAndPlay("step6");
} else {
	_root.modesUnlocked = true;
}

// ---- layer "bg", frame 85 ("step3done")
stop();

_root.onMouseDown = function() {
	_root.skipScene = null;
	_root.onMouseDown = null;
	_root.endGame.gotoAndPlay("step4");
};

_root.skipScene = function() {
	_root.endGame.onMouseDown();
};

	_root.modesUnlocked = true;

// ---- layer "bg", frame 86 ("step4")
_root.onMouseDown = function() {
	_root.skipScene = null;
	_root.onMouseDown = null;
	_root.endGame.gotoAndStop("step4done");
};

_root.skipScene = function() {
	_root.endGame.onMouseDown();
};

// ---- layer "bg", frame 114 ("step4done")
stop();

_root.onMouseDown = function() {
	_root.skipScene = null;
	_root.onMouseDown = null;
	_root.endGame.gotoAndPlay("step5");
};

_root.skipScene = function() {
	_root.endGame.onMouseDown();
};

// ---- layer "bg", frame 115 ("step5")
_root.skipScene = null;
_root.onMouseDown = null;
	_root.modesUnlocked = true;

// ---- layer "bg", frame 126 ("step6")
_root.skipScene = null;
_root.onMouseDown = null;

// ---- layer "bg", frame 133
stop();
_root.modesUnlocked = true;


if (_root.GAME_MODE == "classic") {
	_root.bestDaysForClassic = Math.min(_root.bestDaysForClassic, _root.test_day);
} else {
	_root.bestDaysForStory = Math.min(_root.bestDaysForStory, _root.test_day);
}


//exit result screen
_root.fadeTo("main_menu");
