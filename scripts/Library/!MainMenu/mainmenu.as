// Library symbol "!MainMenu/mainmenu"

// ---- layer "Control", frame 1
btnnew.high = 400;
btnload.high = 300;
themePlayed = false;

btnnew.onRollOver = btnload.onRollOver = function () {
	this._parent.player.player.high = this.high;
	this._parent.player.player.onEnterFrame = function() {
		this.gotoAndStop(Math.ceil(this._currentframe + (this.high - this._currentframe) * 0.2));
		if (Math.abs(this._currentframe - this.high) <= 5) {
			this.gotoAndStop(this.high);
			this.onEnterFrame = null;
		}
	};
};

btnnew.onRollOut = btnload.onRollOut = function () {
	this._parent.player.player.high = 1;
	this._parent.player.player.onEnterFrame = function() {
		this.gotoAndStop(Math.ceil(this._currentframe + (this.high - this._currentframe) * 0.15));
		if (Math.abs(this._currentframe - this.high) <= 3) {
			this.gotoAndStop(this.high);
			this.onEnterFrame = null;
		}
	};
};

btnnew.onRelease = function() {
	_root.playSfx("beep2");
	this._parent.gotoAndPlay("newgame");
};

btnload.onRelease = function() {
	_root.playSfx("beep2");
	this._parent.gotoAndPlay("loadgame");
};

if (!_root.enableAnimations) {
	this.gotoAndPlay("ready");
}

this.onMouseDown = skipScene = function () {
	if (!themePlayed) {
		_root.playBgm("basic_theme1");
		themePlayed = true;
	}
	this.gotoAndStop("ready");
	this.onMouseDown = skipScene = null;
};

// ---- layer "Control", frame 78
_root.playBgm("basic_theme1");
themePlayed = true;

btnMore._visible = false;
btnMore._y = 10000;

// ---- layer "Control", frame 116
this.player.player.gotoAndStop(1);

// ---- layer "Control", frame 134 ("secretButtonFrame")
btnnew.high = 400;
btnload.high = 300;

btnnew.onRollOver = btnload.onRollOver=function () {
	this._parent.player.player.high = this.high;
	this._parent.player.player.onEnterFrame = function() {
		this.gotoAndStop(Math.ceil(this._currentframe+(this.high-this._currentframe)*0.2));
		if (Math.abs(this._currentframe-this.high)<=5) {
			this.gotoAndStop(this.high);
			this.onEnterFrame = null;
		}
	};
};

btnnew.onRollOut = btnload.onRollOut=function () {
	this._parent.player.player.high = 1;
	this._parent.player.player.onEnterFrame = function() {
		this.gotoAndStop(Math.ceil(this._currentframe+(this.high-this._currentframe)*0.15));
		if (Math.abs(this._currentframe-this.high)<=3) {
			this.gotoAndStop(this.high);
			this.onEnterFrame = null;
		}
	};
};

btnnew.onRelease = function() {
	_root.playSfx("beep2");
	this._parent.gotoAndPlay("newgame");
};

btnload.onRelease = function() {
	_root.playSfx("beep2");
	this._parent.gotoAndPlay("loadgame");
};

// ---- layer "Control", frame 135 ("ready")
stop();

btnmore._y = 10000;
btnmore._visible = false;

// ---- layer "Control", frame 136 ("newgame")
btnnew.enabled = false;
btnload.enabled = false;
btnmore.enabled = false;


this.player.player.high = 1;
this.player.player.onEnterFrame = function() {
	this.gotoAndStop(Math.ceil(this._currentframe+(this.high-this._currentframe)*0.15));
	if (Math.abs(this._currentframe-this.high)<=3) {
		this.gotoAndStop(this.high);
		this.onEnterFrame = null;
	}
};

if (!_root.enableAnimations) {
	this.gotoAndPlay("newgameend");
	btnstory.high = 400;
	btnclassic.high = 300;
	btnarcade.high = 200;

	btnstory.onRollOver = btnclassic.onRollOver=btnarcade.onRollOver=function () {
		_root.playSfx("beep1");
		this._parent.player.player.high = this.high;
		this._parent.player.player.onEnterFrame = function() {
			this.gotoAndStop(Math.ceil(this._currentframe+(this.high-this._currentframe)*0.2));
			if (Math.abs(this._currentframe-this.high)<=5) {
				this.gotoAndStop(this.high);
				this.onEnterFrame = null;
			}
		};
	};

	btnstory.onRollOut = btnclassic.onRollOut=btnarcade.onRollOut=function () {
		this._parent.player.player.high = 1;
		this._parent.player.player.onEnterFrame = function() {
			this.gotoAndStop(Math.ceil(this._currentframe+(this.high-this._currentframe)*0.15));
			if (Math.abs(this._currentframe-this.high)<=3) {
				this.gotoAndStop(this.high);
				this.onEnterFrame = null;
			}
		};
	};

	btnstory.onRelease = function() {
		_root.mainMenuNewGame("story");
		_root.playSfx("beep2");
		this._parent.gotoAndPlay("newgame2");
	};

	btnclassic.onRelease = function() {
		_root.mainMenuNewGame("classic");
		_root.playSfx("beep2");
		this._parent.gotoAndPlay("newgame2");
	};

	btnarcade.onRelease = function() {
		_root.mainMenuNewGame("arcade");
		_root.playSfx("beep2");
		this._parent.gotoAndPlay("newgame2");
	};
}

// ---- layer "Control", frame 167
btnstory.high = 400;
btnclassic.high = 300;
btnarcade.high = 200;

if (_root.modesUnlocked) {
	btnclassic._visible = btnarcade._visible=true;
	btnclassicoff._visible = btnarcadeoff._visible=false;
} else {
	btnclassic._visible = btnarcade._visible=false;
	btnclassicoff._visible = btnarcadeoff._visible=true;
}

//Overrides for modes locked by default
if(classicModeLockedByDefault){
	btnclassic._visible = true;
	btnclassicoff._visible = false;
}
if(arcadeModeLockedByDefault){
	btnarcade._visible = true;
	btnarcadeoff._visible = false;
}

btnstory.onRollOver = btnclassic.onRollOver=btnarcade.onRollOver=function () {
	_root.playSfx("beep1");
	this._parent.player.player.high = this.high;
	this._parent.player.player.onEnterFrame = function() {
		this.gotoAndStop(Math.ceil(this._currentframe+(this.high-this._currentframe)*0.2));
		if (Math.abs(this._currentframe-this.high)<=5) {
			this.gotoAndStop(this.high);
			this.onEnterFrame = null;
		}
	};
};

btnstory.onRollOut = btnclassic.onRollOut=btnarcade.onRollOut=function () {
	this._parent.player.player.high = 1;
	this._parent.player.player.onEnterFrame = function() {
		this.gotoAndStop(Math.ceil(this._currentframe+(this.high-this._currentframe)*0.15));
		if (Math.abs(this._currentframe-this.high)<=3) {
			this.gotoAndStop(this.high);
			this.onEnterFrame = null;
		}
	};
};

btnstory.onRelease = function() {
	_root.mainMenuNewGame("story");
	_root.playSfx("beep2");
	this._parent.gotoAndPlay("newgame2");
};

btnclassic.onRelease = function() {
	_root.mainMenuNewGame("classic");
	_root.playSfx("beep2");
	this._parent.gotoAndPlay("newgame2");
};

btnarcade.onRelease = function() {
	_root.mainMenuNewGame("arcade");
	_root.playSfx("beep2");
	this._parent.gotoAndPlay("newgame2");
};

// ---- layer "Control", frame 202 ("newgameend")
stop();

btnstory.high = 400;
btnclassic.high = 300;
btnarcade.high = 200;

if (_root.modesUnlocked) {
	btnclassic._visible = btnarcade._visible=true;
	btnclassicoff._visible = btnarcadeoff._visible=false;
} else {
	btnclassic._visible = btnarcade._visible=false;
	btnclassicoff._visible = btnarcadeoff._visible=true;
}

// ---- layer "Control", frame 203 ("newgame2")
btnstory.enabled = false;
btnclassic.enabled = false;
btnarcade.enabled = false;

this.player.player.high = 1;
this.player.player.onEnterFrame = function() {
	this.gotoAndStop(Math.ceil(this._currentframe+(this.high-this._currentframe)*0.15));
	if (Math.abs(this._currentframe-this.high)<=3) {
		this.gotoAndStop(this.high);
		this.onEnterFrame = null;
	}
};

if (!_root.enableAnimations) {
	this.gotoAndPlay("newgame2end");
}

// ---- layer "Control", frame 217
player.gotoAndPlay("out");

// ---- layer "Control", frame 241 ("newgame2end")
stop();

_root.stopBgm(5);

if (_root.GAME_MODE == "arcade") {
	_root.fadeTo("arcade");
} else {
	if (_root.GAME_MODE == "story") {
		_root.fadeTo("movieStoryIntro");
	} else {
		_root.fadeTo("game");
	}
}

// ---- layer "Control", frame 292 ("loadgame")
loadgame.back.onRelease = function() {
	_root.mainmenu.gotoAndPlay("loadgameback");
	this.onRelease = null;
};

for (i=1; i<=4; i++) {
	loadgame["state"+i].gotoAndStop(1);
	loadgame["state"+i].onRollOver = function() {
		this.gotoAndStop(2);
	};
	loadgame["state"+i].onRollOut = function() {
		this.gotoAndStop(1);
	};
	loadgame["state"+i].onPress = function() {
		this.gotoAndStop(3);
	};
	loadgame["state"+i].onDragOut = function() {
		this.gotoAndStop(2);
	};
	loadgame["state"+i].onDragOver = function() {
		this.gotoAndStop(3);
	};
	loadgame["state"+i].onMouseUp = function() {
		this.gotoAndStop(1);
	};
	loadgame["state"+i].onReleaseOutside = function() {
		this.gotoAndStop(1);
	};
	loadgame["state"+i].onRelease = function() {
		if (this.savedate.text == "File is empty" || this.savedate.text == "File reserved for auto-save") {
			return false;
		}
		this.gotoAndStop(2);
		//Load this state
		_root.loadGame(this.saveSlot);
		//HERE - Resetchallenge should not be here, since profile data is lost
		_root.resetChallenges(_root.GAME_MODE,true);//ttrue simply stops boolean (switches) from resetting
		_root.stopBGM(6);
		_root.fadeTo("shop");
		//this.savedAnim.gotoAndPlay(1);
	};
	loadgame["state"+i].saveSlot = i-1;
	loadgame["state"+i].savedAnim.gotoAndStop("end");
}
//save_game.gotoAndStop(1);


refreshSaveLabels = function () {
	getSharedObject();
	for (i=1; i<=4; i++) {
		loadgame["state"+i].mode.text = _root["saveState"+(i-1)].game_mode;
		loadgame["state"+i].completed._visible = false;
		_root["saveState"+(i-1)].GAME_ID;
		if (_root["saveState"+(i-1)].GAME_ID == "COMPLETED") {
			loadgame["state"+i].completed._visible = true;
		}
		if (_root["saveState"+(i-1)].game_mode == " Empty") {
			loadgame["state"+i].day.text = "";
			loadgame["state"+i].cash.text = "";
			if (i == 1) {
				loadgame["state"+i].savedate.text = "File reserved for auto-save";
			} else {
				loadgame["state"+i].savedate.text = "File is empty";
			}
		} else {
			loadgame["state"+i].day.text = "Day "+_root["saveState"+(i-1)].day;
			loadgame["state"+i].cash.text = _root["saveState"+(i-1)].player_cash+" $";
			loadgame["state"+i].savedate.text = _root["saveState"+(i-1)].save_date;
		}
	}
};
refreshSaveLabels();

if (!_root.enableAnimations) {
	this.gotoAndPlay("loadgameend");
}

// ---- layer "Control", frame 325 ("loadgameend")
stop();

// ---- layer "Control", frame 326 ("loadgameback")
for (i=1; i<=4; i++) {
	loadgame["state"+i].gotoAndStop(1);
	loadgame["state"+i].onRelease = null;
}
loadgame.backbtn.onRelease = null;

if (!_root.enableAnimations) {
	this.gotoAndPlay("loadgamebackend");
}

// ---- layer "Control", frame 359 ("loadgamebackend")
this.gotoAndStop("ready");


btnnew.high = 400;
btnload.high = 300;

btnnew.onRollOver = btnload.onRollOver=function () {
	this._parent.player.player.high = this.high;
	this._parent.player.player.onEnterFrame = function() {
		this.gotoAndStop(Math.ceil(this._currentframe+(this.high-this._currentframe)*0.2));
		if (Math.abs(this._currentframe-this.high)<=5) {
			this.gotoAndStop(this.high);
			this.onEnterFrame = null;
		}
	};
};

btnnew.onRollOut = btnload.onRollOut=function () {
	this._parent.player.player.high = 1;
	this._parent.player.player.onEnterFrame = function() {
		this.gotoAndStop(Math.ceil(this._currentframe+(this.high-this._currentframe)*0.15));
		if (Math.abs(this._currentframe-this.high)<=3) {
			this.gotoAndStop(this.high);
			this.onEnterFrame = null;
		}
	};
};

btnnew.onRelease = function() {
	_root.playSfx("beep2");
	this._parent.gotoAndPlay("newgame");
};

btnload.onRelease = function() {
	_root.playSfx("beep2");
	this._parent.gotoAndPlay("loadgame");
};

// ---- layer "btn2", frame 79
_root.playSfx("title_crash");

// ---- layer "btn3", frame 80
btnmore._y = 10000;
btnmore._visible = false;

// ---- layer "btn3", frame 99
btnmore._y = 10000;
btnmore._visible = false;

// ---- layer "btn3", frame 136
btnmore._y = 10000;
btnmore._visible = false;

// ---- layer "btn3", frame 155
btnMore._visible = false;
btnMore._y = 10000;

// ---- layer "btn3", frame 292
btnmore._y = 10000;
btnmore._visible = false;

// ---- layer "btn3", frame 309
btnmore._y = 10000;
btnmore._visible = false;

// ---- layer "btn3", frame 325
btnmore._y = 10000;
btnmore._visible = false;

// ---- layer "btn3", frame 326
btnmore._y = 10000;
btnmore._visible = false;

// ---- layer "btn3", frame 359
btnmore._y = 10000;
btnmore._visible = false;
