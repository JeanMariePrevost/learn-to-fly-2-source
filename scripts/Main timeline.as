// Main timeline

// ---- frame 1
_global.drawTarget = this;

// ---- layer "GameVars", frame 1
//Default game options
var CONSOLE_ENABLED:Boolean = false;
var bonusPointSpendingCap:Number = 2500;
var classicModeLockedByDefault:Boolean = true;
var arcadeModeLockedByDefault:Boolean = true;
var secretRatioRise:Number = 0.005;
var secretRatioRob64:Number = 0.005;
var currentVersion:String = "1.14";
_root.versionTxt.text = currentVersion;

Array.prototype.parseValues = function(data) {
	//if data is a number, this function returns the single value at this index, parsed
	if (data <> undefined && data <> null && data >= 0 && data < this.length) {
		switch (this[data]) {
			case "true" :
				this[data] = true;
				break;
			case "false" :
				this[data] = false;
				break;
			default :
				this[data] = parseInt(this[data]);
				break;
		}
		return this[data];
	}
	//If data is null, return the whole array, parsed                                           
	for (i = 0; i < this.length; i++) {
		switch (this[i]) {
			case "true" :
				this[i] = true;
				break;
			case "false" :
				this[i] = false;
				break;
			default :
				this[i] = parseInt(this[i]);
				break;
		}
	}
	return this;
};


// ---- layer "CONSOLE", frame 1

CONSOLE_LINE_NUM = 12;

showConsole = function () {
	if (!CONSOLE_ENABLED) {
		return;
	}
	trace("Showing console...");
	_root.console._visible = true;
};
hideConsole = function () {
	_root.console._visible = false;
};


clearConsole = function () {
	for (i = CONSOLE_LINE_NUM; i >= 1; i--) {
		_root.console["line" + i].text = ":";
	}
};
toggleConsole = function () {
	if (!CONSOLE_ENABLED) {
		return;
	}
	//return;
	if (_root.console._visible == true) {
		hideConsole();
	} else {
		showConsole();
	}
};
postConsole = function (data) {
	if (!CONSOLE_ENABLED) {
		return;
	}
	//return;
	for (i = CONSOLE_LINE_NUM; i >= 2; i--) {
		_root.console["line" + i].text = _root.console["line" + (i - 1)].text;
	}
	_root.console.line1.text = "1: " + data;
};

hideConsole();
clearConsole();

// ---- layer "Control", frame 22
medalBox.m41.onRelease = function()
{
	triggerMedal(40);
	medalBox["m" + 41].gotoAndStop(41);
	medalBox["m" + 41].onRollOver();
};

// ---- layer "Version", frame 19
_root.versionTxt.text = currentVersion;

// ---- layer "DEBUG", frame 1

MovieClip.prototype.useHandCursor = false;
MovieClip.prototype.tabEnabled = false;
Button.prototype.useHandCursor = false;
Button.prototype.tabEnabled = false;
TextField.prototype.tabEnabled = false
_focusrect = false

Array.prototype.average = function() {
	arraySum = 0;
	for (i=0; i<this.length; i++) {
		arraySum += this[i];
	}
	return arraySum/this.length;
};

Array.prototype.reduceNoise = function(tolerance) {
	if (this.length<=2) {
		//array is too short to be sorted
		return false;
	}
	if (tolerance == undefined || tolerance == null) {
		tolerance = 3;
	}
	this.sort();
	arrayHigh = this[(this.length-1)/2]+tolerance;
	arrayLow = this[(this.length-1)/2]-tolerance;
	for (i=this.length-1; i>=0; i--) {
		if (this[i]>arrayHigh || this[i]<arrayLow || this[i] == null) {
			//outside bounds
			this.splice(i,1);
		}
	}
	return true;
};

// ---- layer "DEBUG", frame 6 ("init")
test_old_dis = 0;//Requires init for stage map 1st time

destroyedObstacles = new Array(1, 1, 1, 1, 1);//Holder for obstacles that were destroyed at least once, used for stage map, 1=frame 1, clean, 2=frame 2 , "X"
//tells the game to behaves normally when leaving cutscenes 
cutsceneBypass = false;

// ---- layer "DEBUG", frame 7 ("selector")
_root.play();

// ---- layer "DEBUG", frame 9 ("Jumpstart")
_quality = "MEDIUM";



_root.gotoAndStop("LBG");

// ---- layer "DEBUG", frame 13

// ---- layer "Control", frame 1
//Custom context menu
function deadClick() {
}

function setLowQuality() {
	_root._quality = "LOW";
	opt.optTop.gotoAndStop(1);
	refreshMenu();
}

function setMediumQuality() {
	_root._quality = "MEDIUM";
	opt.optTop.gotoAndStop(2);
	refreshMenu();
}
function setHighQuality() {
	_root._quality = "HIGH";
	opt.optTop.gotoAndStop(3);
	refreshMenu();
}


refreshMenu = function () {
	var myMenu:ContextMenu = new ContextMenu();
	myMenu.hideBuiltInItems();
	if (_quality == "HIGH") {
		var menuItem1:ContextMenuItem = new ContextMenuItem("[X] High Quality", setHighQuality);
		var menuItem2:ContextMenuItem = new ContextMenuItem("[  ] Medium Quality", setMediumQuality);
		var menuItem3:ContextMenuItem = new ContextMenuItem("[  ] Low Quality", setLowQuality);
	} else if (_quality == "LOW") {
		var menuItem1:ContextMenuItem = new ContextMenuItem("[  ] High Quality", setHighQuality);
		var menuItem2:ContextMenuItem = new ContextMenuItem("[  ] Medium Quality", setMediumQuality);
		var menuItem3:ContextMenuItem = new ContextMenuItem("[X] Low Quality", setLowQuality);
	} else {
		var menuItem1:ContextMenuItem = new ContextMenuItem("[  ] High Quality", setHighQuality);
		var menuItem2:ContextMenuItem = new ContextMenuItem("[X] Medium Quality", setMediumQuality);
		var menuItem3:ContextMenuItem = new ContextMenuItem("[  ] Low Quality", setLowQuality);
	}
	myMenu.customItems.push(menuItem1,menuItem2,menuItem3);
	_root.menu = myMenu;
};

refreshMenu();

// ---- layer "Control", frame 2
stop();

loadanim.stop();

myInterval = setInterval(preload, 50);
speedInterval = setInterval(setSpeed, 200);

array = new Array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
current = 0;
old = 0;
speedDelay = 10;
commentDelay = 120;
loadanim.txt3.text = "0.0KB/s";
loadanim.commentFx.gotoAndPlay("out");
currentStage = 1;
preloaderDone = false;

function preload() {
	if (preloaderDone) {
		array = null;
		arraySum = null;
		current = null;
		old = null;
		total = null;
		pctLoaded = null;
		speedDelay = null;
		clearInterval(myInterval);
		clearInterval(speedInterval);
		preload = null;
		return;
	}
	old = current;
	current = _root.getBytesLoaded();
	total = _root.getBytesTotal();
	var pctLoaded = Math.ceil(current / total * 400);
	commentDelay--;
	if (commentDelay <= 0) {
		commentDelay = 120;
		loadanim.commentFx.gotoAndPlay("in");
	}
	loadanim.txt1.text = Math.ceil(current / total * 100) + "%";
	loadanim.txt2.text = Math.ceil(current * 0.001) + "KB / " + Math.ceil(total * 0.001) + "KB";
	loadanim.gotoAndStop(pctLoaded);
	if (current == total) {
		preloaderDone = true;
		currentStage = 5;
		loadanim.commentFx.gotoAndPlay("in");
		loadanim.gotoAndStop(401);
		loadanim.txt1.text = "100%";
		loadanim.txt2.text = Math.ceil(current * 0.001) + "KB / " + Math.ceil(total * 0.001) + "KB";
		loadanim.txt3.text = "0.0KB/s";
	}

}

speedOld = 0;
speedArray = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
function setSpeed() {
	currentSpeed = (current - speedOld) / 250;
	speedArray.push(currentSpeed);
	speedArray.shift();
	loadanim.txt3.text = Math.round(speedArray.average()) + "KB/s";
	speedOld = current;
}

// ---- layer "Control", frame 6
MovieClip.prototype.useHandCursor = false;
MovieClip.prototype.tabEnabled = false;
Button.prototype.useHandCursor = false;
Button.prototype.tabEnabled = false;
Object.prototype.useHandCursor = false;
Object.prototype.tabEnabled = false;
TextField.prototype.useHandCursor = false;
TextField.prototype.tabEnabled = false
_focusrect = false
stopMainArray = false;

// ---- layer "Control", frame 11 ("game")
challengeNameHolder = [];
challengeRewardHolder = [];
challengeIndexHolder = [];
stopMainArray = false;

// ---- layer "Control", frame 13 ("result")
stopBgm(1);
if (_root.GAME_MODE == "story") {
	_root.attachMovie("results","dayResults",_root.getNextHighestDepth());
} else if (_root.GAME_MODE == "arcade") {
	_root.attachMovie("results_arcade","dayResults",_root.getNextHighestDepth());
} else {
	_root.attachMovie("results_noDes","dayResults",_root.getNextHighestDepth());
}
dayResults.bmd.attachBitmap(snapshot,dayResults.bmd.getNextHighestDepth());
_root.dayResults._x = 320;

if (REF_distance>=0) {
	distanceTotal += REF_distance;
} else {
	reverseTotal -= REF_distance;

}
durationTotal += REF_duration;
diveTotal -= REF_max_depth;
bestAltitude = Math.max(bestAltitude, REF_max_altitude);
bestSpeed = Math.max(bestSpeed, REF_max_speed);
bestObstaclesInADay = Math.max(bestObstaclesInADay, obstacleDestroyedToday);

movie_holder.moviePlanetCrusher.removeMovieClip();

//increment days
if (GAME_MODE<>"arcade") {
	test_day++;
	daysTotal++;
	pacifistDays++;
	if (GAME_MODE<>"story") {
		pacifistDays = 0;
	}
	bestPacifistDays = Math.max(bestPacifistDays, pacifistDays);
}else{
	daysTotal++;
}
stopMainArray = false;

// ---- layer "Control", frame 14 ("shop")
if (_root.dayResults<>undefined) {
	_root.dayResults.removeMovieClip();
}
//tells the game to behaves normally when leaving cutscenes 
cutsceneBypass = false;

stopMainArray = false;
triggerMedal();

bestCash = Math.max(bestCash, test_player_cash);

// ---- layer "Control", frame 15 ("arcade")
if (_root.dayResults<>undefined) {
	_root.dayResults.removeMovieClip();
}
//tells the game to behaves normally when leaving cutscenes 
cutsceneBypass = false;

stopMainArray = false;

// ---- layer "Control", frame 16 ("arcade_ready")
if (_root.dayResults<>undefined) {
	_root.dayResults.removeMovieClip();
}
//tells the game to behaves normally when leaving cutscenes 
cutsceneBypass = false;

stopMainArray = false;
triggerMedal();

// ---- layer "Control", frame 20 ("tut")
tut.btnYes.onRelease = function() {
	_root.enableTutorials = true;
	_root.fadeTo("shop");
	this.enabled = false;
};
tut.btnNo.onRelease = function() {
	_root.enableTutorials = "skip";
	if (_root.GAME_MODE == "story") {
		_root.fadeTo("movieStoryIntro");
	} else {
		_root.fadeTo("game");
	}
	this.enabled = false;
};
tut.btnNever.onRelease = function() {
	_root.enableTutorials = false;
	if (_root.GAME_MODE == "story") {
		_root.fadeTo("movieStoryIntro");
	} else {
		_root.fadeTo("game");
	}
	this.enabled = false;
};

// ---- layer "Control", frame 22 ("medals")
for (i=1; i<=50; i++) {
	medalBox["m"+i].index = i;
	if (medalBool[i-1]) {
		medalBox["m"+i].gotoAndStop(i);
	} else {
		medalBox["m"+i].gotoAndStop(i+100);
	}
	medalBox["m"+i].onRollOver = function() {
		if (_root.medalBool[this.index-1]) {
			this._parent.hint.gotoAndStop(this.index);
		} else {
			this._parent.hint.gotoAndStop(this.index+100);
		}
		this._parent.hint.txtBP.text = medalReward[this.index-1]+" BP";
		this._parent.hint.progressText.text = _root.getMedalProgress(this.index-1);
	};
}

medalBox.hint.gotoAndStop(51);

medalBox.back.onRelease = function() {
	_root.fadeTo("back");
};

medalBox["m"+33]._visible = false;

// ---- layer "Control", frame 26 ("endgame")
//Calculating the BP reward
//basic function is
//Math.max(25, Math.min(250, Math.ceil((-80*Math.log(16-14)+300)/10)*10))

if (GAME_MODE == "classic") {
	endGameDaysReward = Math.max(50, Math.min(500, Math.ceil((-150 * Math.log(Math.max(0, test_day)) + 750) / 10) * 10));

} else {
	endGameDaysReward = Math.max(50, Math.min(500, Math.ceil((-150 * Math.log(Math.max(0, test_day - 5)) + 850) / 10) * 10));
}

challengeAmount = 0;
for (j = 0; j < challengeBool.length; j++) {
	if (challengeBool[j]) {
		challengeAmount++;
	}
}
if (GAME_MODE == "story") {
	triggerMedal(24);
	//35
	//endGameChallengesReward = Math.ceil(challengeAmount/35*50);
	endGameChallengesReward = Math.min(50, Math.ceil(0.0405 * Math.pow(challengeAmount, 2)));
} else if (GAME_MODE == "classic") {
	triggerMedal(25);
	//26
	//endGameChallengesReward = Math.ceil(challengeAmount/26*50);
	endGameChallengesReward = Math.min(50, Math.ceil(0.073 * Math.pow(challengeAmount, 2)));
}




if (GAME_MODE == "classic") {
	if (test_day <= 6) {
		endGame.body.comment.gotoAndStop(1);
	} else if (test_day <= 10) {
		endGame.body.comment.gotoAndStop(2);
	} else if (test_day <= 17) {
		endGame.body.comment.gotoAndStop(3);
	} else if (test_day <= 24) {
		endGame.body.comment.gotoAndStop(4);
	} else if (test_day <= 32) {
		endGame.body.comment.gotoAndStop(5);
	} else if (test_day <= 44) {
		endGame.body.comment.gotoAndStop(6);
	} else if (test_day <= 55) {
		endGame.body.comment.gotoAndStop(7);
	} else {
		endGame.body.comment.gotoAndStop(8);
	}
} else {
	if (test_day <= 10) {
		endGame.body.comment.gotoAndStop(1);
	} else if (test_day <= 22) {
		endGame.body.comment.gotoAndStop(2);
	} else if (test_day <= 30) {
		endGame.body.comment.gotoAndStop(3);
	} else if (test_day <= 36) {
		endGame.body.comment.gotoAndStop(4);
	} else if (test_day <= 42) {
		endGame.body.comment.gotoAndStop(5);
	} else if (test_day <= 48) {
		endGame.body.comment.gotoAndStop(6);
	} else if (test_day <= 56) {
		endGame.body.comment.gotoAndStop(7);
	} else {
		endGame.body.comment.gotoAndStop(8);
	}
}

// ---- layer "Control", frame 27 ("movieIntro")
_root.SFX_MULT = 2;

skipScene = function () {
	if (movie._currentframe <= 15) {
		return;
	}
	_root.SFX_MULT = 1;
	if (cutsceneBypass) {
		cutsceneBypass = false;
		_root.fadeTo("vhs");
	} else {
		_root.fadeTo("main_menu");
	}
	skipScene = null;
	_root.onMouseDown = null;
};

_root.onMouseDown = function() {
	skipScene();
};

//movie available in VHS screen
movieUnlocked[0] = true;

// ---- layer "Control", frame 28 ("movieStoryIntro")
_root.SFX_MULT = 2.5;

skipScene = function () {
	if (movie._currentframe <= 15) {
		return;
	}
	_root.SFX_MULT = 1;
	if (cutsceneBypass) {
		cutsceneBypass = false;
		_root.fadeTo("vhs");
	} else {
		_root.fadeTo("game");
	}
	skipScene = null;
	_root.onMouseDown = null;
};

_root.onMouseDown = function() {
	skipScene();
};


//movie available in VHS screen
movieUnlocked[1] = true;

// ---- layer "Control", frame 29 ("movieStoryOutro")
dayIsOver = true;
clearMain();

_root.SFX_MULT = 4;

skipScene = function () {
	if (movie._currentframe <= 35) {
		return;
	}
	_root.SFX_MULT = 1;
	if (cutsceneBypass) {
		cutsceneBypass = false;
		_root.fadeTo("vhs");
	} else {
		_root.fadeTo("endGame");
	}
	skipScene = null;
	_root.onMouseDown = null;
};

_root.onMouseDown = function() {
	skipScene();
};

//movie available in VHS screen
movieUnlocked[2] = true;

// ---- layer "Control", frame 30 ("movieClassicOutro")
dayIsOver = true;
clearMain();

_root.SFX_MULT = 1.7;

skipScene = function () {
	if (movie._currentframe <= 65) {
		return;
	}
	_root.SFX_MULT = 1;
	if (cutsceneBypass) {
		cutsceneBypass = false;
		_root.fadeTo("vhs");
	} else {
		_root.fadeTo("endGame");
	}
	skipScene = null;
	_root.onMouseDown = null;
};

_root.onMouseDown = function() {
	skipScene();
};

//movie available in VHS screen
movieUnlocked[4] = true;

// ---- layer "Control", frame 31 ("moviePacifist")
dayIsOver = true;
clearMain();

_root.SFX_MULT = 2;

skipScene = function () {
	if (movie._currentframe <= 35) {
		return;
	}
	_root.SFX_MULT = 1;
	if (cutsceneBypass) {
		cutsceneBypass = false;
		_root.fadeTo("vhs");
	} else {
		_root.triggerMedal(31);
		_root.stageFinished();
	}
	skipScene = null;
	_root.onMouseDown = null;
};

_root.onMouseDown = function() {
	skipScene();
};

//movie available in VHS screen
movieUnlocked[3] = true;

// ---- layer "Control", frame 41 ("LBG")
stop();

skipSplash = function ()
{
	_root.stopSfx();
	_root.gotoAndStop("movieIntro");
};
mainMenuNewGame = function (data) {
	switch (data) {
		case "story" :
			_root.GAME_MODE = "story";
			break;
		case "classic" :
			_root.GAME_MODE = "classic";
			break;
		case "arcade" :
			_root.GAME_MODE = "arcade";
			break;
	}
	_root.loadGame(-1);
	resetChallenges();
	//-----------------------------------------------------------
};

// ---- layer "Options menu", frame 8
import flash.display.*;
import flash.geom.*;
import flash.filters.*;
import flash.*

var optionsSnap = new BitmapData(640, 480, false, 0x000000);

var optionsSnapBlur = new BlurFilter(5, 5, 1);

optionsPrintScreen = function () {
	optionsSnap.draw(_global.drawTarget,new Matrix(),new ColorTransform(),"normal",new flash.geom.Rectangle(0, 0, 640, 480));
	opt.bg.attachBitmap(optionsSnap,opt.bg.getNextHighestDepth());
};

addBlur = function (data) {
	data.applyFilter(data,data.rectangle,null,optionsSnapBlur);
};


opt.stop();
if (enableTransitions == false) {
	opt.optTop.chk1.gotoAndStop(1);
} else {
	opt.optTop.chk1.gotoAndStop(2);
	enableTransitions = true;
}
if (enableAnimations == false) {
	opt.optTop.chk2.gotoAndStop(1);
} else {
	opt.optTop.chk2.gotoAndStop(2);
	enableAnimations = true;
}
if (_root.quality == "LOW") {
	opt.optTop.gotoAndStop(1);
} else if (_root._quality == "MEDIUM") {
	opt.optTop.gotoAndStop(2);
} else {
	opt.optTop.gotoAndStop(3);
}
opt.optTop.volumeSfx.gotoAndStop(Math.ceil(sfxVolume));
opt.optTop.volumeBgm.gotoAndStop(Math.ceil(bgmVolume));
if (_root.controlMode == "mouse") {
	opt.optTop.controlType.gotoAndStop(2);
} else {
	opt.optTop.controlType.gotoAndStop(1);
}
opt.optTop.btnControl.onRelease = function() {
	if (_root.controlMode == "mouse") {
		opt.gotoAndStop("control2");
	} else {
		opt.gotoAndStop("control1");
	}
};

opt.optTop.btnlow.onRelease = function() {
	_root.opt.optTop.gotoAndStop(1);
	_root._quality = "LOW";
};
opt.optTop.btnmed.onRelease = function() {
	_root.opt.optTop.gotoAndStop(2);
	_root._quality = "MEDIUM";
};
opt.optTop.btnhigh.onRelease = function() {
	_root.opt.optTop.gotoAndStop(3);
	_root._quality = "HIGH";
};
opt.optTop.btnTrans.onRelease = function() {
	if (_root.enableTransitions == false) {
		_root.opt.optTop.chk1.gotoAndStop(2);
		_root.enableTransitions = true;
	} else {
		_root.opt.optTop.chk1.gotoAndStop(1);
		_root.enableTransitions = false;
	}
};
opt.optTop.btnAnims.onRelease = function() {
	if (_root.enableAnimations == false) {
		_root.opt.optTop.chk2.gotoAndStop(2);
		_root.enableAnimations = true;
	} else {
		_root.opt.optTop.chk2.gotoAndStop(1);
		_root.enableAnimations = false;
	}
};

opt.optTop.btnclear.onRelease = function() {
	_root.opt.gotoAndStop("clear");
	_root.opt.btnYes.onRelease = function() {
		_root.deleteSO();
		_root._quality = "LOW";
		_root._quality = "LOW";
		_root.gotoAndPlay(1);
		return;
	};
	_root.opt.btnNo.onRelease = function() {
		_root.opt.gotoAndStop("inend");
	};
};
opt.optBot.onRelease = function() {
	_root.opt.gotoAndPlay("out");
};
opt.optQuit.onRelease = function() {
	//Quit in option menu
	_root.opt.gotoAndStop("quit");
	_root.opt.btnYes.onRelease = function() {
		_root.tutorial.hideTut();
		_root.fadeTo("main_menu");
		_root.stopBgm(2);
		_root.opt.gotoAndStop("outend");
	};
	_root.opt.btnNo.onRelease = function() {
		_root.opt.gotoAndStop("inend");
	};
};

opt.optTop.btnsfx.onPress = function() {
	_root.opt.dragTarget = _root.opt.optTop.volumeSfx;
	_root.opt.dragTargeta = "sfx";
	_root.opt.onMouseMove();
};
opt.optTop.btnbgm.onPress = function() {
	_root.opt.dragTarget = _root.opt.optTop.volumeBgm;
	_root.opt.dragTargeta = "bgm";
	_root.opt.onMouseMove();
};
opt.onMouseMove = function() {
	if (this.dragTarget<>null && this.dragTarget<>undefined) {
		if (this.dragTargeta == "sfx") {
			_root.sfxVolume = Math.round(Math.min(100, Math.max(0, (this.dragTarget._xmouse-4)/1.76)));
		} else if (this.dragTargeta == "bgm") {
			_root.bgmVolume = Math.round(Math.min(100, Math.max(0, (this.dragTarget._xmouse-4)/1.76)));
		}
		sfxVolumeCursor = sfxVolume;
		bgmVolumeCursor = bgmVolume;

		opt.optTop.volumeSfx.gotoAndStop(Math.ceil(sfxVolumeCursor));
		opt.optTop.volumeBgm.gotoAndStop(Math.ceil(bgmVolumeCursor));
		_root.refreshMasterVolume();
	}
};
opt.onMouseUp = function() {
	this.dragTarget = null;
};

// ---- layer "System btns", frame 8
mute = forceMute;

sys.gotoAndStop(1);
if (_root.mute <>1) {
	sys.mute.gotoAndStop(2);
	_root.mute = 0;
} else {
	sys.mute.gotoAndStop(1);
	_root.mute = 1;
}
sys.onEnterFrame = function() {
	this._alpha = Math.max(25, this._alpha-5);
	if (this._alpha<=25) {
		this.onEnterFrame = null;
	}
};


sys.onRollOver = function() {
	this.over = true;
	this.onEnterFrame = function() {
		this._alpha = Math.min(100, this._alpha+10);
		if (this._alpha>=100) {
			this.onEnterFrame = null;
		}
	};
};
sys.onRollOut = function() {
	this.over = false;
	this.gotoAndStop(1);
	this.onEnterFrame = function() {
		this._alpha = Math.max(25, this._alpha-5);
		if (this._alpha<=25) {
			this.onEnterFrame = null;
		}
	};
};
sys.onMouseMove = function() {
	if (this.over) {
		if (this._xmouse<=45) {
			if (this.mouseIsDown) {
				this.gotoAndStop(3);
			} else {
				this.gotoAndStop(2);
			}
		} else {
			if (this.mouseIsDown) {
				this.gotoAndStop(5);
			} else {
				this.gotoAndStop(4);
			}
		}
	}
};
sys.onMouseDown = function() {
	if (this.over) {
		this.mouseIsDown = true;
		if (this._xmouse<=45) {
			this.gotoAndStop(3);
		} else {
			this.gotoAndStop(5);
		}
	}
};
sys.onMouseUp = function() {
	this.mouseIsDown = false;
	if (this._currentframe == 3) {
		//release menu
		_root.opt.gotoAndPlay("in");
		if (_root._currentframe == 10) {
			_root.opt.optQuit._visible = false;
		} else {
			_root.opt.optQuit._visible = true;
		}
		_root.optionsPrintScreen();
		this.gotoAndStop(2);
	} else if (this._currentframe == 5) {
		//release mute
		if (_root.mute == 1) {
			_root.mute = 0;
			_root.setVolume(0);
			this.mute.gotoAndStop(2);
		} else {
			_root.mute = 1;
			this.mute.gotoAndStop(1);
		}
		refreshMasterVolume();
		this.gotoAndStop(4);
	}
};
sys.onReleaseOutside = function() {
	this.mouseIsDown = false;
	this.onRollOut();
};
sys.onDragOut = function() {
	this.over = false;
};
sys.onDragOver = function() {
	this.over = true;
};

// ---- layer "Tutorials", frame 11
//tutorialsDone(shop,catalog,story,classic,bonus,sleigh)

playerSleigh = getEquip("sleigh");
playerGlider = getEquip("glider");
playerBoost = getEquip("boost");
playerPayload = getEquip("payload");

if (!tutorialsDone[3] && GAME_MODE == "story") {
	tutorial.showTut("story");
} else if (!tutorialsDone[4] && GAME_MODE == "classic") {
	tutorial.showTut("classic");
} else if (!tutorialsDone[5] && stat_sleigh_jump[playerSleigh]>0) {
	tutorial.showTut("sleigh");
} else if (!tutorialsDone[6] && stat_boost_thrust[playerBoost]>0) {
	tutorial.showTut("boost");
}else if (!tutorialsDone[7] && test_day >=10 && pacifistDays+1 == test_day){
	tutorial.showTut("story_reminder");
}

// ---- layer "Tutorials", frame 14
tutorial.showTut("shop");

// ---- layer "Tutorials", frame 18
tutorial.showTut("bonus");

// ---- layer "Bonus Points", frame 8
//Adds/Substract "data" from test_player_points and shows popUp animation
setBP = function (data) {
	postConsole("setBP from " + test_player_points + " add " + data);
	trace("setBP + " + data);
	postConsole(bonusPointsPopUp.oldPoints)
	bonusPointsPopUp.oldPoints = test_player_points;
	postConsole(bonusPointsPopUp.oldPoints)
	test_player_points += data;
	bonusPointsTotal += data;
	bonusPointsPopUp.gotoAndPlay("in");
};

bonusPointsPopUp.gotoAndStop("in");

// ---- layer "SFX/BGM", frame 6
for (i = 0; i < 10; i++) {
	this.createEmptyMovieClip("bgm_channel" + i,15000 + i);
}
this.createEmptyMovieClip("sfx",15011);

Array.prototype.clip = function(data) {
	for (i = 0; i < this.length; i++) {
		if (this[i] == data) {
			this.splice(i,1);
			return true;
		}
	}
	return false;
};

sfxVolume = 100;
bgmVolume = 100;
//Hidden volume multipliers
SFX_MULT = 1;
BGM_MULT = 0.75;
BGM_INFLIGHT_MULT = 0.7;
bgmArray = new Array();
sfxArray = new Array();
sfxCount = 0;
mute = 1;

playBgm = function (data, index, loop, volumeMult) {
	if (data == undefined || data == null) {
		trace("playBgm - Invalid BGM ID");
		return false;
	}
	if (loop == undefined || loop == null) {
		loop = true;
	}
	if (index == undefined || index == null) {
		index = 0;
	}
	if (volumeMult == undefined || volumeMult == null || volumeMult > 1 || volumeMult < 0) {
		volumeMult = 1;
	}
	_root["bgm" + index].stop();
	delete _root["bgm" + index];
	_root["bgm" + index] = new Sound(_root["bgm_channel" + index]);
	_root["bgm" + index].attachSound(data + ".wav");
	_root["bgm" + index].volumeMult = volumeMult;
	bgmArray.push(_root["bgm" + index]);
	//Set volume
	//AUDIO TAPER       
	bVolume = Math.max(0, -21.67 * Math.log(-1 * (bgmVolume - 101)) + 100);
	bVolume = Math.min(100, Math.max(0, bVolume * mute * volumeMult));
	_root["bgm" + index].setVolume(bVolume * BGM_MULT);
	//Loop or not?
	if (loop) {
		_root["bgm" + index].start(0,999);
	} else {
		_root["bgm" + index].start(0,0);
		_root["bgm" + index].onSoundComplete = function() {
			this.stop;
			bgmArray.clip(this);
			this = null;
		};
	}
};


//loadBgm is just like "play", but simply sets up the soundtrack
//and it needs to be started later manually
loadBgm = function (data, index, loop, volumeMult) {
	if (data == undefined) {
		trace("playBgm - Invalid BGM ID");
		return false;
	}
	if (loop == undefined || loop == null) {
		loop = true;
	}
	if (index == undefined || index == null) {
		index = 0;
	}
	if (volumeMult == undefined || volumeMult == null || volumeMult > 1 || volumeMult < 0) {
		volumeMult = 1;
	}
	_root["bgm" + index].stop();
	delete _root["bgm" + index];
	_root["bgm" + index] = new Sound(_root["bgm_channel" + index]);
	_root["bgm" + index].attachSound(data + ".wav");
	_root["bgm" + index].volumeMult = volumeMult;
	bgmArray.push(_root["bgm" + index]);
	//Force loading?
	_root["bgm" + index].setVolume(0.1);
	//Loop or not?
	if (loop) {
		_root["bgm" + index].start(0,999);
	} else {
		_root["bgm" + index].start(0,0);
		_root["bgm" + index].onSoundComplete = function() {
			this.stop;
			bgmArray.clip(this);
			this = null;
		};
	}
};


stopBgm = function () {
	for (i = 0; i <= 10; i++) {
		_root["bgm" + i].stop();
		_root["bgm" + i] = null;
	}
	bgmArray = [];
};
startBgm = function () {
	for (i = 0; i <= 10; i++) {
		_root["bgm" + i].start();
	}
};

playSfx = function (data, loop, volumeMult) {
	if (data == undefined || data == null) {
		trace("playSfx - Invalid SFX ID");
		return false;
	}
	if (loop == undefined || loop == null) {
		loop = false;
	}
	if (volumeMult == undefined || volumeMult == null || volumeMult < 0) {
		volumeMult = 1;
	}
	_root["sfx" + sfxCount] = new Sound(sfx);
	_root["sfx" + sfxCount].attachSound(data + ".wav");
	_root["sfx" + sfxCount].volumeMult = volumeMult;
	sfxArray.push(_root["sfx" + sfxCount]);
	//Set volume
	//AUDIO TAPER       
	sVolume = Math.max(0, -21.67 * Math.log(-1 * (sfxVolume - 101)) + 100);
	sVolume = Math.min(100, Math.max(0, sVolume * mute * volumeMult));
	_root["sfx" + sfxCount].setVolume(sVolume * SFX_MULT);
	_root["sfx" + sfxCount].start(0,0);
	//Loop or not?
	if (loop) {
		_root["sfx" + sfxCount].onSoundComplete = function() {
			this.start(0,0);
		};
	} else {
		_root["sfx" + sfxCount].onSoundComplete = function() {
			this.stop;
			sfxArray.clip(this);
			this = null;
		};
	}
	sfxCount++;
};

stopSfx = function () {
	for (i = 0; i < sfxArray.length; i++) {
		sfxArray[i].stop();
		sfxArray[i] = null;
	}
	sfxArray = [];
	sfxCount = 0;
};


//Flight volume change
changeVolume_midpoint1 = 75;//Fade point between bgm1 & bgm2
changeVolume_midpoint2 = 150;//Fade point between bgm2 & bgm3
changeVolume_buffer = 25;//Buffer for volume transition, on EACH SIDE of the midpoint

//data = speed
changeVolume = function (data) {
	if (data == "mute") {
		volume1 = 0;
		volume2 = 0;
		volume3 = 0;
	} else if (data <= changeVolume_midpoint1 - changeVolume_buffer) {
		volume1 = 100;
		volume2 = 0;
		volume3 = 0;
	} else if (data <= changeVolume_midpoint1 + changeVolume_buffer) {
		volume1 = Math.min(100, 100 - (100 * ((data - changeVolume_midpoint1) / changeVolume_buffer)));
		volume2 = Math.min(100, Math.max(0, 100 * ((data - (changeVolume_midpoint1 - changeVolume_buffer * 0.5)) / changeVolume_buffer)));
		volume3 = 0;
	} else if (data <= changeVolume_midpoint2 - changeVolume_buffer) {
		volume1 = 0;
		volume2 = 100;
		volume3 = 0;
	} else if (data <= changeVolume_midpoint2 + changeVolume_buffer) {
		volume1 = 0;
		volume2 = Math.min(100, 100 - (100 * ((data - changeVolume_midpoint2) / changeVolume_buffer)));
		volume3 = Math.min(100, Math.max(0, 100 * ((data - (changeVolume_midpoint2 - changeVolume_buffer * 0.5)) / changeVolume_buffer)));
	} else {
		volume1 = 0;
		volume2 = 0;
		volume3 = 100;
	}
	//trace("1:"+volume1+"   2:"+volume2+"   3:"+volume3);
	_root.bgm0.setVolume(volume1 * mute * BGM_INFLIGHT_MULT * BGM_MULT * _root.bgm0.volumeMult * (bgmVolume / 100));
	_root.bgm1.setVolume(volume2 * mute * BGM_INFLIGHT_MULT * BGM_MULT * _root.bgm1.volumeMult * (bgmVolume / 100));
	_root.bgm2.setVolume(volume3 * mute * BGM_INFLIGHT_MULT * BGM_MULT * _root.bgm2.volumeMult * (bgmVolume / 100));
};

//slideFactor causes the fading in the slide sfx
slideFactor = 1;

refreshMasterVolume = function (data) {
	if (data == undefined || data == null) {
		data = "both";
	} else if (data <> "sfx" && data <> "bgm") {
		data = "both";
		trace("refreshMasterVolume - invalid argument");
	}
	if (data == "both" || data == "sfx") {
		//AUDIO TAPER       
		sVolume = Math.max(0, -21.67 * Math.log(-1 * (sfxVolume - 101)) + 100);
		sVolume = Math.min(100, Math.max(0, sVolume * mute * slideFactor));
		sVolume *= SFX_MULT;
		for (i = 0; i < sfxArray.length; i++) {
			sfxArray[i].setVolume(sVolume * sfxArray[i].volumeMult);
		}
		sVolume = null;
	}
	if (data == "both" || data == "bgm") {
		//AUDIO TAPER       
		bVolume = Math.max(0, -21.67 * Math.log(-1 * (bgmVolume - 101)) + 100);
		bVolume = Math.min(100, Math.max(0, bVolume * mute));
		bVolume *= BGM_MULT;
		if (main_array.indexOf(runGlide) >= 0) {
			changeVolume(REF_speed);
		} else {
			for (i = 0; i < bgmArray.length; i++) {
				bgmArray[i].setVolume(bVolume * bgmArray[i].volumeMult);
			}
		}
		bVolume = null;
	}
};

// ---- layer "Transition", frame 6
fadeTo = function (data) {
	_root.refreshControlMode = null;
	_root.stopSfx();
	if (data == "back") {
		data = fadeToPreviousFrame;
	}
	fadeToPreviousFrame = _root._currentframe;
	_root.trans.removeMovieClip();
	if (_root.enableTransitions == false) {
		_root.gotoAndStop(data);
		return;
	}
	_root.attachMovie("trans","trans",_root.getNextHighestDepth());
	_root.trans.gotoAndPlay(1);
	_root.trans.target = data;
};

// ---- layer "challenge", frame 6

resetChallenges = function (type, data) {
	if (type == undefined || type == null) {
		if (GAME_MODE <> undefined) {
			type = GAME_MODE;
		} else {
			trace("resetChallenges - Invalid GAME_MODE");
		}
	}
	if (data == undefined || data == null) {
		data = false;
	}
	challengeGoals = new Array();
	challengeName = new Array();
	challengeVar = new Array();
	//NIU?
	challengeDiff = new Array();
	if (type == "story") {
		//Setting Goals and difficulty
		//Distance
		challengeGoals.push(100);
		challengeGoals.push(350);
		challengeGoals.push(1000);
		challengeGoals.push(2000);
		challengeGoals.push(4000);
		challengeName.push("Distance 1");
		challengeName.push("Distance 2");
		challengeName.push("Distance 3");
		challengeName.push("Distance 4");
		challengeName.push("Distance 5");
		challengeDiff.push(1);
		challengeDiff.push(2);
		challengeDiff.push(3);
		challengeDiff.push(4);
		challengeDiff.push(5);
		//Altitude
		challengeGoals.push(10);
		challengeGoals.push(35);
		challengeGoals.push(100);
		challengeGoals.push(200);
		challengeGoals.push(400);
		challengeName.push("Altitude 1");
		challengeName.push("Altitude 2");
		challengeName.push("Altitude 3");
		challengeName.push("Altitude 4");
		challengeName.push("Altitude 5");
		challengeDiff.push(1);
		challengeDiff.push(2);
		challengeDiff.push(3);
		challengeDiff.push(4);
		challengeDiff.push(5);
		//Speed
		challengeGoals.push(35);
		challengeGoals.push(75);
		challengeGoals.push(125);
		challengeGoals.push(250);
		challengeGoals.push(450);
		challengeName.push("Speed 1");
		challengeName.push("Speed 2");
		challengeName.push("Speed 3");
		challengeName.push("Speed 4");
		challengeName.push("Speed 5");
		challengeDiff.push(1);
		challengeDiff.push(2);
		challengeDiff.push(3);
		challengeDiff.push(4);
		challengeDiff.push(5);
		//Duration
		challengeGoals.push(10);
		challengeGoals.push(25);
		challengeGoals.push(40);
		challengeGoals.push(60);
		challengeGoals.push(90);
		challengeName.push("Duration 1");
		challengeName.push("Duration 2");
		challengeName.push("Duration 3");
		challengeName.push("Duration 4");
		challengeName.push("Duration 5");
		challengeDiff.push(1);
		challengeDiff.push(2);
		challengeDiff.push(3);
		challengeDiff.push(4);
		challengeDiff.push(5);
		//Destruction
		challengeGoals.push(1);
		challengeGoals.push(1);
		challengeGoals.push(1);
		challengeGoals.push(1);
		challengeGoals.push(1);
		challengeName.push("Destruction 1");
		challengeName.push("Destruction 2");
		challengeName.push("Destruction 3");
		challengeName.push("Destruction 4");
		challengeName.push("Destruction 5");
		challengeDiff.push(2);
		challengeDiff.push(3);
		challengeDiff.push(4);
		challengeDiff.push(5);
		challengeDiff.push(6);
		//Combos
		challengeGoals.push(2);
		challengeGoals.push(3);
		challengeGoals.push(4);
		challengeGoals.push(5);
		challengeName.push("2-Hit Combo");
		challengeName.push("3-Hit Combo");
		challengeName.push("4-Hit Combo");
		challengeName.push("5-Hit Combo");
		challengeDiff.push(3);
		challengeDiff.push(4);
		challengeDiff.push(5);
		challengeDiff.push(6);
		//Bouncing 
		challengeGoals.push(2);
		challengeGoals.push(10);
		challengeName.push("Bounce 1");
		challengeName.push("Bounce 2");
		challengeDiff.push(2);
		challengeDiff.push(4);
		//Reverse
		challengeGoals.push(-100);
		challengeGoals.push(-2500);
		challengeName.push("Reverse 1");
		challengeName.push("Reverse 2");
		challengeDiff.push(2);
		challengeDiff.push(5);
		//Dive
		challengeGoals.push(-15);
		challengeGoals.push(-50);
		challengeName.push("Dive 1");
		challengeName.push("Dive 2");
		challengeDiff.push(2);
		challengeDiff.push(5);
	} else {
		//Setting Goals and difficulty
		//Distance
		challengeGoals.push(100);
		challengeGoals.push(350);
		challengeGoals.push(1000);
		challengeGoals.push(2000);
		challengeGoals.push(4000);
		challengeName.push("Distance 1");
		challengeName.push("Distance 2");
		challengeName.push("Distance 3");
		challengeName.push("Distance 4");
		challengeName.push("Distance 5");
		challengeDiff.push(1);
		challengeDiff.push(2);
		challengeDiff.push(3);
		challengeDiff.push(4);
		challengeDiff.push(5);
		//Altitude
		challengeGoals.push(10);
		challengeGoals.push(35);
		challengeGoals.push(100);
		challengeGoals.push(200);
		challengeGoals.push(400);
		challengeName.push("Altitude 1");
		challengeName.push("Altitude 2");
		challengeName.push("Altitude 3");
		challengeName.push("Altitude 4");
		challengeName.push("Altitude 5");
		challengeDiff.push(1);
		challengeDiff.push(2);
		challengeDiff.push(3);
		challengeDiff.push(4);
		challengeDiff.push(5);
		//Speed
		challengeGoals.push(35);
		challengeGoals.push(75);
		challengeGoals.push(125);
		challengeGoals.push(250);
		challengeGoals.push(450);
		challengeName.push("Speed 1");
		challengeName.push("Speed 2");
		challengeName.push("Speed 3");
		challengeName.push("Speed 4");
		challengeName.push("Speed 5");
		challengeDiff.push(1);
		challengeDiff.push(2);
		challengeDiff.push(3);
		challengeDiff.push(4);
		challengeDiff.push(5);
		//Duration
		challengeGoals.push(10);
		challengeGoals.push(25);
		challengeGoals.push(40);
		challengeGoals.push(60);
		challengeGoals.push(90);
		challengeName.push("Duration 1");
		challengeName.push("Duration 2");
		challengeName.push("Duration 3");
		challengeName.push("Duration 4");
		challengeName.push("Duration 5");
		challengeDiff.push(1);
		challengeDiff.push(2);
		challengeDiff.push(3);
		challengeDiff.push(4);
		challengeDiff.push(5);
		//Destruction
		//NOT ALLOWED IN CLASSIC MODE
		challengeGoals.push(99999);
		challengeGoals.push(99999);
		challengeGoals.push(99999);
		challengeGoals.push(99999);
		challengeGoals.push(99999);
		challengeName.push("Destruction 1");
		challengeName.push("Destruction 2");
		challengeName.push("Destruction 3");
		challengeName.push("Destruction 4");
		challengeName.push("Destruction 5");
		challengeDiff.push(1);
		challengeDiff.push(1);
		challengeDiff.push(1);
		challengeDiff.push(1);
		challengeDiff.push(1);
		//Combos
		//NOT ALLOWED IN CLASSIC MODE
		challengeGoals.push(99999);
		challengeGoals.push(99999);
		challengeGoals.push(99999);
		challengeGoals.push(99999);
		challengeName.push("2-Hit Combo");
		challengeName.push("3-Hit Combo");
		challengeName.push("4-Hit Combo");
		challengeName.push("5-Hit Combo");
		challengeDiff.push(1);
		challengeDiff.push(1);
		challengeDiff.push(1);
		challengeDiff.push(1);
		//Bouncing 
		challengeGoals.push(2);
		challengeGoals.push(10);
		challengeName.push("Bounce 1");
		challengeName.push("Bounce 2");
		challengeDiff.push(2);
		challengeDiff.push(4);
		//Reverse
		challengeGoals.push(-100);
		challengeGoals.push(-2500);
		challengeName.push("Reverse 1");
		challengeName.push("Reverse 2");
		challengeDiff.push(2);
		challengeDiff.push(5);
		//Dive
		challengeGoals.push(-15);
		challengeGoals.push(-50);
		challengeName.push("Dive 1");
		challengeName.push("Dive 2");
		challengeDiff.push(2);
		challengeDiff.push(5);
	}
	//Data == true when keeping booleans, e.g. loading
	if (data <> true) {
		trace("Challenges reset...");
		challengeBool = new Array();
		for (i = 0; i < challengeGoals.length; i++) {
			challengeBool[i] = false;
		}
	}
};

//verifyChallenge is the function that runs every frame checking for completed achievements
verifyChallenge = function () {
	if (GAME_MODE == "arcade") {
		return;
	}
	for (i = 0; i < challengeGoals.length; i++) {
		if (i <= 4) {
			//Distance
			if (REF_distance >= challengeGoals[i] && challengeBool[i] <> true) {
				getChallenge("challenge",i);
			}
		} else if (i <= 9) {
			//Altitude
			if (REF_altitude >= challengeGoals[i] && challengeBool[i] <> true) {
				getChallenge("challenge",i);
			}
		} else if (i <= 14) {
			//Speed
			if (REF_speed >= challengeGoals[i] && challengeBool[i] <> true) {
				getChallenge("challenge",i);
			}
		} else if (i <= 19) {
			//Duration
			if (REF_duration >= challengeGoals[i] && challengeBool[i] <> true) {
				getChallenge("challenge",i);
			}
		} else if (i <= 24) {
			//Destruction
			if (obstacleDestroyed[i - 20] == challengeGoals[i] && challengeBool[i] <> true) {
				getChallenge("challenge",i);
			}
		} else if (i <= 28) {
			//Combo
			if (obstacleDestroyedToday >= challengeGoals[i] && challengeBool[i] <> true) {
				getChallenge("challenge",i);
			}
		} else if (i <= 30) {
			//Bounce
			if (seaBounces >= challengeGoals[i] && challengeBool[i] <> true) {
				getChallenge("challenge",i);
			}
		} else if (i <= 32) {
			//Reverse
			if (REF_distance <= challengeGoals[i] && challengeBool[i] <> true) {
				getChallenge("challenge",i);
			}
		} else if (i <= 34) {
			//Dive
			if (REF_altitude <= challengeGoals[i] && challengeBool[i] <> true) {
				getChallenge("challenge",i);
			}
		} else {
			//Unknown challenge
		}
	}
};


popUpCount = 0;
challengeRewards = new Array(30, 75, 350, 800, 1500, 2500);
challengeRewardsClassic = new Array(45, 90, 450, 1000, 2000, 3500);

//Holders are used to remember which challenges were completed today
//to be able to list them at the dayResults screen
challengeNameHolder = [];
challengeIndexHolder = [];
challengeRewardHolder = [];

getChallenge = function (type, index) {
	if (type == undefined || type <> "medal") {
		if (challengeBool[index]) {
			return;
		}
		type = "challenge";
	} else {
		if (medalBool[index]) {
			return;
		}
		type = "medal";
	}
	if (challenge_holder["popUp" + popUpCount]._name <> undefined) {
		challenge_holder["popUp" + popUpCount].removeMovieClip();
	}
	challenge_holder._y = popUpCount * 65;
	challenge_holder.attachMovie("challenge_get","popUp" + popUpCount,challenge_holder.getNextHighestDepth());
	challenge_holder["popUp" + popUpCount].isAMedal = true;
	challenge_holder["popUp" + popUpCount]._y = popUpCount * (-65);
	if (type == "challenge") {
		challenge_holder["popUp" + popUpCount].anim.icon.gotoAndStop(index + 1);
		challenge_holder["popUp" + popUpCount].anim.hint.gotoAndStop(index + 1);
		_root.challengeBool[index] = true;
		if (GAME_MODE == "story") {
			test_player_cash += challengeRewards[challengeDiff[index] - 1];
			challengeNameHolder.push(challengeName[index]);
			challengeIndexHolder.push(index);
			challengeRewardHolder.push(challengeRewards[challengeDiff[index] - 1]);
		} else {
			test_player_cash += challengeRewardsClassic[challengeDiff[index] - 1];
			challengeNameHolder.push(challengeName[index]);
			challengeIndexHolder.push(index);
			challengeRewardHolder.push(challengeRewardsClassic[challengeDiff[index] - 1]);
		}
	} else {
		challenge_holder["popUp" + popUpCount].anim.icon.gotoAndStop(index + 51);
		challenge_holder["popUp" + popUpCount].anim.hint.gotoAndStop(index + 51);
		medalBool[index] = true;
		setBP(medalReward[index]);
	}
	popUpCount++;
};

// ---- layer "Medals", frame 6
//HERE - TODO - NEXT - Replace everything "medal" and enter all the data
//required for the madals.
//popUp will be the same, reward will be in BP

//data==true to keep medalBool, any other to clear it
resetMedals = function (data) {
	medalGoals = new Array();
	medalName = new Array();
	medalReward = new Array();
	//Setting Goals and rewards
	//Days passed
	medalGoals.push(10);
	medalGoals.push(25);
	medalGoals.push(75);
	medalGoals.push(150);
	medalName.push("Milestone 1");
	medalName.push("Milestone 2");
	medalName.push("Milestone 3");
	medalName.push("Milestone 4");
	medalReward.push(50);
	medalReward.push(100);
	medalReward.push(150);
	medalReward.push(250);
	//Distance TOTAL
	medalGoals.push(500);
	medalGoals.push(5000);
	medalGoals.push(50000);
	medalGoals.push(150000);
	medalName.push("Traveler 1");
	medalName.push("Traveler 2");
	medalName.push("Traveler 3");
	medalName.push("Traveler 4");
	medalReward.push(50);
	medalReward.push(100);
	medalReward.push(150);
	medalReward.push(250);
	//Altitude
	medalGoals.push(250);
	medalGoals.push(1000);
	medalName.push("High Flyer 1");
	medalName.push("High Flyer 2");
	medalReward.push(50);
	medalReward.push(150);
	//Speed
	medalGoals.push(100);
	medalGoals.push(500);
	medalName.push("Speedster 1");
	medalName.push("Speedster 2");
	medalReward.push(50);
	medalReward.push(150);
	//Bouncing 100 times
	medalGoals.push(100);
	medalName.push("Master Bouncer");
	medalReward.push(200);
	//Maximum combo of 5 obstacles in a day
	medalGoals.push(5);
	medalName.push("C-C-C-Combo");
	medalReward.push(200);
	//Every Story Mode challenges completed in a game
	//number of challenges
	medalGoals.push(35);
	medalName.push("Achiever 1");
	medalReward.push(250);
	//Every Classic Mode challenges completed in a game
	//number of challenges
	medalGoals.push(26);
	medalName.push("Achiever 2");
	medalReward.push(250);
	//Duration TOTAL
	medalGoals.push(60);
	medalGoals.push(300);
	medalGoals.push(1500);
	medalGoals.push(3600);
	medalName.push("Duration 1");
	medalName.push("Duration 2");
	medalName.push("Duration 3");
	medalName.push("Duration 4");
	medalReward.push(50);
	medalReward.push(100);
	medalReward.push(150);
	medalReward.push(250);
	//Destruction, TOTAL obstacles except #2
	medalGoals.push(1);
	medalGoals.push(1);
	//One of EACH
	medalGoals.push(25);
	medalGoals.push(75);
	medalName.push("Destruction 1");
	medalName.push("Destruction 2");
	medalName.push("Destruction 3");
	medalName.push("Destruction 4");
	medalReward.push(50);
	medalReward.push(100);
	medalReward.push(150);
	medalReward.push(250);
	//Story Mode Completed
	medalGoals.push(true);
	medalName.push("Story Mode");
	medalReward.push(500);
	//Classic Mode Completed
	medalGoals.push(true);
	medalName.push("Classic Mode");
	medalReward.push(500);
	//A score in each arcade mode budget in Arcade Mode
	medalGoals.push(true);
	medalName.push("Arcade Mode");
	medalReward.push(500);
	//Total BP
	medalGoals.push(1000);
	medalGoals.push(5000);
	medalName.push("Bounty Hunter 1");
	medalName.push("Bounty Hunter 2");
	medalReward.push(100);
	medalReward.push(200);
	//Cash at one moment, not total
	medalGoals.push(25000);
	medalGoals.push(100000);
	medalName.push("Rich Bird 1");
	medalName.push("Rich Bird 2");
	medalReward.push(100);
	medalReward.push(200);
	//ICBP
	medalGoals.push(true);
	//hard-coded
	medalName.push("I.C.B.P.");
	medalReward.push(250);
	// Reserved index so subsequent medals keep their IDs.
	medalGoals.push(false);
	medalName.push("");
	medalReward.push(0);
	//Secrets
	//hard-coded
	medalGoals.push(true);
	medalGoals.push(true);
	medalGoals.push(true);
	medalGoals.push(true);
	medalGoals.push(true);
	medalGoals.push(true);
	medalGoals.push(true);
	medalGoals.push(true);
	medalGoals.push(true);
	medalName.push("Give an inch");
	medalName.push("He'll take a yard");
	medalName.push("The Brick");
	medalName.push("Revenge of The Brick");
	medalName.push("It's ROB!");
	medalName.push("Rise!");
	medalName.push("The easy way");
	medalName.push("Achievement!");
	medalName.push("Secret disabled");
	medalReward.push(100);
	medalReward.push(100);
	medalReward.push(100);
	medalReward.push(100);
	medalReward.push(100);
	medalReward.push(100);
	medalReward.push(100);
	medalReward.push(100);
	medalReward.push(100);
	//Pacifist
	medalGoals.push(10);
	medalGoals.push(25);
	medalName.push("Pacifist 1");
	medalName.push("Pacifist 2");
	medalReward.push(100);
	medalReward.push(250);
	//Crashing
	medalGoals.push(350);
	medalGoals.push(2500);
	medalName.push("Skull Crusher");
	medalName.push("Planet Crusher");
	medalReward.push(100);
	medalReward.push(250);
	//Reverse TOTAL
	medalGoals.push(250);
	medalGoals.push(15000);
	medalName.push("Reverse 1");
	medalName.push("Reverse 2");
	medalReward.push(50);
	medalReward.push(150);
	//Diving TOTAL
	medalGoals.push(100);
	medalGoals.push(1000);
	medalName.push("Dive 1");
	medalName.push("Dive 2");
	medalReward.push(50);
	medalReward.push(150);
	//Data == true when keeping booleans, e.g. loading
	if (data <> true) {
		medalBool = new Array();
		for (i = 0; i < medalGoals.length; i++) {
			medalBool[i] = false;
		}
	}
};

//verifyMedal is the function that runs every frame checking for completed medals
//Other medals (that are not obtained in flight) use the triggerMedal() function
verifyMedal = function () {
	for (i = 0; i < medalGoals.length; i++) {
		if (i >= 0 && i <= 3) {
			//Days Passed
			//in shop
		} else if (i >= 4 && i <= 7) {
			//Distance TOTAL
			//in shop
		} else if (i >= 8 && i <= 9) {
			//Altitude
			if (REF_altitude >= medalGoals[i] && medalBool[i] <> true) {
				getChallenge("medal",i);
			}
		} else if (i >= 10 && i <= 11) {
			//Speed
			if (REF_speed >= medalGoals[i] && medalBool[i] <> true) {
				getChallenge("medal",i);
			}
		} else if (i >= 12 && i <= 12) {
			//Bouncing
			if (seaBouncesTotal >= medalGoals[i] && medalBool[i] <> true) {
				getChallenge("medal",i);
			}
		} else if (i >= 13 && i <= 13) {
			//Combo
			if (obstacleDestroyedToday >= medalGoals[i] && medalBool[i] <> true) {
				getChallenge("medal",i);
			}
		} else if (i >= 14 && i <= 14) {
			//Story Challenges
			//in shop
		} else if (i >= 15 && i <= 15) {
			//Classic Challenges
			//in shop
		} else if (i >= 16 && i <= 19) {
			//Duration TOTAL
			//in shop
		} else if (i >= 20 && i <= 23) {
			//Destruction TOTAL
			if (i == 21) {
				//One of each
				if (obstacleDestroyedCount[1] >= 1 && obstacleDestroyedCount[2] >= 1 && obstacleDestroyedCount[3] >= 1 && obstacleDestroyedCount[4] >= 1 && obstacleDestroyedCount[5] >= 1) {
					getChallenge("medal",i);
				}
			} else {
				//certain amount killed
				if (obstacleDestroyedTotal >= medalGoals[i] && medalBool[i] <> true) {
					getChallenge("medal",i);
				}
			}
		} else if (i >= 24 && i <= 24) {
			//Story Mode Completed
			//trigger
		} else if (i >= 25 && i <= 25) {
			//Classic Mode Completed
			//trigger
		} else if (i >= 26 && i <= 26) {
			//1,000,000 points in Arcade Mode
			//trigger
		} else if (i >= 27 && i <= 28) {
			//BP TOTAL
			//in shop
		} else if (i >= 29 && i <= 30) {
			//Cash at one point
			//in shop
		} else if (i >= 31 && i <= 31) {
			//Visit Guide
			//trigger
		} else if (i >= 33 && i <= 41) {
			//Secrets
			//trigger
		} else if (i >= 42 && i <= 43) {
			//Pacifist
			//in shop
		} else if (i >= 44 && i <= 45) {
			//Crash
			if (crashStrength >= medalGoals[i] && medalBool[i] <> true) {
				if (i == 45) {
					//HERE - TODO - add cutscene!!!
					REF_destruction += 666;
					freezePlayer();
					stopSfx();
					stopBgm(3);
					setTimerOut(AFTER_COLLISION_TIMEOUT);
					stopMainArray = true;
					movie_holder.attachMovie("planetCrusher","moviePlanetCrusher",movie_holder.getNextHighestDepth());
					movie_holder.moviePlanetCrusher._x = Stage.width / 2 - movie_holder._x;
					movie_holder.moviePlanetCrusher._y = Stage.height / 2 - movie_holder._y;
					//_root.attachMovie("planetCrusher","moviePlanetCrusher",_root.getNextHighestDepth());
					//_root.moviePlanetCrusher._x = Stage.width/2;
					//_root.moviePlanetCrusher._y = Stage.height/2;
					crashStrength = 0;
				} else {
					getChallenge("medal",i);
					if (!(crashStrength >= medalGoals[i + 1] && medalBool[i + 1] <> true)) {
						crashStrength = 0;
					}
				}
			}
		} else if (i >= 46 && i <= 47) {
			//Reverse TOTAL
			//in shop
		} else if (i >= 48 && i <= 49) {
			//Dive TOTAL
			//in shop
		} else {
			//Unknown medal
		}
	}
};

//if data==undefined, triggerMedal checks for shop-obtained medals
//else it just gives you the specified medal (data = index)
triggerMedal = function (data) {
	if (data <> undefined) {
		if (medalBool[data] <> true) {
			getChallenge("medal",data);
		}
		return;
	}
	trace("medalBool[24] = " + medalBool[24]);
	if (medalBool[24]) {
		_root.modesUnlocked = true;
	}
	for (i = 0; i < medalGoals.length; i++) {
		if (i >= 0 && i <= 3) {
			//Days Passed
			if (daysTotal >= medalGoals[i] && medalBool[i] <> true) {
				getChallenge("medal",i);
			}
		} else if (i >= 4 && i <= 7) {
			//Distance TOTAL
			if (distanceTotal >= medalGoals[i] && medalBool[i] <> true) {
				getChallenge("medal",i);
			}
		} else if (i >= 8 && i <= 9) {
			//Altitude
			//in flight
		} else if (i >= 10 && i <= 11) {
			//Speed
			//in flight
		} else if (i >= 12 && i <= 12) {
			//Bouncing
			//in flight
		} else if (i >= 13 && i <= 13) {
			//Combo
			//in flight
		} else if (i >= 14 && i <= 14) {
			if (GAME_MODE == "story") {
				//Story Challenges
				challengeAmount = 0;
				for (j = 0; j < challengeBool.length; j++) {
					if (challengeBool[j]) {
						challengeAmount++;
					}
				}
				bestStoryChallenges = Math.max(bestStoryChallenges, challengeAmount);
				if (challengeAmount >= medalGoals[i] && medalBool[i] <> true) {
					getChallenge("medal",i);
				}
				challengeAmount = null;
			}
		} else if (i >= 15 && i <= 15) {
			if (GAME_MODE == "classic") {
				//Classic Challenges
				challengeAmount = 0;
				for (j = 0; j < challengeBool.length; j++) {
					if (challengeBool[j]) {
						challengeAmount++;
					}
				}
				bestClassicChallenges = Math.max(bestClassicChallenges, challengeAmount);
				if (challengeAmount >= medalGoals[i] && medalBool[i] <> true) {
					getChallenge("medal",i);
				}
				challengeAmount = null;
			}
		} else if (i >= 16 && i <= 19) {
			//Duration TOTAL
			if (durationTotal >= medalGoals[i] && medalBool[i] <> true) {
				getChallenge("medal",i);
			}
		} else if (i >= 20 && i <= 23) {
			//Destruction
			//in flight
		} else if (i >= 24 && i <= 24) {
			//Story Mode Completed
			//trigger
		} else if (i >= 25 && i <= 25) {
			//Classic Mode Completed
			//trigger
		} else if (i >= 26 && i <= 26) {
			//1,000,000 points in Arcade Mode
			//trigger
			if (_root.arcadeScore1 + _root.arcadeScore2 + _root.arcadeScore3 >= 12500) {
				getChallenge("medal",i);
			}
		} else if (i >= 27 && i <= 28) {
			//BP TOTAL
			if (bonusPointsTotal >= medalGoals[i] && medalBool[i] <> true) {
				getChallenge("medal",i);
			}
		} else if (i >= 29 && i <= 30) {
			//Cash at one point
			if (GAME_MODE != "arcade" && test_player_cash >= medalGoals[i] && medalBool[i] <> true) {
				getChallenge("medal",i);
			}
		} else if (i >= 31 && i <= 31) {
			//ICBP
		} else if (i >= 33 && i <= 41) {
			//Secrets
			//trigger
		} else if (i >= 42 && i <= 43) {
			//Pacifist
			if (pacifistDays >= medalGoals[i] && medalBool[i] <> true) {
				getChallenge("medal",i);
			}
		} else if (i >= 44 && i <= 45) {
			//Crash
			//in flight
		} else if (i >= 46 && i <= 47) {
			//Reverse TOTAL
			if (reverseTotal >= medalGoals[i] && medalBool[i] <> true) {
				getChallenge("medal",i);
			}
		} else if (i >= 48 && i <= 49) {
			//Dive TOTAL
			if (diveTotal >= medalGoals[i] && medalBool[i] <> true) {
				getChallenge("medal",i);
			}
		} else {
			//Unknown medal
		}
	}
};


//The same function is used to aquire CHALLENGES AND MEDALS, getChellenge() is found in the challenge layer



REPLACETHISVALUE = 0;
getMedalProgress = function (data) {
	if (data == undefined || data == null || data >= medalGoals.length) {
		trace("getMedalProgress - incorrect data value");
		data = 0;
	}
	if (data >= 0 && data <= 3) {
		//Days Passed
		return (Math.floor(Math.min(medalGoals[data], daysTotal)) + "/" + medalGoals[data]);
	} else if (data >= 4 && data <= 7) {
		//Distance TOTAL
		return (Math.floor(Math.min(medalGoals[data], distanceTotal)) + "/" + medalGoals[data]);
	} else if (data >= 8 && data <= 9) {
		//Altitude
		return (Math.floor(Math.min(medalGoals[data], bestAltitude)) + "/" + medalGoals[data]);
	} else if (data >= 10 && data <= 11) {
		//Speed
		return (Math.floor(Math.min(medalGoals[data], bestSpeed)) + "/" + medalGoals[data]);
	} else if (data >= 12 && data <= 12) {
		//Bouncing
		return (Math.floor(Math.min(medalGoals[data], seaBouncesTotal)) + "/" + medalGoals[data]);
	} else if (data >= 13 && data <= 13) {
		//Combo
		//trigger
		return ("");
	} else if (data >= 14 && data <= 14) {
		//Story Challenges
		return (Math.floor(Math.min(medalGoals[data], bestStoryChallenges)) + "/" + medalGoals[data]);
	} else if (data >= 15 && data <= 15) {
		//Classic Challenges
		return (Math.floor(Math.min(medalGoals[data], bestClassicChallenges)) + "/" + medalGoals[data]);
	} else if (data >= 16 && data <= 19) {
		//Duration TOTAL
		return (Math.floor(Math.min(medalGoals[data], durationTotal)) + "/" + medalGoals[data]);
	} else if (data >= 20 && data <= 23) {
		//Destruction TOTAL
		if (data == 21) {
			//One of each
			return ("");
		} else {
			//certain amount killed
			return (Math.floor(Math.min(medalGoals[data], obstacleDestroyedTotal)) + "/" + medalGoals[data]);
		}
	} else if (data >= 24 && data <= 24) {
		//Story Mode Completed
		//trigger
		return ("");
	} else if (data >= 25 && data <= 25) {
		//Classic Mode Completed
		//trigger
		return ("");
	} else if (data >= 26 && data <= 26) {
		//3 scores in Arcade Mode
		return (Math.floor(Math.min(12500, arcadeScore1 + arcadeScore2 + arcadeScore3)) + "/" + 12500);
	} else if (data >= 27 && data <= 28) {
		//BP TOTAL
		return (Math.floor(Math.min(medalGoals[data], bonusPointsTotal)) + "/" + medalGoals[data]);
	} else if (data >= 29 && data <= 30) {
		//Cash at one point
		return (Math.floor(Math.min(medalGoals[data], bestCash)) + "/" + medalGoals[data]);
	} else if (data >= 31 && data <= 31) {
		//ICBP
		//trigger
		return ("");
	} else if (data >= 33 && data <= 41) {
		//Secrets
		//trigger
		return ("");
	} else if (data >= 42 && data <= 43) {
		//Pacifist
		return (Math.floor(Math.min(medalGoals[data], bestPacifistDays)) + "/" + medalGoals[data]);
	} else if (data >= 44 && data <= 45) {
		//Crash
		return (Math.floor(Math.min(medalGoals[data], bestCrash)) + "/" + medalGoals[data]);
	} else if (data >= 46 && data <= 47) {
		//Reverse TOTAL
		return (Math.floor(Math.min(medalGoals[data], reverseTotal)) + "/" + medalGoals[data]);
	} else if (data >= 48 && data <= 49) {
		//Dive TOTAL
		return (Math.floor(Math.min(medalGoals[data], diveTotal)) + "/" + medalGoals[data]);
	} else {
		//Unknown medal
	}
};

// ---- layer "Save/Load", frame 6
profileState = new Object();
saveState0 = new Object();
saveState1 = new Object();
saveState2 = new Object();
saveState3 = new Object();
saveState = new Array(saveState0, saveState1, saveState2, saveState3);

months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
md = new Date();

//cleanData is used to create 4 empty save slots and a fresh new profile, clearing all data
cleanData = function () {
	profileState = new Object();
	saveState0 = new Object();
	saveState1 = new Object();
	saveState2 = new Object();
	saveState3 = new Object();
	saveState = new Array(saveState0, saveState1, saveState2, saveState3);
	//savedData.clear();
	profileState.bestDaysForClassic = 9999;
	profileState.bestDaysForStory = 9999;
	profileState.enableTutorials = true;
	profileState.enableTransitions = true;
	profileState.enableAnimations = true;
	profileState.controlMode = "classic";
	profileState.controlSet = "basic";
	profileState.modesUnlocked = false;
	//"basic" or "cutsom"
	resetKey();
	profileState.mute = 1;
	profileState.sfxVolume = 85;
	profileState.bgmVolume = 85;
	profileState.quality = _root._quality;
	profileState.bgm_flight1 = "basic1";
	profileState.bgm_flight2 = "basic2";
	profileState.bgm_flight3 = "basic3";
	profileState.bgm_shop = "basic_theme2";
	profileState.test_player_points = 0;
	profileState.bonusItemOwn = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0].join(",");
	profileState.musicOwn = [2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0].join(",");
	profileState.RAMP_ANGLE_SLIDER_Y = -1;
	profileState.RAMP_JUMP_ANGLE = -40;
	profileState.RAMP_JUMP_ANGLE_OVER = 1;
	profileState.movieUnlocked = [false, false, false, false, false].join(",");
	profileState.tutorialsDone = [false, false, false, false, false, false, false, false].join(",");
	profileState.obstacleDestroyedTotal = 0;
	profileState.seaBouncesTotal = 0;
	profileState.daysTotal = 0;
	profileState.distanceTotal = 0;
	profileState.durationTotal = 0;
	profileState.bonusPointsTotal = 0;
	profileState.reverseTotal = 0;
	profileState.diveTotal = 0;
	profileState.bestAltitude = 0;
	profileState.bestSpeed = 0;
	profileState.bestObstacleInADay = 0;
	profileState.bestStoryChallenges = 0;
	profileState.bestClassicChallenges = 0;
	profileState.bestCash = 0;
	profileState.bestPacifistDays = 0;
	profileState.bestCrash = 0;
	resetMedals();
	profileState.medalBool = medalBool.join(",");
	resetChallenges("story",false);
	profileState.arcadeScore1 = 0;
	profileState.arcadeScore2 = 0;
	profileState.arcadeScore3 = 0;
	for (i = 0; i <= 3; i++) {
		_root["saveState" + i].GAME_ID = -1;
		_root["saveState" + i].game_mode = " Empty";
		_root["saveState" + i].save_date = "Click to save on this file";
		_root["saveState" + i].day = -1;
		_root["saveState" + i].pacifistDays = 0;
		_root["saveState" + i].old_dis = 0;
		_root["saveState" + i].old_alt = 0;
		_root["saveState" + i].old_dur = 0;
		_root["saveState" + i].old_spe = 0;
		_root["saveState" + i].old_des = 0;
		_root["saveState" + i].player_cash = 0;
		_root["saveState" + i].player_length = 0;
		_root["saveState" + i].player_height = 0;
		_root["saveState" + i].player_fuel = 0;
		_root["saveState" + i].upg_sleigh = [2, 0, 0, 0, 0, 0, 0, 0, 0, 0].join(",");
		_root["saveState" + i].upg_glider = [2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0].join(",");
		_root["saveState" + i].upg_boost = [2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0].join(",");
		_root["saveState" + i].upg_payload = [2, 0, 0, 0, 0, 0, 0, 0, 0].join(",");
		_root["saveState" + i].obstacle_health_left = [0, 0, 0, 0, 0, 0].join(",");
		_root["saveState" + i].obstacleDestroyedCount = [0, 0, 0, 0, 0, 0].join(",");
		_root["saveState" + i].classicModeGoalBool = [false].join(",");
		_root["saveState" + i].challengeBool = challengeBool.join(",");
	}
	savedData.data.profileState = profileState;
	savedData.data.saveState0 = saveState0;
	savedData.data.saveState1 = saveState1;
	savedData.data.saveState2 = saveState2;
	savedData.data.saveState3 = saveState3;
	savedData.flush();
};

//if saveGame receives -1, only profile is saved
saveGame = function (data) {
	//Profile save state 
	profileState.bestDaysForClassic = bestDaysForClassic;
	profileState.bestDaysForStory = bestDaysForStory;
	profileState.enableTutorials = enableTutorials;
	profileState.enableTransitions = enableTransitions;
	profileState.enableAnimations = enableAnimations;
	profileState.controlMode = controlMode;
	profileState.controlSet = controlSet;
	profileState.modesUnlocked = modesUnlocked;
	profileState.keyLeft = KEY_LEFT;
	profileState.keyRight = KEY_RIGHT;
	profileState.keyBoost = KEY_BOOST;
	profileState.mute = mute;
	profileState.sfxVolume = sfxVolume;
	profileState.bgmVolume = bgmVolume;
	profileState.quality = _root._quality;
	profileState.bgm_flight1 = bgm_flight1;
	profileState.bgm_flight2 = bgm_flight2;
	profileState.bgm_flight3 = bgm_flight3;
	profileState.bgm_shop = bgm_shop;
	profileState.test_player_points = test_player_points;
	profileState.bonusItemOwn = bonusItemOwn.join(",");
	profileState.RAMP_ANGLE_SLIDER_Y = RAMP_ANGLE_SLIDER_Y;
	profileState.RAMP_JUMP_ANGLE = RAMP_JUMP_ANGLE;
	profileState.RAMP_JUMP_ANGLE_OVER = RAMP_JUMP_ANGLE_OVER;
	profileState.movieUnlocked = movieUnlocked.join(",");
	profileState.musicOwn = musicOwn.join(",");
	profileState.tutorialsDone = tutorialsDone.join(",");
	profileState.medalBool = medalBool.join(",");
	profileState.obstacleDestroyedTotal = obstacleDestroyedTotal;
	profileState.seaBouncesTotal = seaBouncesTotal;
	profileState.daysTotal = daysTotal;
	profileState.distanceTotal = distanceTotal;
	profileState.durationTotal = durationTotal;
	profileState.bonusPointsTotal = bonusPointsTotal;
	profileState.reverseTotal = reverseTotal;
	profileState.diveTotal = diveTotal;
	profileState.bestAltitude = bestAltitude;
	profileState.bestSpeed = bestSpeed;
	profileState.bestObstacleInADay = bestObstacleInADay;
	profileState.bestStoryChallenges = bestStoryChallenges;
	profileState.bestClassicChallenges = bestClassicChallenges;
	profileState.bestCash = bestCash;
	profileState.bestPacifistDays = bestPacifistDays;
	profileState.bestCrash = bestCrash;
	profileState.arcadeScore1 = arcadeScore1;
	profileState.arcadeScore2 = arcadeScore2;
	profileState.arcadeScore3 = arcadeScore3;
	//Game save state
	if (data >= 0 && data <> undefined) {
		_root["saveState" + data].GAME_ID = GAME_ID;
		_root["saveState" + data].game_mode = GAME_MODE;
		_root["saveState" + data].save_date = currentDate = (md.getDate() + " " + months[md.getMonth()] + " " + md.getFullYear() + "  " + md.getHours() + ":" + md.getMinutes());
		_root["saveState" + data].day = test_day;
		_root["saveState" + data].pacifistDays = pacifistDays;
		_root["saveState" + data].old_dis = test_old_dis;
		_root["saveState" + data].old_alt = test_old_alt;
		_root["saveState" + data].old_dur = test_old_dur;
		_root["saveState" + data].old_spe = test_old_spe;
		_root["saveState" + data].old_des = test_old_des;
		_root["saveState" + data].player_cash = test_player_cash;
		_root["saveState" + data].player_length = test_player_length;
		_root["saveState" + data].player_height = test_player_height;
		_root["saveState" + data].player_fuel = test_player_fuel;
		_root["saveState" + data].upg_sleigh = test_upg_sleigh.join(",");
		_root["saveState" + data].upg_glider = test_upg_glider.join(",");
		_root["saveState" + data].upg_boost = test_upg_boost.join(",");
		_root["saveState" + data].upg_payload = test_upg_payload.join(",");
		_root["saveState" + data].obstacle_health_left = obstacle_health_left.join(",");
		_root["saveState" + data].obstacleDestroyedCount = obstacleDestroyedCount.join(",");
		_root["saveState" + data].classicModeGoalBool = [classicModeGoalBool].join(",");
		_root["saveState" + data].challengeBool = challengeBool.join(",");
		trace(challengeBool.join(","));
	}
	savedData.data.profileState = profileState;
	savedData.data.saveState0 = saveState0;
	savedData.data.saveState1 = saveState1;
	savedData.data.saveState2 = saveState2;
	savedData.data.saveState3 = saveState3;
	savedData.flush();
	trace(savedData.getSize() + " bytes");
};

//when loadGame receives -1, a newgame is created
loadGame = function (data) {
	if (data <= -1) {
		//INIT
		//generate unique ID to prevent completing the same game all over again
		do {
			GAME_ID = Math.ceil(Math.random() * 99.9 + 0.01);
		} while (saveState0.GAME_ID == GAME_ID || saveState1.GAME_ID == GAME_ID || saveState2.GAME_ID == GAME_ID || saveState3.GAME_ID == GAME_ID);
		//BONUS - level substracted from test_day
		test_day = 1 - bonusItemOwn[0];
		pacifistDays = 0;
		test_old_dis = 0;
		test_old_alt = 0;
		test_old_dur = 0;
		test_old_spe = 0;
		test_old_des = 0;
		test_player_cash = 0;
		test_player_length = 0;
		test_player_height = 0;
		test_player_fuel = 0;
		test_upg_sleigh = new Array(2, 0, 0, 0, 0, 0, 0, 0, 0, 0);
		test_upg_glider = new Array(2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
		test_upg_boost = new Array(2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
		test_upg_payload = new Array(2, 0, 0, 0, 0, 0, 0, 0, 0);
		obstacle_health_left = [0, 0, 0, 0, 0, 0];
		obstacleDestroyedCount = [0, 0, 0, 0, 0, 0];
		classicModeGoalBool = false;
		resetChallenges(GAME_MODE,false);
		return;
	}
	getSharedObject();
	GAME_ID = _root["saveState" + data].GAME_ID;
	GAME_MODE = _root["saveState" + data].game_mode;
	test_day = _root["saveState" + data].day;
	pacifistDays = _root["saveState" + data].pacifistDays;
	test_old_dis = _root["saveState" + data].old_dis;
	test_old_alt = _root["saveState" + data].old_alt;
	test_old_dur = _root["saveState" + data].old_dur;
	test_old_spe = _root["saveState" + data].old_spe;
	test_old_des = _root["saveState" + data].old_des;
	test_player_cash = _root["saveState" + data].player_cash;
	test_player_length = _root["saveState" + data].player_length;
	test_player_height = _root["saveState" + data].player_height;
	test_player_fuel = _root["saveState" + data].player_fuel;
	test_upg_sleigh = _root["saveState" + data].upg_sleigh.split(",").parseValues();
	test_upg_glider = _root["saveState" + data].upg_glider.split(",").parseValues();
	test_upg_boost = _root["saveState" + data].upg_boost.split(",").parseValues();
	test_upg_payload = _root["saveState" + data].upg_payload.split(",").parseValues();
	obstacle_health_left = _root["saveState" + data].obstacle_health_left.split(",").parseValues();
	obstacleDestroyedCount = _root["saveState" + data].obstacleDestroyedCount.split(",").parseValues();
	classicModeGoalBool = [_root["saveState" + data].classicModeGoalBool].parseValues(0);
	resetChallenges(GAME_MODE);
	challengeBool = _root["saveState" + data].challengeBool.split(",").parseValues();
};

loadProfile = function () {
	bestDaysForClassic = profileState.bestDaysForClassic;
	bestDaysForStory = profileState.bestDaysForStory;
	enableTutorials = profileState.enableTutorials;
	enableTransitions = profileState.enableTransitions;
	enableAnimations = profileState.enableAnimations;
	controlMode = profileState.controlMode;
	controlSet = profileState.controlSet;
	modesUnlocked = profileState.modesUnlocked;
	KEY_LEFT = profileState.keyLeft;
	KEY_RIGHT = profileState.keyRight;
	KEY_BOOST = profileState.keyBoost;
	mute = profileState.mute;
	sfxVolume = profileState.sfxVolume;
	bgmVolume = profileState.bgmVolume;
	_root._quality = profileState.quality;
	bgm_flight1 = profileState.bgm_flight1;
	bgm_flight2 = profileState.bgm_flight2;
	bgm_flight3 = profileState.bgm_flight3;
	bgm_shop = profileState.bgm_shop;
	test_player_points = profileState.test_player_points;
	bonusItemOwn = profileState.bonusItemOwn.split(",").parseValues();
	RAMP_ANGLE_SLIDER_Y = profileState.RAMP_ANGLE_SLIDER_Y;
	RAMP_JUMP_ANGLE = profileState.RAMP_JUMP_ANGLE;
	RAMP_JUMP_ANGLE_OVER = profileState.RAMP_JUMP_ANGLE_OVER;
	movieUnlocked = profileState.movieUnlocked.split(",").parseValues();
	musicOwn = profileState.musicOwn.split(",").parseValues();
	tutorialsDone = profileState.tutorialsDone.split(",").parseValues();
	resetMedals();
	medalBool = profileState.medalBool.split(",").parseValues();
	obstacleDestroyedTotal = profileState.obstacleDestroyedTotal;
	seaBouncesTotal = profileState.seaBouncesTotal;
	daysTotal = profileState.daysTotal;
	distanceTotal = profileState.distanceTotal;
	durationTotal = profileState.durationTotal;
	bonusPointsTotal = profileState.bonusPointsTotal;
	reverseTotal = profileState.reverseTotal;
	diveTotal = profileState.diveTotal;
	bestAltitude = profileState.bestAltitude;
	bestSpeed = profileState.bestSpeed;
	bestObstacleInADay = profileState.bestObstacleInADay;
	bestStoryChallenges = profileState.bestStoryChallenges;
	bestClassicChallenges = profileState.bestClassicChallenges;
	bestCash = profileState.bestCash;
	bestPacifistDays = profileState.bestPacifistDays;
	bestCrash = profileState.bestCrash;
	arcadeScore1 = profileState.arcadeScore1;
	arcadeScore2 = profileState.arcadeScore2;
	arcadeScore3 = profileState.arcadeScore3;
	resetMedals(true);
};

completeAndSave = function () {
	getSharedObject();
	for (i = 0; i <= 3; i++) {
		if (GAME_ID == _root["saveState" + i].GAME_ID) {
			_root["saveState" + i].GAME_ID = "COMPLETED";
		}
		trace(_root["saveState" + i].GAME_ID);
	}
	GAME_ID = "COMPLETED";
	saveGame(0);
};

getSharedObject = function () {
	savedData = SharedObject.getLocal("mainprofile");
	profileState = savedData.data.profileState;
	saveState0 = savedData.data.saveState0;
	saveState1 = savedData.data.saveState1;
	saveState2 = savedData.data.saveState2;
	saveState3 = savedData.data.saveState3;
};

deleteSO = function () {
	savedData.clear();
};

//Loading profile
getSharedObject();
if (profileState.bgm_flight1 == undefined || profileState.bgm_flight1 == null) {
	cleanData();
}
loadProfile();

// ---- layer "Secrets", frame 11
SECRET_RISE_ODDS = secretRatioRise;
SECRET_ROB_ODDS = secretRatioRob64;

//Increase odds if you never got those secrets
if (!medalBool[37]) {
	postConsole("Never got ROB, odds increased");
	trace("Never got ROB, odds increased");
	trace("Never got ROB, odds increased");
	SECRET_ROB_ODDS *= Math.min(50, daysTotal * 0.7);
}
if (!medalBool[38]) {
	postConsole("Never got RISE, odds increased");
	trace("Never got RISE, odds increased");
	trace("Never got RISE, odds increased");
	SECRET_RISE_ODDS *= Math.min(50, daysTotal * 0.5);
}

trace("SECRET_RISE_ODDS = " + SECRET_RISE_ODDS);
trace("SECRET_ROB_ODDS = " + SECRET_ROB_ODDS);
postConsole("SECRET_RISE_ODDS = " + SECRET_RISE_ODDS);
postConsole("SECRET_ROB_ODDS = " + SECRET_ROB_ODDS);

//secrets here are: 
//When landing, on days bigger than (3-10?), SMALL chance of gettin "RISE FROM YOUR GRAVE!"
//which launch you REAL fast and delay camera

//if altitude if higher than (100'?), SMALL chance of getting ROB supplies

//trigger stops 2 secrets from happening in a day
secretTriggered = false;

secretSupplyBox.stop();

runSecretRise = function () {
	triggerMedal(38);
	if (secretTriggered) {
		return false;
	}
	//RISE FROM YOUR GRAVE!    
	stopMainArray = true;
	secretTriggered = true;
	secretRise._x = 0;
	secretRise._y = 0;
	secretRise.gotoAndPlay("in");
};

runSecretRob = function () {
	triggerMedal(37);
	if (secretTriggered) {
		return false;
	}
	//Rob  
	secretTriggered = true;
	secretRob._x = 0;
	secretRob._y = 345;
	secretRob.gotoAndPlay("in");
};

// ---- layer "Secrets", frame 14
secrets_menuCash.onRelease = function() {
	if (!_root.medalBool[33]) {
		_root.triggerMedal(33);
		test_player_cash += 1;
		setCash(shop_cash1,-1,test_player_cash,2);
	} else if (!_root.medalBool[34]) {
		_root.triggerMedal(34);
		test_player_cash -= 1;
		setCash(shop_cash1,1,test_player_cash,2);
	}
};

// ---- layer "Secrets", frame 16
secrets_menuCash.onRelease = function() {
	if (!_root.medalBool[33]) {
		_root.triggerMedal(33);
		test_player_cash -= 1;
		setCash(shop_cash1,-1,test_player_cash,2);
	} else if (!_root.medalBool[34]) {
		_root.triggerMedal(34);
		test_player_cash += 1;
		setCash(shop_cash1,1,test_player_cash,2);
	}
};

// ---- layer "Secrets", frame 19
//Secrets here are:
//clicking the penguin 3 times unlocks every modes

// ---- layer "functions", frame 11
stop();

_root.onEnterFrame = function() {
	runMain();
};

// ---- layer "functions", frame 14
updateMenuBox = function () {
	shop_menu.gotoAndStop(1);
	for (i = 1; i <= 7; i++) {
		if (shop_menu["hl" + i].hitTest(_xmouse, _ymouse, false)) {
			shop_menu["hl" + i]._alpha = Math.min(100, shop_menu["hl" + i]._alpha + 20);
		} else {
			shop_menu["hl" + i]._alpha = Math.max(0, shop_menu["hl" + i]._alpha - 15);
		}
	}
};

updateMenuArrow = function () {
	/////////////////;
	//shop_menu_btn//;
	/////////////////////////////////////////////////////////;
	txt_cash2.text = "";
	txt_cash3.text = "";
	for (i = 1; i <= 3; i++) {
		if (shop_menu["btn" + i].green._alpha >= 100) {
			shop_menu["btn" + i].green._alpha = 99;
			shop_menu["btn" + i].red._alpha -= 99;
			shop_menu["btn" + i].red_long._alpha -= 99;
		}
		if (shop_menu["btn" + i].hitTest(_xmouse, _ymouse, false) && _root["test_player_" + getUpgradeName(i)] < Math.min(10, Math.max(1, Math.ceil(shop_menu["btn" + i]._xmouse / ((shop_menu["btn" + i]._width) * 0.85) * 10)))) {
			shop_menu["btn" + i].green._alpha = 100;
			shop_menu["btn" + i].red._alpha = 100;
			shop_menu["btn" + i].red_long._alpha = 100;
			shop_menu["btn" + i].gotoAndStop(Math.min(10, Math.max(1, Math.ceil(shop_menu["btn" + i]._xmouse / ((shop_menu["btn" + i]._width) * 0.85) * 10))) + 2);
			//Verify which is buyable
			//If upgrade can be bought
			if (test_player_cash >= _root["test_upg_" + getUpgradeName(i) + "_cost"][shop_menu["btn" + i]._currentframe - 2]) {
				shop_menu["btn" + i].highlight.gotoAndStop(shopmenu_btn_hightlight_on);
				txt_cash3.textColor = 0x555550;
				txt_cash3.text = (test_player_cash - _root["test_upg_" + getUpgradeName(i) + "_cost"][shop_menu["btn" + i]._currentframe - 2]) + " $";
				//Arrows////////////;
				shop_menu["btn" + i].green._x = 23.6 * _root["test_player_" + getUpgradeName(i)];
				shop_menu["btn" + i].green.gotoAndStop(Math.max(2, shop_menu["btn" + i]._currentframe - _root["test_player_" + getUpgradeName(i)]));
				shop_menu["btn" + i].red.gotoAndStop(2);
				shop_menu["btn" + i].red_long.gotoAndStop(2);
			} else {
				//If upgrade cannot be bought
				txt_cash3.textColor = 0xBA5050;
				txt_cash3.text = (test_player_cash - _root["test_upg_" + getUpgradeName(i) + "_cost"][shop_menu["btn" + i]._currentframe - 2]) + " $";
				shop_menu["btn" + i].highlight.gotoAndStop(shopmenu_btn_hightlight_off);
				//Arrows////////////;
				//if no level buyable, use red, else, use red_long;
				if (test_player_cash <= _root["test_upg_" + getUpgradeName(i) + "_cost"][_root["test_player_" + getUpgradeName(i)] + 1] - 1) {
					//can't buy one
					shop_menu["btn" + i].green.gotoAndStop(2);
					shop_menu["btn" + i].red_long.gotoAndStop(2);
					shop_menu["btn" + i].red.gotoAndStop(Math.max(2, shop_menu["btn" + i]._currentframe - _root["test_player_" + getUpgradeName(i)]));
					shop_menu["btn" + i].red._x = 23.6 * _root["test_player_" + getUpgradeName(i)];
				} else {
					for (j = 0; j < 11 - _root["test_player_" + getUpgradeName(i)]; j++) {
						if (test_player_cash <= _root["test_upg_" + getUpgradeName(i) + "_cost"][j + _root["test_player_" + getUpgradeName(i)]] - 1) {
							shop_menu["btn" + i].green._x = 23.6 * _root["test_player_" + getUpgradeName(i)];
							shop_menu["btn" + i].green.gotoAndStop(Math.max(2, j + 1));
							shop_menu["btn" + i].red_long.gotoAndStop(shop_menu["btn" + i]._currentframe - j + 1 - _root["test_player_" + getUpgradeName(i)]);
							shop_menu["btn" + i].red_long._x = shop_menu["btn" + i].green._x + shop_menu["btn" + i].green._width;
							break;
						}
					}
				}
			}
			txt_cash2.text = "- " + _root["test_upg_" + getUpgradeName(i) + "_cost"][shop_menu["btn" + i]._currentframe - 2] + " $";
		} else {
			shop_menu["btn" + i].gotoAndStop(2);
		}
	}
	/////////////////////////////////////////////////////////;
};

buyUpgrade = function () {
	///////////////////
	//shop_menu_arrow//
	/////////////////////////////////////////////////////////
	for (i = 1; i <= 3; i++) {
		if (shop_menu["btn" + i].hitTest(_xmouse, _ymouse, false)) {
			//Verify if buyable            
			if (test_player_cash >= _root["test_upg_" + getUpgradeName(i) + "_cost"][shop_menu["btn" + i]._currentframe - 2]) {
				if (shop_menu["btn" + i]._currentframe <= shop_menu["btn" + i].meter._currentframe) {
					return "sold";
				}
				playSfx("cash");
				//Purchase upgrade
				test_player_cash -= _root["test_upg_" + getUpgradeName(i) + "_cost"][shop_menu["btn" + i]._currentframe - 2];
				_root["test_player_" + getUpgradeName(i)] = shop_menu["btn" + i]._currentframe - 2;
				shop_menu.btn1.meter.gotoAndStop(test_player_length + 2);
				shop_menu.btn2.meter.gotoAndStop(test_player_height + 2);
				shop_menu.btn3.meter.gotoAndStop(test_player_fuel + 2);
				setCash(shop_cash1,_root["test_upg_" + getUpgradeName(i) + "_cost"][shop_menu["btn" + i]._currentframe - 2],test_player_cash,18);
			}
		}
	}
	/////////////////////////////////////////////////////////
};

function getUpgradeName(data1) {
	if (data1 == 1) {
		return "length";
	} else if (data1 == 2) {
		return "height";
	} else if (data1 == 3) {
		return "fuel";
	} else {
		trace("getUpgradeName - invalid index");
		return 1;
	}
}
setCash = function (mc, data1, data2, count) {
	//mc = shop_cash1 normally
	//data1 = amount hte upgrade just did cost (used to determine starting # in animation)
	//data2 = target cash
	//count = # of frames
	mc.gotoAndPlay(1);
	mc.count = mc.inicount = count;
	mc.data1 = data1;
	mc.data2 = data2;
	mc.onEnterFrame = function() {
		this.count--;
		if (this.count <= 0) {
			this.txt.txt.text = this.data2 + " $";
			delete this.onEnterFrame;
		} else {
			this.txt.txt.text = (data2 + data1 - Math.ceil((this.inicount - this.count) / this.inicount * this.data1)) + " $";
		}
	};
};
hideMag = function (mc) {
	//Hides and stop magazine
	with (mc) {
		shop_mag._visible = false;
		shop_mag.gotoAndStop(1);
	}
};
showMag = function (mc, page) {
	//Reset and play magazine
	with (mc) {
		shop_mag.gotoAndPlay(1);
		shop_mag.anim.gotoAndPlay(1);
		shop_mag._visible = true;
		shop_mag.anim.left.left.gotoAndStop(page);
		shop_mag.anim.right.right.gotoAndStop(page);
	}
};

flipPage = function (data1, data2, back) {
	if (back <> true || back == undefined) {
		//Front page flip
		if (_root.pageFlipping <> 1) {
			with (_root.shop_mag.anim) {
				if (_root.bonusItemOwn[9] <= 0) {
					attachMovie("pageflip","pageflip",_root.shop_mag.anim.getNextHighestDepth());
				} else {
					attachMovie("pageflip_OMEGA","pageflip",_root.shop_mag.anim.getNextHighestDepth());
				}
				//pageflip._quality = "MEDIUM";
				pageflip._x = 0;
				pageflip._y = 0;
				pageflip._rightval = data1;
				pageflip._leftval = data2;
				pageflip.onEnterFrame = function() {
					this.right_page.gotoAndStop(this._rightval);
					this.left_page.gotoAndStop(this._leftval);
				};
				_root.pageFlipping = 1;
			}
		}
	} else {
		//Back page flip
		if (_root.pageFlipping <> 1) {
			with (_root.shop_mag.anim) {
				if (_root.bonusItemOwn[9] <= 0) {
					attachMovie("pageflip_back","pageflip",_root.shop_mag.anim.getNextHighestDepth());
				} else {
					attachMovie("pageflip_back_OMEGA","pageflip",_root.shop_mag.anim.getNextHighestDepth());
				}
				//pageflip._quality = "MEDIUM";
				pageflip._x = 0;
				pageflip._y = 0;
				pageflip._rightval = data2;
				pageflip._leftval = data1;
				pageflip.onEnterFrame = function() {
					this.right_page.gotoAndStop(this._rightval);
					this.left_page.gotoAndStop(this._leftval);
				};
				_root.pageFlipping = 1;
			}
		}
	}
};

pageFlipped = function () {
	with (_root.shop_mag.anim) {
		//pageflip._quality = "HIGH";
		_root.shop_mag.anim.left.left.gotoAndStop(pageflip._leftval);
		_root.shop_mag.anim.right.right.gotoAndStop(pageflip._rightval);
		pageflip.removeMovieClip();
		_root.pageFlipping = 0;
	}
};
showHint = function (type, lvl) {
	if (type == "glider" && lvl == 14 && _root.test_upg_glider[14] == 0) {
		return;
	}
	_root.shop_hint.gotoAndPlay(2);
	_root.shop_hint.hint.gotoAndStop(type + lvl);
	if (lvl >= 1) {
		if (_root["stat_" + type + "_cost"][lvl] <= _root.test_player_cash && _root["test_upg_" + type][lvl] <= 0) {
			//player has enough cash
			txt_cash3.textColor = 0x555550;
			txt_cash3.text = (test_player_cash - _root["stat_" + type + "_cost"][lvl]) + " $";
			txt_cash2.text = "- " + _root["stat_" + type + "_cost"][lvl] + " $";
		} else if (_root["test_upg_" + type][lvl] <= 0) {
			//player can't afford upgrade
			txt_cash3.textColor = 0xBA5050;
			txt_cash3.text = (test_player_cash - _root["stat_" + type + "_cost"][lvl]) + " $";
			txt_cash2.text = "- " + _root["stat_" + type + "_cost"][lvl] + " $";
		}
	}
};
hideHint = function () {
	if (_root.shop_hint._currentframe <= 1) {
		_root.shop_hint.gotoAndStop(1);
		return;
	}
	_root.shop_hint.gotoAndPlay(15);
};
getEquip = function (data) {
	for (i = 0; i <= _root["test_upg_" + data].length - 1; i++) {
		if (_root["test_upg_" + data][i] == 2) {
			return i;
		}
	}
	_root["test_upg_" + data][0] = 2;
	return 0;
};
setEquip = function (type, lvl) {
	if(type=="glider" && lvl==14){
		//THE BRICK secret!
		triggerMedal(35);
	}
	for (i = 0; i <= _root["test_upg_" + type].length - 1; i++) {
		if (_root["test_upg_" + type][i] == 2) {
			_root["test_upg_" + type][i] = 1;
		} else if (_root["test_upg_" + type][i] <> 1) {
			_root["test_upg_" + type][i] = 0;
		}
	}
	_root["test_upg_" + type][lvl] = 2;
};
refreshMag = function () {
	_root.shop_mag.anim.right.right.getPage();
	_root.shop_mag.anim.left.left.getPage();
};

buySpecial = function (type, lvl) {
	//if item isn't owned OR equipped
	if (_root["test_upg_" + type][lvl] <= 0) {
		//player has enough cash
		if (test_player_cash >= _root["stat_" + type + "_cost"][lvl]) {
			playSfx("cash");
			//take cash
			test_player_cash -= _root["stat_" + type + "_cost"][lvl];
			setCash(shop_cash1,_root["stat_" + type + "_cost"][lvl],test_player_cash,18);
			//equip bought item
			setEquip(type,lvl);
		}
	} else if (_root["test_upg_" + type][lvl] == 1) {
		playSfx("equip");
		setEquip(type,lvl);
	}
};

refreshSpecial = function () {
	if (getEquip("sleigh") <= 0) {
		//////////////////Sleigh
		shop_menu.sleigh.gotoAndStop(2);
	} else {
		shop_menu.sleigh.gotoAndStop(1);
		shop_menu.sleigh.icon.gotoAndStop(test_player_sleigh);
	}
	if (getEquip("glider") <= 0) {
		//////////////////Glider
		shop_menu.glider.gotoAndStop(2);
	} else {
		shop_menu.glider.gotoAndStop(1);
		shop_menu.glider.icon.gotoAndStop(test_player_glider);
	}
	if (getEquip("boost") <= 0) {
		//////////////////Boost
		shop_menu.boost.gotoAndStop(2);
	} else {
		shop_menu.boost.gotoAndStop(1);
		shop_menu.boost.icon.gotoAndStop(test_player_boost);
	}
	if (getEquip("payload") <= 0) {
		//////////////////Payload
		shop_menu.payload.gotoAndStop(2);
	} else {
		shop_menu.payload.gotoAndStop(1);
		shop_menu.payload.icon.gotoAndStop(test_player_payload);
	}
	_root.shop_menu.sleigh.txt_cost.gotoAndStop(1);
	_root.shop_menu.sleigh.txt_cost.txt_cost.text = "";
	_root.shop_menu.sleigh.txt_name.text = stat_sleigh_name[getEquip("sleigh")];
	_root.shop_menu.sleigh.icon.gotoAndStop(getEquip("sleigh"));
	_root.shop_menu.sleigh.meter1.gotoAndStop(_root.getMeter("stat_sleigh_speed", getEquip("sleigh")));
	_root.shop_menu.sleigh.meter2.gotoAndStop(_root.getMeter("stat_sleigh_jump", getEquip("sleigh")));
	_root.shop_menu.glider.txt_cost.gotoAndStop(1);
	_root.shop_menu.glider.txt_name.text = stat_glider_name[getEquip("glider")];
	_root.shop_menu.glider.txt_cost.txt_cost.text = "";
	_root.shop_menu.glider.icon.gotoAndStop(getEquip("glider"));
	_root.shop_menu.glider.meter1.gotoAndStop(_root.getMeter("stat_glider_flight", getEquip("glider")));
	_root.shop_menu.glider.meter2.gotoAndStop(_root.getMeter("stat_glider_speed", getEquip("glider")));
	_root.shop_menu.boost.txt_cost.gotoAndStop(1);
	_root.shop_menu.boost.txt_cost.txt_cost.text = "";
	_root.shop_menu.boost.txt_name.text = stat_boost_name[getEquip("boost")];
	_root.shop_menu.boost.icon.gotoAndStop(getEquip("boost"));
	_root.shop_menu.boost.meter1.gotoAndStop(_root.getMeter("stat_boost_thrust", getEquip("boost")));
	_root.shop_menu.boost.meter2.gotoAndStop(_root.stat_boost_type[getEquip("boost")] + 1);
	_root.shop_menu.payload.txt_cost.gotoAndStop(1);
	_root.shop_menu.payload.txt_name.text = stat_payload_name[getEquip("payload")];
	_root.shop_menu.payload.txt_cost.txt_cost.text = "";
	_root.shop_menu.payload.icon.gotoAndStop(getEquip("payload"));
	_root.shop_menu.payload.meter1.gotoAndStop(_root.getMeter("stat_payload_power", getEquip("payload")));
	_root.shop_menu.payload.meter2.gotoAndStop(_root.getMeter("stat_payload_weight", getEquip("payload")));
};

hideRight = function () {
	_root.shop_right.right.ready.onEnterFrame = _root.shop_right.right.save.onEnterFrame = _root.shop_right.right.challenges.onEnterFrame = _root.shop_right.right.export_save.onEnterFrame = function () {
		this.gotoAndStop(Math.max(1, this._currentframe - 3));
		if (this._currentframe <= 1) {
			this.gotoAndStop(1);
			this.onEnterFrame = null;
		}
	};
	shop_right.gotoAndPlay(16);
};

// ---- layer "functions", frame 16
updateMenuBox = function () {
	shop_menu.gotoAndStop(1);
	for (i=1; i<=7; i++) {
		if (shop_menu["hl"+i].hitTest(_xmouse, _ymouse, false)) {
			shop_menu["hl"+i]._alpha = Math.min(100, shop_menu["hl"+i]._alpha+20);
		} else {
			shop_menu["hl"+i]._alpha = Math.max(0, shop_menu["hl"+i]._alpha-15);
		}
	}
};

updateMenuArrow = function () {
	/////////////////;
	//shop_menu_btn//;
	/////////////////////////////////////////////////////////;
	txt_cash2.text = "";
	txt_cash3.text = "";
	for (i=1; i<=3; i++) {
		if (shop_menu["btn"+i].green._alpha>=100) {
			shop_menu["btn"+i].green._alpha = 99;
			shop_menu["btn"+i].red._alpha -= 99;
			shop_menu["btn"+i].red_long._alpha -= 99;
		}
		if (shop_menu["btn"+i].hitTest(_xmouse, _ymouse, false) && _root["test_player_"+getUpgradeName(i)]<Math.min(10, Math.max(1, Math.ceil(shop_menu["btn"+i]._xmouse/((shop_menu["btn"+i]._width)*0.85)*10)))) {
			shop_menu["btn"+i].green._alpha = 100;
			shop_menu["btn"+i].red._alpha = 100;
			shop_menu["btn"+i].red_long._alpha = 100;
			shop_menu["btn"+i].gotoAndStop(Math.min(10, Math.max(1, Math.ceil(shop_menu["btn"+i]._xmouse/((shop_menu["btn"+i]._width)*0.85)*10)))+2);
			//Verify which is buyable
			//If upgrade can be bought
			if (test_player_cash>=_root["test_upg_"+getUpgradeName(i)+"_cost"][shop_menu["btn"+i]._currentframe-2]) {
				shop_menu["btn"+i].highlight.gotoAndStop(shopmenu_btn_hightlight_on);
				txt_cash3.textColor = 0x555550;
				txt_cash3.text = (test_player_cash-_root["test_upg_"+getUpgradeName(i)+"_cost"][shop_menu["btn"+i]._currentframe-2])+" $";
				//Arrows////////////;
				shop_menu["btn"+i].green._x = 23.6*_root["test_player_"+getUpgradeName(i)];
				shop_menu["btn"+i].green.gotoAndStop(Math.max(2, shop_menu["btn"+i]._currentframe-_root["test_player_"+getUpgradeName(i)]));
				shop_menu["btn"+i].red.gotoAndStop(2);
				shop_menu["btn"+i].red_long.gotoAndStop(2);
			} else {
				//If upgrade cannot be bought
				txt_cash3.textColor = 0xBA5050;
				txt_cash3.text = (test_player_cash-_root["test_upg_"+getUpgradeName(i)+"_cost"][shop_menu["btn"+i]._currentframe-2])+" $";
				shop_menu["btn"+i].highlight.gotoAndStop(shopmenu_btn_hightlight_off);
				//Arrows////////////;
				//if no level buyable, use red, else, use red_long;
				if (test_player_cash<=_root["test_upg_"+getUpgradeName(i)+"_cost"][_root["test_player_"+getUpgradeName(i)]+1]-1) {
					//can't buy one
					shop_menu["btn"+i].green.gotoAndStop(2);
					shop_menu["btn"+i].red_long.gotoAndStop(2);
					shop_menu["btn"+i].red.gotoAndStop(Math.max(2, shop_menu["btn"+i]._currentframe-_root["test_player_"+getUpgradeName(i)]));
					shop_menu["btn"+i].red._x = 23.6*_root["test_player_"+getUpgradeName(i)];
				} else {
					for (j=0; j<11-_root["test_player_"+getUpgradeName(i)]; j++) {
						if (test_player_cash<=_root["test_upg_"+getUpgradeName(i)+"_cost"][j+_root["test_player_"+getUpgradeName(i)]]-1) {
							shop_menu["btn"+i].green._x = 23.6*_root["test_player_"+getUpgradeName(i)];
							shop_menu["btn"+i].green.gotoAndStop(Math.max(2, j+1));
							shop_menu["btn"+i].red_long.gotoAndStop(shop_menu["btn"+i]._currentframe-j+1-_root["test_player_"+getUpgradeName(i)]);
							shop_menu["btn"+i].red_long._x = shop_menu["btn"+i].green._x+shop_menu["btn"+i].green._width;
							break;
						}
					}
				}
			}
			txt_cash2.text = "- "+_root["test_upg_"+getUpgradeName(i)+"_cost"][shop_menu["btn"+i]._currentframe-2]+" $";
		} else {
			shop_menu["btn"+i].gotoAndStop(2);
		}
	}
	/////////////////////////////////////////////////////////;
};

buyUpgrade = function () {
	///////////////////
	//shop_menu_arrow//
	/////////////////////////////////////////////////////////
	for (i=1; i<=3; i++) {
		if (shop_menu["btn"+i].hitTest(_xmouse, _ymouse, false)) {
			//Verify if buyable            
			if (test_player_cash>=_root["test_upg_"+getUpgradeName(i)+"_cost"][shop_menu["btn"+i]._currentframe-2]) {
				if (shop_menu["btn"+i]._currentframe<=shop_menu["btn"+i].meter._currentframe) {
					return "sold";
				}
				playSfx("cash");
				//Purchase upgrade
				test_player_cash -= _root["test_upg_"+getUpgradeName(i)+"_cost"][shop_menu["btn"+i]._currentframe-2];
				_root["test_player_"+getUpgradeName(i)] = shop_menu["btn"+i]._currentframe-2;
				shop_menu.btn1.meter.gotoAndStop(test_player_length+2);
				shop_menu.btn2.meter.gotoAndStop(test_player_height+2);
				shop_menu.btn3.meter.gotoAndStop(test_player_fuel+2);
				setCash(shop_cash1,_root["test_upg_"+getUpgradeName(i)+"_cost"][shop_menu["btn"+i]._currentframe-2],test_player_cash,18);
			}
		}
	}
	/////////////////////////////////////////////////////////
};

function getUpgradeName(data1) {
	if (data1 == 1) {
		return "length";
	} else if (data1 == 2) {
		return "height";
	} else if (data1 == 3) {
		return "fuel";
	} else {
		trace("getUpgradeName - invalid index");
		return 1;
	}
}
setCash = function (mc, data1, data2, count) {
	//mc = shop_cash1 normally
	//data1 = amount hte upgrade just did cost (used to determine starting # in animation)
	//data2 = target cash
	//count = # of frames
	mc.gotoAndPlay(1);
	mc.count = mc.inicount=count;
	mc.data1 = data1;
	mc.data2 = data2;
	mc.onEnterFrame = function() {
		this.count--;
		if (this.count<=0) {
			this.txt.txt.text = this.data2+" $";
			delete this.onEnterFrame;
		} else {
			this.txt.txt.text = (data2+data1-Math.ceil((this.inicount-this.count)/this.inicount*this.data1))+" $";
		}
	};
};
hideMag = function (mc) {
	//Hides and stop magazine
	with (mc) {
		shop_mag._visible = false;
		shop_mag.gotoAndStop(1);
	}
};
showMag = function (mc, page) {
	//Reset and play magazine
	with (mc) {
		shop_mag.gotoAndPlay(1);
		shop_mag.anim.gotoAndPlay(1);
		shop_mag._visible = true;
		shop_mag.anim.left.left.gotoAndStop(page);
		shop_mag.anim.right.right.gotoAndStop(page);
	}
};

flipPage = function (data1, data2, back) {
	if (back<>true || back == undefined) {
		//Front page flip
		if (_root.pageFlipping<>1) {
			with (_root.shop_mag.anim) {
				if (_root.bonusItemOwn[9]<=0) {
					attachMovie("pageflip","pageflip",_root.shop_mag.anim.getNextHighestDepth());
				} else {
					attachMovie("pageflip_OMEGA","pageflip",_root.shop_mag.anim.getNextHighestDepth());
				}
				//pageflip._quality = "MEDIUM";
				pageflip._x = 0;
				pageflip._y = 0;
				pageflip._rightval = data1;
				pageflip._leftval = data2;
				pageflip.onEnterFrame = function() {
					this.right_page.gotoAndStop(this._rightval);
					this.left_page.gotoAndStop(this._leftval);
				};
				_root.pageFlipping = 1;
			}
		}
	} else {
		//Back page flip
		if (_root.pageFlipping<>1) {
			with (_root.shop_mag.anim) {
				if (_root.bonusItemOwn[9]<=0) {
					attachMovie("pageflip_back","pageflip",_root.shop_mag.anim.getNextHighestDepth());
				} else {
					attachMovie("pageflip_back_OMEGA","pageflip",_root.shop_mag.anim.getNextHighestDepth());
				}
				//pageflip._quality = "MEDIUM";
				pageflip._x = 0;
				pageflip._y = 0;
				pageflip._rightval = data2;
				pageflip._leftval = data1;
				pageflip.onEnterFrame = function() {
					this.right_page.gotoAndStop(this._rightval);
					this.left_page.gotoAndStop(this._leftval);
				};
				_root.pageFlipping = 1;
			}
		}
	}
};

pageFlipped = function () {
	with (_root.shop_mag.anim) {
		//pageflip._quality = "HIGH";
		_root.shop_mag.anim.left.left.gotoAndStop(pageflip._leftval);
		_root.shop_mag.anim.right.right.gotoAndStop(pageflip._rightval);
		pageflip.removeMovieClip();
		_root.pageFlipping = 0;
	}
};
showHint = function (type, lvl) {
	_root.shop_hint.gotoAndPlay(2);
	_root.shop_hint.hint.gotoAndStop(type+lvl);
	if (lvl>=1) {
		if (_root["stat_"+type+"_cost"][lvl]<=_root.test_player_cash && _root["test_upg_"+type][lvl]<=0) {
			//player has enough cash
			txt_cash3.textColor = 0x555550;
			txt_cash3.text = (test_player_cash-_root["stat_"+type+"_cost"][lvl])+" $";
			txt_cash2.text = "- "+_root["stat_"+type+"_cost"][lvl]+" $";
		} else if (_root["test_upg_"+type][lvl]<=0) {
			//player can't afford upgrade
			txt_cash3.textColor = 0xBA5050;
			txt_cash3.text = (test_player_cash-_root["stat_"+type+"_cost"][lvl])+" $";
			txt_cash2.text = "- "+_root["stat_"+type+"_cost"][lvl]+" $";
		}
	}
};
hideHint = function () {
	_root.shop_hint.gotoAndPlay(15);
};
getEquip = function (data) {
	for (i=0; i<=_root["test_upg_"+data].length-1; i++) {
		if (_root["test_upg_"+data][i] == 2) {
			return i;
		}
	}
	_root["test_upg_"+data][0] = 2;
	return 0;
};
setEquip = function (type, lvl) {
	for (i=0; i<=_root["test_upg_"+type].length-1; i++) {
		if (_root["test_upg_"+type][i] == 2) {
			_root["test_upg_"+type][i] = 1;
		} else if (_root["test_upg_"+type][i]<>1) {
			_root["test_upg_"+type][i] = 0;
		}
	}
	_root["test_upg_"+type][lvl] = 2;
};
refreshMag = function () {
	_root.shop_mag.anim.right.right.getPage();
	_root.shop_mag.anim.left.left.getPage();
};

buySpecial = function (type, lvl) {
	//if item isn't owned OR equipped
	if (_root["test_upg_"+type][lvl]<=0) {
		//player has enough cash
		if (test_player_cash>=_root["stat_"+type+"_cost"][lvl]) {
			playSfx("cash");
			//take cash
			test_player_cash -= _root["stat_"+type+"_cost"][lvl];
			setCash(shop_cash1,_root["stat_"+type+"_cost"][lvl],test_player_cash,18);
			//equip bought item
			setEquip(type,lvl);
		}
	} else if (_root["test_upg_"+type][lvl] == 1) {
		playSfx("equip");
		setEquip(type,lvl);
	}
};

refreshSpecial = function () {
	if (getEquip("sleigh")<=0) {
		//////////////////Sleigh
		shop_menu.sleigh.gotoAndStop(2);
	} else {
		shop_menu.sleigh.gotoAndStop(1);
		shop_menu.sleigh.icon.gotoAndStop(test_player_sleigh);
	}
	if (getEquip("glider")<=0) {
		//////////////////Glider
		shop_menu.glider.gotoAndStop(2);
	} else {
		shop_menu.glider.gotoAndStop(1);
		shop_menu.glider.icon.gotoAndStop(test_player_glider);
	}
	if (getEquip("boost")<=0) {
		//////////////////Boost
		shop_menu.boost.gotoAndStop(2);
	} else {
		shop_menu.boost.gotoAndStop(1);
		shop_menu.boost.icon.gotoAndStop(test_player_boost);
	}
	if (getEquip("payload")<=0) {
		//////////////////Payload
		shop_menu.payload.gotoAndStop(2);
	} else {
		shop_menu.payload.gotoAndStop(1);
		shop_menu.payload.icon.gotoAndStop(test_player_payload);
	}
	_root.shop_menu.sleigh.txt_cost.gotoAndStop(1);
	_root.shop_menu.sleigh.txt_cost.txt_cost.text = "";
	_root.shop_menu.sleigh.txt_name.text = stat_sleigh_name[getEquip("sleigh")];
	_root.shop_menu.sleigh.icon.gotoAndStop(getEquip("sleigh"));
	_root.shop_menu.sleigh.meter1.gotoAndStop(_root.getMeter("stat_sleigh_speed", getEquip("sleigh")));
	_root.shop_menu.sleigh.meter2.gotoAndStop(_root.getMeter("stat_sleigh_jump", getEquip("sleigh")));
	_root.shop_menu.glider.txt_cost.gotoAndStop(1);
	_root.shop_menu.glider.txt_name.text = stat_glider_name[getEquip("glider")];
	_root.shop_menu.glider.txt_cost.txt_cost.text = "";
	_root.shop_menu.glider.icon.gotoAndStop(getEquip("glider"));
	_root.shop_menu.glider.meter1.gotoAndStop(_root.getMeter("stat_glider_flight", getEquip("glider")));
	_root.shop_menu.glider.meter2.gotoAndStop(_root.getMeter("stat_glider_speed", getEquip("glider")));
	_root.shop_menu.boost.txt_cost.gotoAndStop(1);
	_root.shop_menu.boost.txt_cost.txt_cost.text = "";
	_root.shop_menu.boost.txt_name.text = stat_boost_name[getEquip("boost")];
	_root.shop_menu.boost.icon.gotoAndStop(getEquip("boost"));
	_root.shop_menu.boost.meter1.gotoAndStop(_root.getMeter("stat_boost_thrust", getEquip("boost")));
	_root.shop_menu.boost.meter2.gotoAndStop(_root.stat_boost_type[getEquip("boost")]+1);
	_root.shop_menu.payload.txt_cost.gotoAndStop(1);
	_root.shop_menu.payload.txt_name.text = stat_payload_name[getEquip("payload")];
	_root.shop_menu.payload.txt_cost.txt_cost.text = "";
	_root.shop_menu.payload.icon.gotoAndStop(getEquip("payload"));
	_root.shop_menu.payload.meter1.gotoAndStop(_root.getMeter("stat_payload_power", getEquip("payload")));
	_root.shop_menu.payload.meter2.gotoAndStop(_root.getMeter("stat_payload_weight", getEquip("payload")));
};

hideRight = function () {
	_root.shop_right.right.budget.onEnterFrame = _root.shop_right.right.ready.onEnterFrame=_root.shop_right.right.save.onEnterFrame=_root.shop_right.right.challenges.onEnterFrame=_root.shop_right.right.export_save.onEnterFrame=function () {
		this.gotoAndStop(Math.max(1, this._currentframe-3));
		if (this._currentframe<=1) {
			this.gotoAndStop(1);
			this.onEnterFrame = null;
		}
	};
	shop_right.gotoAndPlay(16);
};

// ---- layer "functions", frame 19
//HERE - for classic/arcade mode, crash
//Lookup "challenge_array", crash happens in a for loop in challenge layer

mainMenuNewGame = function (data) {
	switch (data) {
		case "story" :
			_root.GAME_MODE = "story";
			break;
		case "classic" :
			_root.GAME_MODE = "classic";
			break;
		case "arcade" :
			_root.GAME_MODE = "arcade";
			break;
	}
	_root.loadGame(-1);
	resetChallenges();
	//-----------------------------------------------------------
};

// ---- layer "Control", frame 11
loadBgm(bgm_flight1,0);
loadBgm(bgm_flight2,1);
loadBgm(bgm_flight3,2);

changeVolume("mute");

player.hitspot._visible = false;

// ---- layer "Control", frame 14

playBgm(bgm_shop);

//////////////////  
///////INIT///////
////////////////////////////////////////////////////
test_player_sleigh = getEquip("sleigh");
test_player_glider = getEquip("glider");
test_player_boost = getEquip("boost");
test_player_payload = getEquip("payload");
stop();

//Game type
if (_root.GAME_MODE == "classic" || _root.GAME_MODE == "arcade") {
	shop_menu.payload._visible = false;
	shop_menu.payload._alpha = 0;
	shop_menu.payload.enabled = false;
	shop_menu.payload._x = -1000;
	shop_menu.hl7._visible = false;
	shop_menu.hl7._alpha = 0;
	shop_menu.hl7.enabled = false;
	shop_menu.hl7._x = -1000;
}

sstate = 0;//Screen State, prevents or allow certain actions
hideMag(_root);
//txt_cash1.text = test_player_cash+" $";
setCash(shop_cash1,0,test_player_cash,0);
shop_cash1.gotoAndStop(1);
txt_cash2.text = "";
txt_cash3.text = "";
shop_right.gotoAndStop(1);
shop_hint.gotoAndStop(1);
shop_menu.btn1.gotoAndStop(2);
shop_menu.btn1.meter.gotoAndStop(test_player_length + 2);
shop_menu.btn1.green.gotoAndStop(2);
shop_menu.btn1.red.gotoAndStop(2);
shop_menu.btn1.red_long.gotoAndStop(2);
shop_menu.btn2.gotoAndStop(2);
shop_menu.btn2.meter.gotoAndStop(test_player_height + 2);
shop_menu.btn2.green.gotoAndStop(2);
shop_menu.btn2.red.gotoAndStop(2);
shop_menu.btn2.red_long.gotoAndStop(2);
shop_menu.btn3.gotoAndStop(2);
shop_menu.btn3.meter.gotoAndStop(test_player_fuel + 2);
shop_menu.btn3.green.gotoAndStop(2);
shop_menu.btn3.red.gotoAndStop(2);
shop_menu.btn3.red_long.gotoAndStop(2);
//////////Four item boxes////////////////
refreshSpecial();
//randomzie notes///////////////////
notes.shop_notes_left.gotoAndStop(Math.ceil(Math.random() * 25));
do {
	notes.shop_notes_right.gotoAndStop(Math.ceil(Math.random() * 25));
} while (notes.shop_notes_right._currentframe == notes.shop_notes_left._currentframe);
notes.shop_notes_left_mask.gotoAndStop(notes.shop_notes_left._currentframe);
notes.shop_notes_right_mask.gotoAndStop(notes.shop_notes_right._currentframe);
//shop_menu_notes_mask.setMask(notes_mask)
////////////////////////////////////
//shopmenu_btn_hightlight are used to check if mouse is down, then btnX highlight are "down"
shopmenu_btn_hightlight_on = 1;
shopmenu_btn_hightlight_off = 3;
for (i = 1; i <= 7; i++) {
	shop_menu["hl" + i]._alpha = 0;

}
////////////////////////////////////////////////////
/////INIT END/////
//////////////////

_root.onEnterFrame = function() {
	if (tutFreeze) {
		//disable if tutorial is running
		return;
	}
	if (sstate == 0) {
		updateMenuBox();
		if (_xmouse > 490 && _ymouse < 350 && shop_right._currentframe <= 1) {
			shop_right.gotoAndPlay(2);
		} else if ((_xmouse <= 490 || _ymouse >= 350) && shop_right._currentframe >= 10 && shop_right._currentframe <= 15) {
			shop_right.gotoAndPlay(16);
		}
		///////////////                                                                      
		//Fade arrows//
		for (i = 1; i <= 3; i++) {
			if (shop_menu["btn" + i].green._alpha >= 0 && shop_menu["btn" + i].green._alpha <= 99) {
				shop_menu["btn" + i].green._alpha -= 16;
				shop_menu["btn" + i].red._alpha = shop_menu["btn" + i].green._alpha;
				shop_menu["btn" + i].red_long._alpha = shop_menu["btn" + i].green._alpha;
			}
		}
	}
};
_root.shop_menu.onMouseMove = function() {
	if (tutFreeze) {
		//disable if tutorial is running
		return;
	}
	if (sstate == 0) {
		updateMenuArrow();
	}
};
_root.shop_menu.onMouseDown = function() {
	if (tutFreeze) {
		//disable if tutorial is running
		return;
	}
	if (sstate == 0) {
		shopmenu_btn_hightlight_on = 2;
		shopmenu_btn_hightlight_off = 4;
		updateMenuArrow();
		for (i = 4; i <= 7; i++) {
			if (_root.shop_menu["hl" + i].hitTest(_root._xmouse, _root._ymouse)) {
				sstate = 1;
				switch (i) {
					case 4 :
						showMag(_root,"sleigh1");
						break;
					case 5 :
						showMag(_root,"glider1");
						break;
					case 6 :
						showMag(_root,"boost1");
						break;
					case 7 :
						showMag(_root,"payload1");
						break;
				}
			}
		}
	}
};
_root.shop_menu.onMouseUp = function() {
	if (_root.tutFreeze) {
		//disable if tutorial is running
		return;
	}
	if (sstate == 0) {
		shopmenu_btn_hightlight_on = 1;
		shopmenu_btn_hightlight_off = 3;
		buyUpgrade();
		updateMenuArrow();
	}
};

_root.shop_menu.hl1.type = "ramplength";
_root.shop_menu.hl2.type = "rampheight";
_root.shop_menu.hl3.type = "fuel";
_root.shop_menu.hl4.type = "sleigh";
_root.shop_menu.hl5.type = "glider";
_root.shop_menu.hl6.type = "boost";
_root.shop_menu.hl7.type = "payload";
for (i = 1; i <= 7; i++) {
	_root.shop_menu["hl" + i].onRollOver = function() {
		if (sstate == 0) {
			showHint(this.type,0);
		}
	};
	_root.shop_menu["hl" + i].onRollOut = function() {
		if (sstate == 0) {
			hideHint();
		}
	};
}

_root.shop_right.right.ready.stop();
_root.shop_right.right.save.stop();
_root.shop_right.right.challenges.stop();
_root.shop_right.right.bonus_shop.stop();
_root.shop_right.right.medals.stop();

_root.shop_right.right.ready.onRollOver = _root.shop_right.right.bonus_shop.onRollOver = _root.shop_right.right.save.onRollOver = _root.shop_right.right.challenges.onRollOver = _root.shop_right.right.medals.onRollOver = function () {
	if (sstate == 0) {
		this.onEnterFrame = function() {
			this.gotoAndStop(Math.min(30, this._currentframe + 2));
			if (this._currentframe >= 30) {
				this.gotoAndStop(30);
				this.onEnterFrame = null;
			}
		};
	}
};
_root.shop_right.right.ready.onRollOut = _root.shop_right.right.bonus_shop.onRollOut = _root.shop_right.right.save.onRollOut = _root.shop_right.right.challenges.onRollOut = _root.shop_right.right.medals.onRollOut = function () {
	if (sstate == 0) {
		this.onEnterFrame = function() {
			this.gotoAndStop(Math.max(1, this._currentframe - 3));
			if (this._currentframe <= 1) {
				this.gotoAndStop(1);
				this.onEnterFrame = null;
			}
		};
	}
};
_root.shop_right.right.ready.onMouseDown = _root.shop_right.right.bonus_shop.onMouseDown = _root.shop_right.right.save.onMouseDown = _root.shop_right.right.challenges.onMouseDown = _root.shop_right.right.medals.onMouseDown = function () {
	if (_root.tutFreeze) {
		//disable if tutorial is running
		return;
	}
	if (sstate == 0) {
		if (this.hitTest(_root._xmouse, _root._ymouse, true)) {
			this.onEnterFrame = null;
			this.gotoAndStop(35);
		}
	}
};
_root.shop_right.right.ready.onMouseUp = _root.shop_right.right.bonus_shop.onMouseUp = _root.shop_right.right.save.onMouseUp = _root.shop_right.right.challenges.onMouseUp = _root.shop_right.right.medals.onMouseUp = function () {
	if (_root.tutFreeze) {
		//disable if tutorial is running
		return;
	}
	if (sstate == 0) {
		if (this._currentframe >= 31) {
			this.gotoAndStop(30);
		}
		if (!this.hitTest(_root._xmouse, _root._ymouse, true)) {
			this.onEnterFrame = function() {
				this.gotoAndStop(Math.max(1, this._currentframe - 3));
				if (this._currentframe <= 1) {
					this.gotoAndStop(1);
					this.onEnterFrame = null;
				}
			};
		}
	}
};
_root.shop_right.right.ready.onRelease = function() {
	if (sstate == 0) {
		sstate = 1;
		_root.gotoAndStop("stage");
	}
};
_root.shop_right.right.challenges.onRelease = function() {
	if (sstate == 0) {
		sstate = 1;
		challenge.gotoAndPlay("in");
		hideRight();
	}
};
_root.shop_right.right.bonus_shop.onRelease = function() {
	if (sstate == 0) {
		sstate = 1;
		_root.wentToBonusShopFrom = _root._currentframe;
		_root.fadeTo("bonus_shop");
	}
};
_root.shop_right.right.medals.onRelease = function() {
	if (sstate == 0) {
		sstate = 1;
		_root.fadeTo("medals");
	}
};
_root.shop_right.right.save.onRelease = function() {
	if (sstate == 0) {
		sstate = 1;
		refreshSaveLabels();
		save_game.gotoAndPlay("in");
		hideRight();
	}
};

skipScene = function () {
	_root.shop_right.right.ready.onRelease();
	skipScene = null;
};

// ---- layer "Control", frame 16
playBgm(bgm_shop);

//////////////////  
///////INIT///////
////////////////////////////////////////////////////
test_player_sleigh = getEquip("sleigh");
test_player_glider = getEquip("glider");
test_player_boost = getEquip("boost");
test_player_payload = getEquip("payload");
stop();

//Game type
if (_root.GAME_MODE == "classic" || _root.GAME_MODE == "arcade") {
	shop_menu.payload._visible = false;
	shop_menu.payload._alpha = 0;
	shop_menu.payload.enabled = false;
	shop_menu.payload._x = -1000;
	shop_menu.hl7._visible = false;
	shop_menu.hl7._alpha = 0;
	shop_menu.hl7.enabled = false;
	shop_menu.hl7._x = -1000;
}

sstate = 0;//Screen State, prevents or allow certain actions, defualt = 0
hideMag(_root);
//txt_cash1.text = test_player_cash+" $";
setCash(shop_cash1,0,test_player_cash,0);
shop_cash1.gotoAndStop(1);
txt_cash2.text = "";
txt_cash3.text = "";
shop_right.gotoAndStop(1);
shop_hint.gotoAndStop(1);
shop_menu.btn1.gotoAndStop(2);
shop_menu.btn1.meter.gotoAndStop(test_player_length + 2);
shop_menu.btn1.green.gotoAndStop(2);
shop_menu.btn1.red.gotoAndStop(2);
shop_menu.btn1.red_long.gotoAndStop(2);
shop_menu.btn2.gotoAndStop(2);
shop_menu.btn2.meter.gotoAndStop(test_player_height + 2);
shop_menu.btn2.green.gotoAndStop(2);
shop_menu.btn2.red.gotoAndStop(2);
shop_menu.btn2.red_long.gotoAndStop(2);
shop_menu.btn3.gotoAndStop(2);
shop_menu.btn3.meter.gotoAndStop(test_player_fuel + 2);
shop_menu.btn3.green.gotoAndStop(2);
shop_menu.btn3.red.gotoAndStop(2);
shop_menu.btn3.red_long.gotoAndStop(2);
//////////Four item boxes////////////////
refreshSpecial();
//randomzie notes///////////////////
notes.shop_notes_left.gotoAndStop(Math.ceil(Math.random() * 25));
do {
	notes.shop_notes_right.gotoAndStop(Math.ceil(Math.random() * 25));
} while (notes.shop_notes_right._currentframe == notes.shop_notes_left._currentframe);
notes.shop_notes_left_mask.gotoAndStop(notes.shop_notes_left._currentframe);
notes.shop_notes_right_mask.gotoAndStop(notes.shop_notes_right._currentframe);
//shop_menu_notes_mask.setMask(notes_mask)
////////////////////////////////////
//shopmenu_btn_hightlight are used to check if mouse is down, then btnX highlight are "down"
shopmenu_btn_hightlight_on = 1;
shopmenu_btn_hightlight_off = 3;
for (i = 1; i <= 7; i++) {
	shop_menu["hl" + i]._alpha = 0;

}
////////////////////////////////////////////////////
/////INIT END/////
//////////////////

_root.onEnterFrame = function() {
	if (tutFreeze) {
		//disable if tutorial is running
		return;
	}
	if (sstate == 0) {
		updateMenuBox();
		if (_xmouse > 518 && shop_right._currentframe <= 1) {
			shop_right.gotoAndPlay(2);
		} else if (_xmouse <= 518 && shop_right._currentframe >= 10 && shop_right._currentframe <= 15) {
			shop_right.gotoAndPlay(16);
		}
		///////////////                                                                       
		//Fade arrows//
		for (i = 1; i <= 3; i++) {
			if (shop_menu["btn" + i].green._alpha >= 0 && shop_menu["btn" + i].green._alpha <= 99) {
				shop_menu["btn" + i].green._alpha -= 16;
				shop_menu["btn" + i].red._alpha = shop_menu["btn" + i].green._alpha;
				shop_menu["btn" + i].red_long._alpha = shop_menu["btn" + i].green._alpha;
			}
		}
	}
};
_root.shop_menu.onMouseMove = function() {
	if (tutFreeze) {
		//disable if tutorial is running
		return;
	}
	if (sstate == 0) {
		updateMenuArrow();
	}
};
_root.shop_menu.onMouseDown = function() {
	if (tutFreeze) {
		//disable if tutorial is running
		return;
	}
	if (sstate == 0) {
		shopmenu_btn_hightlight_on = 2;
		shopmenu_btn_hightlight_off = 4;
		updateMenuArrow();
		for (i = 4; i <= 7; i++) {
			if (_root.shop_menu["hl" + i].hitTest(_root._xmouse, _root._ymouse)) {
				sstate = 1;
				switch (i) {
					case 4 :
						showMag(_root,"sleigh1");
						break;
					case 5 :
						showMag(_root,"glider1");
						break;
					case 6 :
						showMag(_root,"boost1");
						break;
					case 7 :
						showMag(_root,"payload1");
						break;
				}
			}
		}
	}
};
_root.shop_menu.onMouseUp = function() {
	if (_root.tutFreeze) {
		//disable if tutorial is running
		return;
	}
	if (sstate == 0) {
		shopmenu_btn_hightlight_on = 1;
		shopmenu_btn_hightlight_off = 3;
		buyUpgrade();
		updateMenuArrow();
	}
};

_root.shop_menu.hl1.type = "ramplength";
_root.shop_menu.hl2.type = "rampheight";
_root.shop_menu.hl3.type = "fuel";
_root.shop_menu.hl4.type = "sleigh";
_root.shop_menu.hl5.type = "glider";
_root.shop_menu.hl6.type = "boost";
_root.shop_menu.hl7.type = "payload";
for (i = 1; i <= 7; i++) {
	_root.shop_menu["hl" + i].onRollOver = function() {
		if (sstate == 0) {
			showHint(this.type,0);
		}
	};
	_root.shop_menu["hl" + i].onRollOut = function() {
		if (sstate == 0) {
			hideHint();
		}
	};
}

_root.shop_right.right.ready.stop();
_root.shop_right.right.bonus_shop.stop();
_root.shop_right.right.medals.stop();
_root.shop_right.right.budget.stop();

_root.shop_right.right.budget.onRollOver = _root.shop_right.right.ready.onRollOver = _root.shop_right.right.bonus_shop.onRollOver = _root.shop_right.right.medals.onRollOver = function () {
	if (sstate == 0) {
		this.onEnterFrame = function() {
			this.gotoAndStop(Math.min(30, this._currentframe + 2));
			if (this._currentframe >= 30) {
				this.gotoAndStop(30);
				this.onEnterFrame = null;
			}
		};
	}
};
_root.shop_right.right.budget.onRollOut = _root.shop_right.right.ready.onRollOut = _root.shop_right.right.bonus_shop.onRollOut = _root.shop_right.right.medals.onRollOut = function () {
	if (sstate == 0) {
		this.onEnterFrame = function() {
			this.gotoAndStop(Math.max(1, this._currentframe - 3));
			if (this._currentframe <= 1) {
				this.gotoAndStop(1);
				this.onEnterFrame = null;
			}
		};
	}
};
_root.shop_right.right.budget.onMouseDown = _root.shop_right.right.ready.onMouseDown = _root.shop_right.right.bonus_shop.onMouseDown = _root.shop_right.right.medals.onMouseDown = function () {
	if (_root.tutFreeze) {
		//disable if tutorial is running
		return;
	}
	if (sstate == 0) {
		if (this.hitTest(_root._xmouse, _root._ymouse, true)) {
			this.onEnterFrame = null;
			this.gotoAndStop(35);
		}
	}
};
_root.shop_right.right.budget.onMouseUp = _root.shop_right.right.ready.onMouseUp = _root.shop_right.right.bonus_shop.onMouseUp = _root.shop_right.right.medals.onMouseUp = function () {
	if (_root.tutFreeze) {
		//disable if tutorial is running
		return;
	}
	if (sstate == 0) {
		if (this._currentframe >= 31) {
			this.gotoAndStop(30);
		}
		if (!this.hitTest(_root._xmouse, _root._ymouse, true)) {
			this.onEnterFrame = function() {
				this.gotoAndStop(Math.max(1, this._currentframe - 3));
				if (this._currentframe <= 1) {
					this.gotoAndStop(1);
					this.onEnterFrame = null;
				}
			};
		}
	}
};
_root.shop_right.right.ready.onRelease = function() {
	if (sstate == 0) {
		sstate = 1;
		_root.gotoAndStop("game");
	}
};
_root.shop_right.right.bonus_shop.onRelease = function() {
	if (sstate == 0) {
		sstate = 1;
		_root.wentToBonusShopFrom = _root._currentframe;
		_root.fadeTo("bonus_shop");
	}
};
_root.shop_right.right.medals.onRelease = function() {
	if (sstate == 0) {
		sstate = 1;
		_root.fadeTo("medals");
	}
};
_root.shop_right.right.budget.onRelease = function() {
	if (sstate == 0) {
		sstate = 1;
		_root.fadeTo("arcade");
	}
};

skipScene = function () {
	_root.shop_right.right.ready.onRelease();
	skipScene = null;
};

// ---- layer "Control", frame 17
stop();

callKeyDown = function (data) {
	stopBgm(4);
	fadeTo("game");
	callKeyDown = null;
};

quote.btnNext.onRelease = function() {
	callKeyDown();
	this.onRelease = null;
};

quote.backBtn.onRelease = function() {
	callKeyDown = null;
	_root.gotoAndStop("shop");
};

// ---- layer "Control", frame 18
//debug
//test_player_points = 15000;
//bgm_flight1 = "basic1";
//bgm_flight2 = "basic2";
//bgm_flight3 = "basic3";
//bgm_shop = "basic_theme2";


bonusShopLock = function ():Boolean {
	bonusPointSpent = bonusPointsTotal - test_player_points;
	if (bonusPointSpent >= bonusPointSpendingCap) {
		//Bonus Points spent limit reached
		_root.bonusShopBlocked.gotoAndStop("limited");
		return false;
	}
	return true;
};


//init
//bonusItemOwn = new Array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);//Which item is owned (level)
bonusItemCost = new Array(100, 250, 500, 0, 100, 250, 500, 0, 100, 250, 500, 0, 100, 250, 500, 0, 100, 250, 500, 0, 100, 250, 500, 0, 100, 250, 500, 0, 100, 250, 500, 0, 250, 0, 0, 0, 1000, 0, 0, 0, 50, 0, 0, 0, 100, 150, 250, 0);
//musicOwn = new Array(2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);//Which item is owned (0=not,1=owned,2=equipped)
musicCost = new Array(150, 0, 0, 0, 150, 0, 0, 0, 150, 0, 0, 0, 150, 0, 0, 0, 150, 0, 0, 0, 150, 0, 0, 0, 150, 0, 0, 0, 150, 0, 0, 0);
musicFlight = new Array("basic", "rock", "surf", "funk", "techno", "hiphop", "smooth", "old");
musicShop = new Array("basic", "basic", "basic", "basic", "basic", "basic", "basic", "basic");
bonus.points.gotoAndStop(1);
bonus.points.points.text = test_player_points;
bonus.points.cost.text = 0;
bonus.hint.gotoAndStop(Math.ceil(3.99 * Math.random() + 0.01));
playBgm("bonus_shop",0);


//Items
for (i = 1; i <= 12; i++) {
	if (i <= 8 || i == 12) {
		if (_root.bonusItemOwn[i - 1] + 1 >= 4) {
			bonus["bSold" + i].gotoAndStop("sold");
		} else {
			bonus["bSold" + i].gotoAndStop("idle");
		}
	}
	bonus["item" + i].index = i;
	bonus["item" + i].lvl = _root.bonusItemOwn[i - 1] + 1;
	bonus["item" + i].gotoAndStop(bonus["item" + i].lvl);
	bonus["item" + i].onRollOver = function() {
		_root.bonus.hint.gotoAndStop(this.index * 4 + this.lvl);
		this.gotoAndStop(this.lvl + 4);
		bonus.points.cost.text = _root.bonusItemCost[this.index * 4 + this.lvl - 5];
	};
	bonus["item" + i].onRollOut = function() {
		this.gotoAndStop(this.lvl);
		bonus.points.cost.text = 0;
	};
	bonus["item" + i].onPress = function() {
		this.gotoAndStop(this.lvl + 8);
		bonus.points.cost.text = _root.bonusItemCost[this.index * 4 + this.lvl - 5];
	};
	bonus["item" + i].onDragOut = function() {
		this.gotoAndStop(this.lvl);
	};
	bonus["item" + i].onDragOver = function() {
		this.gotoAndStop(this.lvl + 8);
	};
	bonus["item" + i].onRelease = function() {
		if (bonusShopLock()) {
			if (_root.bonusItemCost[this.index * 4 + this.lvl - 5] > 0 && test_player_points >= _root.bonusItemCost[this.index * 4 + this.lvl - 5]) {
				test_player_points -= _root.bonusItemCost[this.index * 4 + this.lvl - 5];
				this.lvl++;
				_root.bonusItemOwn[this.index - 1] = this.lvl - 1;
				this.gotoAndStop(this.lvl);
				bonus.points.points.text = test_player_points;
				if (_root.bonusItemOwn[this.index - 1] + 1 >= 4) {
					bonus["bSold" + this.index].gotoAndStop("sold");
				} else {
					bonus["bSold" + this.index].gotoAndStop("idle");
				}
			}
		}
		this.onRollOver();
	};
	bonus["item" + i].onReleaseOutside = function() {
		this.gotoAndStop(this.lvl);
		bonus.points.cost.text = 0;
	};
}

//Different actions for RAMP ANGLE and the VHS
bonus.item9.onRelease = function() {
	//Ramp Angle
	if (_root.bonusItemOwn[this.index - 1] <= 0) {
		//item not bought
		if (test_player_points >= _root.bonusItemCost[this.index * 4 + this.lvl - 5]) {
			test_player_points -= _root.bonusItemCost[this.index * 4 + this.lvl - 5];
			this.lvl++;
			_root.bonusItemOwn[this.index - 1] = this.lvl - 1;
			this.gotoAndStop(this.lvl);
			bonus.points.points.text = test_player_points;
			this._parent.gotoAndPlay("in");
		}
	} else {
		//trigger popup only
		this._parent.gotoAndPlay("in");
	}
	this.onRollOver();
};
bonus.item11.onRelease = function() {
	//VHS
	if (_root.bonusItemOwn[this.index - 1] <= 0) {
		//item not bought
		if (test_player_points >= _root.bonusItemCost[this.index * 4 + this.lvl - 5]) {
			test_player_points -= _root.bonusItemCost[this.index * 4 + this.lvl - 5];
			this.lvl++;
			_root.bonusItemOwn[this.index - 1] = this.lvl - 1;
			this.gotoAndStop(this.lvl);
			bonus.points.points.text = test_player_points;
			_root.fadeTo("vhs");
			this.onRelease = null;
		}
	} else {
		//trigger popup only
		_root.fadeTo("vhs");
		this.onRelease = null;
	}
	this.onRollOver();
};


//Music
for (i = 1; i <= 8; i++) {
	bonus["music" + i].index = i;
	bonus["music" + i].lvl = _root.musicOwn[i - 1] + 1;
	bonus["music" + i].gotoAndStop(bonus["music" + i].lvl);
	bonus["music" + i].onRollOver = function() {
		_root.bonus.hint.gotoAndStop("music");
		_root.bonus.hint.listening.text = _root.musicFlight[this.index - 1];
		_root.bonus.hint.select.text = bgm_flight1.substr(0, bgm_flight1.indexOf("_"));
		this.gotoAndStop(this.lvl + 4);
		bonus.points.cost.text = _root.musicCost[this.index * 4 + this.lvl - 5];
		musicPreview(_root.musicFlight[this.index - 1] + "1");
	};
	bonus["music" + i].onRollOut = function() {
		this.gotoAndStop(this.lvl);
		bonus.points.cost.text = 0;
		musicPreview("out");
	};
	bonus["music" + i].onPress = function() {
		this.gotoAndStop(this.lvl + 8);
		bonus.points.cost.text = _root.musicCost[this.index * 4 + this.lvl - 5];
	};
	bonus["music" + i].onDragOut = function() {
		this.gotoAndStop(this.lvl);
	};
	bonus["music" + i].onDragOver = function() {
		this.gotoAndStop(this.lvl + 8);
	};
	bonus["music" + i].onRelease = function() {
		//Music not purchased
		if (this.lvl == 1) {
			if (test_player_points >= _root.musicCost[this.index * 4 + this.lvl - 5]) {
				test_player_points -= _root.musicCost[this.index * 4 + this.lvl - 5];
				for (i = 1; i <= 8; i++) {
					if (_root.bonus["music" + i].lvl >= 3) {
						_root.bonus["music" + i].lvl = 2;
						_root.musicOwn[i - 1] = 1;
					}
				}
				this.lvl = 3;
				_root.musicOwn[this.index - 1] = this.lvl - 1;
				//Set music
				_root.bgm_flight1 = _root.musicFlight[this.index - 1] + "1";
				_root.bgm_flight2 = _root.musicFlight[this.index - 1] + "2";
				_root.bgm_flight3 = _root.musicFlight[this.index - 1] + "3";
				_root.bgm_shop = _root.musicShop[this.index - 1] + "_theme2";
				//
				this.gotoAndStop(this.lvl);
				bonus.points.points.text = test_player_points;
			}
		} else {
			//Music purchased, simply equip
			for (i = 1; i <= 8; i++) {
				if (_root.bonus["music" + i].lvl >= 3) {
					_root.bonus["music" + i].lvl = 2;
					_root.musicOwn[i - 1] = 1;
				}
			}
			this.lvl = 3;
			_root.musicOwn[this.index - 1] = this.lvl - 1;
			//Set music
			_root.bgm_flight1 = _root.musicFlight[this.index - 1] + "1";
			_root.bgm_flight2 = _root.musicFlight[this.index - 1] + "2";
			_root.bgm_flight3 = _root.musicFlight[this.index - 1] + "3";
			_root.bgm_shop = _root.musicShop[this.index - 1] + "_theme2";
			//
		}
		this.onRollOver();
	};
	bonus["music" + i].onReleaseOutside = function() {
		this.gotoAndStop(this.lvl);
		bonus.points.cost.text = 0;
		musicPreview("out");
	};
}

bonus.back.onRelease = function() {
	this.onRelease = null;
	_root.fadeTo(_root.wentToBonusShopFrom);
};

bonusVolume1 = bgmVolume;
bonusVolume2 = 0;
//call musicPreview when passing from bgm to preview/vice-versa
//data = preview title OR "out" to go back to bgm
musicPreview = function (data) {
	if (data <> "out") {
		_root.playBgm(data,1);
		this.onEnterFrame = function() {
			bonusVolume1 = Math.max(0, bonusVolume1 - 4);
			bonusVolume2 = Math.min(bgmVolume, bonusVolume2 + 4);
			_root.bgm0.setVolume(bonusVolume1 * _root.mute * _root.BGM_MULT * (_root.bgmVolume / bgmVolume));
			_root.bgm1.setVolume(bonusVolume2 * _root.mute * _root.BGM_MULT * (_root.bgmVolume / bgmVolume));
			if (bonusVolume2 >= bgmVolume) {
				this.onEnterFrame = null;
				bonusVolume1 = 0;
				bonusVolume2 = bgmVolume;
				_root.bgm0.setVolume(bonusVolume1 * _root.mute * _root.BGM_MULT*(_root.bgmVolume / bgmVolume));
				_root.bgm1.setVolume(bonusVolume2 * _root.mute * _root.BGM_MULT*(_root.bgmVolume / bgmVolume));
			}
		};
	} else {
		this.onEnterFrame = function() {
			bonusVolume1 = Math.min(bgmVolume, bonusVolume1 + 8);
			bonusVolume2 = Math.max(0, bonusVolume2 - 8);
			_root.bgm0.setVolume(bonusVolume1 * _root.mute * _root.BGM_MULT*(_root.bgmVolume / bgmVolume));
			_root.bgm1.setVolume(bonusVolume2 * _root.mute * _root.BGM_MULT*(_root.bgmVolume / bgmVolume));
			if (bonusVolume2 <= 0) {
				this.onEnterFrame = null;
				bonusVolume1 = bgmVolume;
				bonusVolume2 = 0;
				_root.bgm0.setVolume(bonusVolume1 * _root.mute * _root.BGM_MULT*(_root.bgmVolume / bgmVolume));
				_root.bgm1.setVolume(bonusVolume2 * _root.mute * _root.BGM_MULT*(_root.bgmVolume / bgmVolume));
			}
		};
	}
};

// ---- layer "Control", frame 21
for (i=0; i<=4; i++) {
	vhs["btn"+(i+1)]._visible = movieUnlocked[i];
	vhs["btn"+(i+1)].onRelease = function() {
		_root.fadeTo(this.movie);
		this.onRelease = null;
		//this bool changes the target when fading out of the movies to bring the player back to the VHS screen
		cutsceneBypass = true;
	};
}

vhs.btn5.movie = "movieClassicOutro";
vhs.btn4.movie = "moviePacifist";
vhs.btn3.movie = "movieStoryOutro";
vhs.btn2.movie = "movieStoryIntro";
vhs.btn1.movie = "movieIntro";

vhs.backBtn.onRelease = function() {
	_root.fadeTo("bonus_shop");
};

// ---- layer "Stats", frame 6
///GAME CONSTANTS-----------------------------------------
FOOT_RATIO = 60;//FOOT is the number of pixels needed to cover one in-game foot

//String for Glider Name
stat_glider_name = new Array("None", "Kite", "Old Glider", "Hang Glider", "H.I.G.H. Tech", "UltraLight Trike", "UltraLight Aircraft", "Pingu Balloon", "Umbrella", "Parachute", "Zeppelin", "Old Fan", "Propeller", "Whirlybird 512", "The Brick", "Omeglider", "The Chopper");
//flight is only used for the meters in the mag
stat_glider_flight = new Array(0, 1, 2, 3, 4, 4, 5, 4, 5, 6, 7, 10, 15, 20, 0, 15, 24);//Number for Flight capability (Lift)
stat_glider_speed = new Array(50, 25, 60, 100, 250, 175, 300, 15, 25, 45, 100, 50, 100, 200, 50, 400, 300);//RED-ZONE //Number for Speed above which resistance increases
stat_gliding_speed = new Array(999, 10, 12, 25, 50, 40, 40, 12, 20, 25, 40, 999, 999, 999, 999, 50, 999);
stat_falling_speed = new Array(998, 2, 3, 4, 5, 10, 20, 3, 7, 10, 15, 998, 998, 998, 998, 10, 998);
stat_glider_control = new Array(0, 0.1, 0.15, 0.3, 0.5, 0.5, 0.75, 0.05, 0.06, 0.08, 0.1, 0, 0, 0, 0, 0.75, 0);//Number at which inertia gets modified, in %?
stat_glider_catch = new Array(0.01, 0.7, 0.73, 0.76, 0.79, 0.8, 0.8, 0.1, 0.5, 0.5, 0.7, 0.01, 0.01, 0.01, 0.01, 0.8, 0.01);//Number at which inertia gets modified, in %?
stat_glider_upcatch = new Array(0.02, 0.6, 0.63, 0.66, 0.69, 0.7, 0.7, 0.2, 0.45, 0.55, 0.65, 0.1, 0.1, 0.1, 0.02, 0.7, 0.1);//Number at which inertia gets modified, in %?
stat_glider_lift_max = new Array(0, 0.3, 0.33, 0.36, 0.395, 0.36, 0.39, 0.37, 0.38, 0.39, 0.395, 0, 0, 0, 0, 0.395, 0);//Maximum lift
stat_glider_lift_min = new Array(0, 0, 0, 0, 0, 0, 0, 0.15, 0.18, 0.23, 0.28, 0, 0, 0, 0, 0, 0);//Minimum lift
stat_glider_prop_lift = new Array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.42, 0.55, 0.77, 0, 0, 0.99);
stat_glider_prop_resist_x = new Array(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0.995, 0.998, 0.9991, 1, 1, 0.9997);
stat_glider_prop_resist_y = new Array(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0.991, 0.992, 0.991, 1, 1, 0.994);
stat_glider_prop_fuel = new Array(-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 275, 550, 1150, -1, -1, 1600);
stat_glider_prop_decay = new Array(-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 25, 35, 50, -1, -1, 60);
stat_glider_spin = new Array(0.7, 1.2, 1, 1.1, 1.2, 0.6, 0.7, 0.2, 0.3, 0.3, 0.8, 1.2, 1.5, 2, 1, 1.3, 1.1);//Number for rotation speed, in %?
stat_glider_spin_red = new Array(25, 25, 40, 65, 120, 140, 200, 15, 25, 45, 100, 50, 100, 200, 25, 250, 225);//Speed after which spin begin to decrease
stat_glider_gravity = new Array(0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.42, 0.4, 0.6);//Amount of gravity
stat_glider_float = new Array(0.15, 0.15, 0.15, 0.125, 0.1, 0, 0, 0.4, 0.2, 0.15, 0.6, 0.15, 0.15, 0.15, 0.15, 0.15, 0.15);//Power of "floating" underwater
stat_glider_pile_offset = new Array(0, 0, 0, 0, 0, 40, 50, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);//offset for snow_piling
stat_glider_hud = new Array(1, 1, 2, 3, 7, 12, 7, 1, 1, 8, 3, 5, 4, 6, 1, 11, 10);//Hud index to display
stat_glider_cost = new Array(0, 15, 200, 800, 5000, 1500, 7500, 25, 125, 500, 3500, 350, 2250, 5500, 0, 35000, 40000);//Cost to purchase


stat_sleigh_name = new Array("None", "The Plank", "The Plank Mark II", "Good Ol' Sled", "Bobsleigh", "Spring Box", "El Bouncy", "(ka)Boom Box", "SuperSlide", "Omega Coil");
stat_sleigh_speed = new Array(0.29, 0.52, 0.64, 0.78, 1, 0.4, 0.47, 0.54, 1.1, 0.6);//Speed-Acceleration
stat_sleigh_friction = new Array(0.9905, 0.995, 0.997, 0.999, 1.01, 0.985, 0.986, 0.987, 1.02, 0.989);
stat_takeoff_mult = new Array(0, 0.000007, 0.00001, 0.000013, 0.00002, 0, 0, 0, 0.00005, 0.00002);
stat_sleigh_jump = new Array(0, 0, 0, 0, 0, 15, 40, 100, 0, 350);//"Jump" power, with slide-meter, activated power boost
stat_sleigh_takeoff = new Array(2, 2, 2, 1.8, 1.3, 2, 2, 2, 1.3, 2);//Take-off of the sleigh itself when parting
stat_sleigh_spin = new Array(2, 3, 2, 2, 0.5, 4, 3, 2, 2, 2);//Spinning when sleigh leaves ramp
stat_sleigh_gravity = new Array(0.6, 0.5, 0.5, 0.6, 0.7, 0.6, 0.6, 0.6, 0.6, 0.6);//Gravity applied to the sleigh MC when flying off
stat_sleigh_resistance = new Array(0.92, 0.92, 0.93, 0.94, 0.98, 0.9, 0.9, 0.92, 0.95, 0.93);//Resistance applied to the sleigh MC
stat_sleigh_cost = new Array(0, 25, 125, 750, 2500, 100, 500, 2500, 10000, 15000);//Cost to purchase

stat_boost_name = new Array("None", "Propulsor", "Sugar Rocket", "Pulse Jet", "THOR Ramjet", "Air Balloon", "Canned Air", "Rocket Firework", "Cruise Missile", "\"Whistle\" Rocket", "Auxiliary Boosters", "\"Lift-Off\"", "Omega Drive", "Balloon Mk.II", "Solid Booster");
//Type only used in mag
stat_boost_type = new Array(0, 0, 0, 0, 0, 1, 1, 1, 1, 4, 4, 4, 0, 1, 4);//0=Controlled, X>0 = Number of uses
stat_boost_thrust = new Array(0, 0.8, 1.5, 2.4, 4, 0.5, 1.2, 2.8, 5.5, 1, 2, 3.6, 6, 8, 7);//Thrust power
stat_boost_economy = new Array(0, 1, 1, 1, 1, 1.5, 1, 1.2, 1, 3, 4, 3.6, 1, 1.2, 3.6);//Fuel consumption rate  (1=100%) # per frame
stat_boost_cost = new Array(0, 100, 250, 1000, 10000, 35, 150, 800, 9500, 175, 1250, 7500, 25000, 25000, 25000);//Cost to purchase
stat_boost_fuel = new Array(0, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100);//Fuel levels

stat_payload_name = new Array("Snow", "Sand", "Iron Pellets", "Cast Iron", "Osmium", "Dyna-MIGHT", "C4", "Nuclear Warhead", "Dark Matter");
stat_payload_power = new Array(0.5, 1, 2.5, 6, 13, 0.6, 1.5, 4, 15);//Ramming power
stat_payload_boom = new Array(0, 0, 0, 0, 0, 250, 1750, 4500, 0);//Explosive power
stat_payload_boom_out = new Array(0, 0, 0, 0, 0, 55, 70, 90, 0);//Explosive power
stat_payload_weight = new Array(0, 1, 2, 5, 10, 1, 3, 5, 8);//Weight
stat_payload_resist = new Array(0.82, 0.88, 0.94, 0.97, 1, 0.85, 0.89, 0.93, 0.98);//Resist under water?
stat_payload_type = new Array(0, 0, 0, 0, 0, 1, 1, 1, 0);//Weight or Explosives
stat_payload_cost = new Array(0, 25, 175, 1000, 10000, 200, 1500, 10000, 25000);//Cost to purchase


//IMPORTANT NOTICE// all switch stats are reset in the NEW GAME (save/load) function
test_upg_sleigh = new Array(2, 0, 0, 0, 0, 0, 0, 0);//0=false,1=owned,2=equipped
test_upg_glider = new Array(2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);//0=false,1=owned,2=equipped
test_upg_boost = new Array(2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);//0=false,1=owned,2=equipped
test_upg_payload = new Array(2, 0, 0, 0, 0, 0, 0, 0);//0=false,1=owned,2=equipped

test_upg_length_cost = new Array(0, 10, 40, 150, 250, 500, 800, 1300, 2500, 5000, 8500, 12500, 17000, 20500, 25000, 30000, 35000, 40000, 45000, 50000, 55000, 100000);
test_upg_height_cost = new Array(0, 20, 50, 200, 350, 650, 1000, 2000, 3500, 6000, 10000, 15000, 20000, 25000, 30000, 35000, 40000, 45000, 50000, 55000, 60000, 100000);
test_upg_fuel_cost = new Array(0, 50, 100, 250, 500, 850, 1250, 2000, 3500, 6000, 10000, 15000, 20000, 25000, 30000, 35000, 40000, 45000, 50000, 55000, 60000, 100000);

test_upg_length = new Array(-85, -185, -330, -550, -915, -1500, -2500, -3500, -4500, -5500, -7500, -10000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
test_upg_height = new Array(350, 450, 550, 750, 1000, 1500, 2000, 2500, 3000, 4000, 5000, 7500, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
test_upg_fuel = new Array(23, 30, 40, 55, 70, 90, 115, 145, 180, 240, 350, 500, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

//Bonus shop stats
bonus_upgrade_cost = new Array(100, 200, 300, 400, 500, 600);
bonus_music_cost = new Array(10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120);
bonus_upgrade = new Array("idle", "idle", "idle", "idle", "idle", "idle");//idle, sold, equipped or disabled
bonus_music = new Array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

getMeter = function (data, lvl) {
	return Math.max(1, Math.ceil(_root[data][lvl]/getMax(_root[data])*400));
};

getMax = function (array:Array) {
	temp_var = 0;
	for (j=0; j<=array.length-1; j++) {
		if (array[j]>=temp_var) {
			temp_var = array[j];
		}
	}
	return temp_var;
};

// ---- layer "Key Mapping", frame 6
//resetKey
//All variables here are custom controls. When verifying for input
//we check if input == KEY_NAME
//Strings are only used on "Customize Controls" page to show to the player
resetKey = function () {
	KEY_LEFT = 37;
	KEY_LEFT_STRING = "Left";
	KEY_LEFT2 = 65;
	KEY_UP = 38;
	KEY_UP_STRING = "Up";
	KEY_UP2 = 87;
	KEY_RIGHT = 39;
	KEY_RIGHT_STRING = "Right";
	KEY_RIGHT2 = 68;
	KEY_DOWN = 40;
	KEY_DOWN_STRING = "Down";
	KEY_DOWN2 = 83;
	KEY_BOOST = 32;
	KEY_BOOST_STRING = "Spacebar";
};
//refreshCustomKey
//This function makes sure no "double controls" are used, as they are not yet possible
//with custom controls. So each KEY_NAME2 is equal to KEY_NAME
//Strings are also updated by looking up the keycode array
refreshCustomKey = function () {
	KEY_LEFT_STRING = keycode_array[KEY_LEFT];
	KEY_LEFT2 = KEY_LEFT;
	KEY_UP_STRING = keycode_array[KEY_UP];
	KEY_UP2 = KEY_UP;
	KEY_RIGHT_STRING = keycode_array[KEY_RIGHT];
	KEY_RIGHT2 = KEY_RIGHT;
	KEY_DOWN_STRING = keycode_array[KEY_DOWN];
	KEY_DOWN2 = KEY_DOWN;
	KEY_BOOST_STRING = keycode_array[KEY_BOOST];
};

//The keycode array simply stores the name of each keycode, and is used for reference
keycode_array = new Array();
for (i=0; i<=500; i++) {
	keycode_array[i] = "unknown";
}
keycode_array[8] = "Backspace";
keycode_array[9] = "Tab";
keycode_array[13] = "Enter";
keycode_array[16] = "Shift";
keycode_array[17] = "Left Ctrl";
keycode_array[18] = "Alt";
keycode_array[19] = "Pause/Break";
keycode_array[20] = "CapsLock";
keycode_array[27] = "Esc";
keycode_array[32] = "Spacebar";
keycode_array[33] = "PageUp";
keycode_array[34] = "PageDown";
keycode_array[35] = "End";
keycode_array[36] = "Home";
keycode_array[37] = "Left";
keycode_array[38] = "Up";
keycode_array[39] = "Right";
keycode_array[40] = "Down";
keycode_array[45] = "Insert";
keycode_array[46] = "Delete";
keycode_array[48] = 0;
keycode_array[49] = 1;
keycode_array[50] = 2;
keycode_array[51] = 3;
keycode_array[52] = 4;
keycode_array[53] = 5;
keycode_array[54] = 6;
keycode_array[55] = 7;
keycode_array[56] = 8;
keycode_array[57] = 9;
keycode_array[65] = "A";
keycode_array[66] = "B";
keycode_array[67] = "C";
keycode_array[68] = "D";
keycode_array[69] = "E";
keycode_array[70] = "F";
keycode_array[71] = "G";
keycode_array[72] = "H";
keycode_array[73] = "I";
keycode_array[74] = "J";
keycode_array[75] = "K";
keycode_array[76] = "L";
keycode_array[77] = "M";
keycode_array[78] = "N";
keycode_array[79] = "O";
keycode_array[80] = "P";
keycode_array[81] = "Q";
keycode_array[82] = "R";
keycode_array[83] = "S";
keycode_array[84] = "T";
keycode_array[85] = "U";
keycode_array[86] = "V";
keycode_array[87] = "W";
keycode_array[88] = "X";
keycode_array[89] = "Y";
keycode_array[90] = "Z";
keycode_array[96] = "Num 0";
keycode_array[97] = "Num 1";
keycode_array[98] = "Num 2";
keycode_array[99] = "Num 3";
keycode_array[100] = "Num 4";
keycode_array[101] = "Num 5";
keycode_array[102] = "Num 6";
keycode_array[103] = "Num 7";
keycode_array[104] = "Num 8";
keycode_array[105] = "Num 9";
keycode_array[106] = "*";
keycode_array[107] = "+";
keycode_array[109] = "-";
keycode_array[110] = ".";
keycode_array[111] = "/";
keycode_array[112] = "F1";
keycode_array[113] = "F2";
keycode_array[114] = "F3";
keycode_array[115] = "F4";
keycode_array[116] = "F5";
keycode_array[117] = "F6";
keycode_array[118] = "F7";
keycode_array[119] = "F8";
keycode_array[120] = "F9";
keycode_array[122] = "F11";
keycode_array[123] = "F12";
keycode_array[124] = "F13";
keycode_array[125] = "F14";
keycode_array[126] = "F15";
keycode_array[144] = "NumLock";
keycode_array[145] = "ScrollLock";
keycode_array[186] = ";";
keycode_array[187] = "=";
keycode_array[188] = ",";
keycode_array[189] = "-";
keycode_array[190] = ".";
keycode_array[191] = "/";
keycode_array[192] = "'";
keycode_array[219] = "[";
keycode_array[220] = "|";
keycode_array[221] = "]";
keycode_array[222] = "\\";
keycode_array[223] = "Right Ctrl";
keycode_array[226] = "~";

//The keydown array is used to allow multiple key strokes at the same time
//Everytime a key is pressed, its keydown_array[KEYCODE] is set to true
//and everytime a key is released, its keydown is set to false
keydown_array = new Array();
resetKeyDown = function () {
	for (i=0; i<=500; i++) {
		keydown_array[i] = false;
	}
};

resetKeyDown();
if (controlSet<>"custom") {
	resetKey();
}

// ---- layer "Main_Array", frame 8
//Trial with the "main_array"
//The main array is an array of methods to be called on each frame
//Instead of using "If-Elseif" and "Switch()", methods are added
//to the array when they need to be executed, and removed when they
//need to be stopped
Array.prototype.indexOf = function(data) {
	for (i=0; i<this.length; i++) {
		if (this[i] == data) {
			return i;
		}
	}
	return -1;
};


main_array = new Array();

//PUSH function
//push is used to add a method to main_array
//if method is already running, push returns false
//if unShift, then the element gets unshifted instead of pushed (start of array instead of end)
push = function (data, unShift) {
	for (i=0; i<=main_array.length-1; i++) {
		if (main_array[i] == data) {
			return false;
		}
	}
	if (unShift == true) {
		main_array.unshift(data);
	} else {
		main_array.push(data);
	}
	return true;
};

clip = function (data) {
	for (i=0; i<=main_array.length-1; i++) {
		if (main_array[i] == data) {
			main_array.splice(i,1);
			return true;
		}
	}
	return false;
};



clearMain = function () {
	main_array = null;
	main_array = new Array();
};

stopMainArray = false;
runMain = function () {
	if (stopMainArray || tutFreeze) {
		return;
	}
	for (ii=0; ii<=main_array.length-1; ii++) {
		main_array[ii].apply(null);
	}
};

// ---- layer "Listener", frame 1
//Each frame should have its custom listener so no functions are miscalled
var keyListener:Object = new Object();
keyListener.onKeyDown = function() {
	//custom events for keyDown
	callKeyDown(Key.getCode());
	//CONSOLE COMMANDS
	if (Key.getCode() == 107 || Key.getCode() == 109 || Key.getCode() == 187 || Key.getCode() == 189) {
		toggleConsole();
	}
	//code for skipping cutscenes with spacebar
	if (Key.getCode() == 32) {
		skipScene();
	}
	keydown_array[Key.getCode()] = true;
	if (Key.getCode() == KEY_BOOST && boostEnabled == true && runSlideJumpBool<>true) {
		push(runBoost);
	}
	if (slideMeterKeyPushed == "") {
		//Used to see if a key was pressed to use boosted sleigh
		slideMeterKeyPushed = 1;
	}
};
keyListener.onKeyUp = function() {
	keydown_array[Key.getCode()] = false;
};
Key.addListener(keyListener);


//var keyListener:Object = new Object();
//keyListener.onKeyDown = function() {
//keydown_array[Key.getCode()] = true;
//};
//keyListener.onKeyUp = function() {
//keydown_array[Key.getCode()] = false;
//};
//Key.addListener(keyListener);

// ---- layer "BitmapData", frame 6
import flash.display.*;
import flash.geom.*;
import flash.filters.*;


var snapshot = new BitmapData(640, 480, false, 0x000000);

var snapshotBlur = new BlurFilter(5, 5, 1);

printScreen = function () {
	snapshot.draw(_global.drawTarget,new Matrix(),new ColorTransform(),"normal",new flash.geom.Rectangle(0, 0, 640, 480));
};

addBlur = function (data) {
	data.applyFilter(data,data.rectangle,null,snapshotBlur);
};

// ---- layer "Camera", frame 11
//Cam Config
CAM_CENTER_X = 320;//Adjustment for where to aim the player's coordinates at
CAM_CENTER_Y = 240;//Adjustment for where to aim the player's coordinates at
CAM_BOUND_LIMIT = 80;//When the distance from the center is greater than this, further acceleration is applied
CAM_SPEED_ACCELERATION = 0.3;//Acceleration of the camera momentum
CAM_SPEED_FRICTION = 0.5;//Speed reduction for camera momentum

//cam_array store every element moving with the camera
cam_array = new Array();
//factor determines how much of the camera moevement the object take (Less when in bg for example)
cam_factor = new Array();
cam_vx = 0;
cam_vy = 0;
cam_frozen = 0;
cam_slowed = 0;
cam_slowed_max = 0;

//pushCam simply push the element and its factor to the correct arrays
pushCam = function (mc, factor) {
	//default values
	if (mc == undefined) {
		return false;
	}
	if (factor == undefined) {
		factor = 1;
	}
	//------------   
	cam_array.push(mc);
	cam_factor.push(factor);
};

clipCam = function (mc) {
	for (l=0; l<=cam_array.length-1; l++) {
		if (cam_array[l] == mc) {
			cam_array.splice(l,1);
			cam_factor.splice(l,1);
			return true;
		}
	}
	return false;
};

//runCam
runCam = function () {
	if (cam_frozen>=1) {
		cam_frozen--;
	} else {
		cam_dist_ratio = 1+Math.min(2, Math.sqrt((CAM_CENTER_X-player._x)*(CAM_CENTER_X-player._x)+(CAM_CENTER_Y-player._y)*(CAM_CENTER_Y-player._y))/100);
		cam_vx *= CAM_SPEED_FRICTION;
		cam_vy *= CAM_SPEED_FRICTION;
		//If camera is going the wrong way, apply resistance again!
		if ((cam_vx>=0.1 && CAM_CENTER_X-player._x<=-0.1) || (cam_vx<=-0.1 && CAM_CENTER_X-player._x>=0.1)) {
			cam_vx = 0;
			//cam_vx *= CAM_SPEED_FRICTION;
		}
		if ((cam_vy>=0.1 && CAM_CENTER_Y-player._y<=-0.1) || (cam_vy<=-0.1 && CAM_CENTER_Y-player._y>=0.1)) {
			cam_vy = 0;
			//cam_vy *= CAM_SPEED_FRICTION;
		}
		//Camera movement                                      
		if (cam_slowed>=1) {
			cam_slowed--;
			cam_vx += (CAM_CENTER_X-player._x)*CAM_SPEED_ACCELERATION*((cam_slowed_max-cam_slowed)/cam_slowed_max);
			cam_vy += (CAM_CENTER_Y-player._y)*CAM_SPEED_ACCELERATION*((cam_slowed_max-cam_slowed)/cam_slowed_max);
		} else {
			cam_vx += (CAM_CENTER_X-player._x)*CAM_SPEED_ACCELERATION*cam_dist_ratio;
			cam_vy += (CAM_CENTER_Y-player._y)*CAM_SPEED_ACCELERATION*cam_dist_ratio;
			cam_xlimit = Math.min(3, Math.max(0, Math.abs(CAM_CENTER_X-player._x)/CAM_BOUND_LIMIT-1));
			cam_ylimit = Math.min(3, Math.max(0, Math.abs(CAM_CENTER_Y-player._y)/CAM_BOUND_LIMIT-1));
			//When player gets out of bounds, increase movement
			if (Math.abs(CAM_CENTER_X-player._x)>=CAM_BOUND_LIMIT || Math.abs(CAM_CENTER_Y-player._y)>=CAM_BOUND_LIMIT) {
				cam_vx += (CAM_CENTER_X-player._x)*CAM_SPEED_ACCELERATION*cam_dist_ratio*cam_xlimit*0.3;
				cam_vy += (CAM_CENTER_Y-player._y)*CAM_SPEED_ACCELERATION*cam_dist_ratio*cam_ylimit*0.3;
			}
		}
		//if (Math.abs(cam_vx)<=0.07 && Math.abs(cam_vy)<=0.07) {
		//Null movement when too slow??
		//}
		for (i=0; i<=cam_array.length-1; i++) {
			cam_array[i]._x += cam_vx*cam_factor[i];
			cam_array[i]._y += cam_vy;
			//*cam_factor[i]
		}
	}
};

//delayCam
//data1 = frames until stop freezing
//data2 = frames until full speed
//data3 = Multiplier of camera momentum, from 0 to 1, or over 1 to increase camera speed... but why?
//data1 and data2 are number of frames non depending on one another
//ex : (10,10) means 10 frozen and 10 slowed frames
delayCam = function (data1, data2, data3) {
	cam_vx *= data3;
	cam_vy *= data3;
	cam_frozen = data1;
	cam_slowed = data2;
	cam_slowed_max = data2;
};

delayCam(0,0,0);
push(runCam);

// ---- layer "Setup", frame 11
import flash.geom.Point;

getEquip = function (data) {
	for (i=0; i<=_root["test_upg_"+data].length-1; i++) {
		if (_root["test_upg_"+data][i] == 2) {
			return i;
		}
	}
	_root["test_upg_"+data][0] = 2;
	return 0;
};

playerSleigh = getEquip("sleigh");
playerGlider = getEquip("glider");
playerBoost = getEquip("boost");
playerPayload = getEquip("payload");
trace("playerPayload = " +  playerPayload);

ramp._x = hotspot._x=380;
ramp._y = hotspot._y=-_root.test_upg_length[_root.test_player_length]+380;
ramp.gotoAndStop(Math.max(1, _root.test_player_length));
hotspot.gotoAndStop(Math.max(1, _root.test_player_length));
ramp.ramp_fall._y = _root.test_upg_length[_root.test_player_length];
hotspot.hotspot1._y = ramp.ramp_fall._y;

hotspot._visible = false;
ramp_tracer._visible = false;

ramp.jump2.gotoAndStop(RAMP_JUMP_ANGLE_OVER);
hotspot.hotspot3.gotoAndStop(RAMP_JUMP_ANGLE_OVER);

//rampOver, or ramp snow
ramp.rampOver.gotoAndStop(ramp._currentframe);
ramp.rampOver.fall._y = ramp.ramp_fall._y;
ramp.rampOver.jump2.gotoAndStop(RAMP_JUMP_ANGLE_OVER);


playerStart = new Point();
playerStart.x = hotspot.hotspot1.startTarget._x;
playerStart.y = hotspot.hotspot1.startTarget._y;
hotspot.hotspot1.localToGlobal(playerStart);

player._x = playerStart.x;
player._y = playerStart.y;

refreshControlMode = function () {
	if (controlMode == "mouse") {
		player.attachMovie("mouse_control_guide","mouseGuide",player.getNextHighestDepth());
		player.mouseGuide._alpha = 0;
		player.onMouseMove = function() {
			this.rotationTarget = Math.atan2(player._ymouse, player._xmouse)/rads;
			this.mouseGuide._rotation = this.rotationTarget;
			this.mouseGuide._xscale = Math.sqrt(Math.pow(player._xmouse, 2)+Math.pow(player._ymouse, 2));
			this.mouseGuide._alpha = Math.abs(this.rotationTarget);
			_root.updateAfterEvent();
		};
		player.onEnterFrame = function() {
			this.rotationTarget = Math.atan2(player._ymouse, player._xmouse)/rads;
			this.mouseGuide._rotation = this.rotationTarget;
			this.mouseGuide._xscale = Math.sqrt(Math.pow(player._xmouse, 2)+Math.pow(player._ymouse, 2));
			this.mouseGuide._alpha = Math.abs(this.rotationTarget);
		};
		//Little cheat for mouse controlled boost
		player.onMouseDown = function() {
			_root.keydown_array[_root.KEY_BOOST] = true;
			if (boostEnabled == true && runSlideJumpBool<>true) {
				push(runBoost);
			}
		};
		player.onMouseUp = function() {
			_root.keydown_array[_root.KEY_BOOST] = false;
		};
	} else {
		player.mouseGuide.removeMovieClip();
		player.onMouseMove = null;
		player.onEnterFrame = null;
		player.onMouseDown = null;
		player.onMouseUp = null;
	}
};
refreshControlMode();
//Player init---------------------------------------------------------------------                                   
sleigh._x = player._x;
sleigh._y = player._y;
sleigh.gotoAndStop(playerSleigh+1);
sleigh.sleigh.gotoAndStop(1);//Only works on "jump" sleighs
player.gotoAndStop(playerGlider+1);//Equipped Glider
//Penguin payload for classic mode (& arcade?)
if (GAME_MODE == "story") {
	player.payload.gotoAndStop(playerPayload+1);//Equipped Payload
} else {
	player.payload.gotoAndStop("penguin");//Equipped Payload
}
player.boost.gotoAndStop(playerBoost+1);//Equipped Boost

//this line prevents the boost part from going crazy with its animation
player.boost.boost.gotoAndStop(1);
//--------------------------------------------------------------------------------

//Insert objects that will "obey" camera movement
pushCam(player,1);
pushCam(ramp,1);
pushCam(sleigh,1);

//Required function
getEquip = function (data) {
	if (_root["test_upg_"+data]<>undefined) {
		for (i=0; i<=_root["test_upg_"+data].length-1; i++) {
			if (_root["test_upg_"+data][i] == 2) {
				return i;
			}
		}
		_root["test_upg_"+data][0] = 2;
		return 0;
	} else {
		return 0;
	}
};

hasExplosive = function () {
	if (playerPayload>=5 && playerPayload<=7) {
		return true;
	}
	return false;
};

// ---- layer "Slide", frame 11
import flash.geom.Point;

//Slide config
SLIDE_MIN_OBJX = 9;//Minimum pixels to look forward when hittesting for slope angle
//ALWAYS reset "slide_state" to 0 when starting a slide
state = 0;

//Vars
//Set vmag to 0, vdir to 90
slide_vmag = 1.5;
slide_vdir = 0;

//Stats debug
//Acceleration (And weight???) are taken into account
//Weight should probably "influence" acceleration
test_slide_acceleration = stat_sleigh_speed[playerSleigh];
debug_sleigh_friction = stat_sleigh_friction[playerSleigh];//friction when sliding
debug_sleigh_jump = stat_sleigh_jump[playerSleigh];//Max amount of jump from slider
debug_takeoff_mult = stat_takeoff_mult[playerSleigh];//Cheat to help differences between sleighs
debug_sleigh_takeoff = stat_sleigh_takeoff[playerSleigh];//Multiplier for sleigh_vx when leaving ramp (Does the sleigh fly further than the player)
debug_sleigh_spin = stat_sleigh_spin[playerSleigh];//Amount of maximum rotation of the sleigh when leaving ramp
debug_sleigh_gravity = stat_sleigh_gravity[playerSleigh];//Amount of gravity applied to the sleigh when leaving ramp
debug_sleigh_resistance = stat_sleigh_resistance[playerSleigh];//Restance in the flight of the sleigh itself
debug_takeoff_mult = stat_takeoff_mult[playerSleigh];//Cheating speeds to increase the differences between sleighs

//Old debug values
//test_slide_acceleration = 0.4;
//debug_sleigh_takeoff = 2;//Multiplier for sleigh_vx when leaving ramp (Does the sleigh fly further than the player)
//debug_sleigh_spin = 2;//Amount of maximum rotation of the sleigh when leaving ramp
//debug_sleigh_gravity = 0.6;//Amount of gravity applied to the sleigh when leaving ramp
//debug_sleigh_resistance = 0.92;//Restance in the flight of the sleigh itself

//used to trigger the sliding sound on 1st frame
sfxPlayed = false;

runSlide = function () {
	changeVolume("mute");
	if (!sfxPlayed) {
		playSfx("slide_light_LOOP",true);
		sfxPlayed = true;
	}
	//slideFactor adjusts the volume of sfx while sliding, to give a fading effect   
	slideFactor = Math.max(0, Math.min(1, (slide_vmag - test_slide_acceleration * 4) / (test_slide_acceleration * 25)));
	refreshMasterVolume("sfx");
	//hotspot is moved to detect ramp under the player
	hotspot._x = ramp._x;
	hotspot._y = ramp._y;
	//Apply the movement                                                                            
	player._x += slide_vmag * Math.cos(slide_vdir * (Math.PI / 180));
	player._y += slide_vmag * Math.sin(slide_vdir * (Math.PI / 180));
	meterTarget = new Point(hotspot.hotspot3.meterTarget._x, hotspot.hotspot3.meterTarget._y);
	hotspot.hotspot3.localToGlobal(meterTarget);
	//Define movieclip to hitTest
	if (state == 0 && player._x >= ramp._x - 10) {
		state = 1;
		player._x = ramp._x - 8;
	} else if (state < 2 && player._y >= ramp._y + 2) {
		state = 2;
		player._x = Math.max(player._x + (player._y - ramp_y), ramp._x + 4);
	}
	ramp_hotspot = hotspot;
	if (state == 0) {
		//Player position
		ramp_tracer._x = player._x + 3;
		ramp_tracer._y = player._y;
		positionArray = new Array();
		ramp_tracer._x = player._x;
		positionArray.push(checkForTop(ramp_tracer, hotspot, 0));
		if (positionArray.length == 0) {
			positionResult = player._y;
		} else {
			positionResult = positionArray.average();
		}
		//Slope Angle
		positionArray = new Array();
		ramp_tracer._x = player._x + SLIDE_MIN_OBJX + 1;
		positionArray.push(checkForTop(ramp_tracer, hotspot, 100));
		////////////////////////////////////////////////////////////////                                                                                                   
		//Get approximative angle of slope
		//From player x/y to adjusted x/y, find slope angle
		if (positionArray.length == 0) {
			positionArray[0] = player._y;
		}
		player._y = positionResult;
		slide_vdir = Math.max(0, Math.atan((positionArray.average() - player._y) / (SLIDE_MIN_OBJX + 2)) / rads);
		player._y -= sleigh.tracer._y;
		//friction
		slide_vmag *= debug_sleigh_friction;
		////////////////////////////////////////////////////////////////
		//Apply modified acceleration (Depending on slope angle)
		slide_vmag += Math.max(0, test_slide_acceleration * slide_vdir * rads);
		player._rotation -= (player._rotation - slide_vdir) / 5;
		//player._rotation = Math.max(player._rotation, slide_vdir);
	} else if (state == 1) {
		//going straight down
		slide_vdir += (90 - slide_vdir) / 4;
		player._x += ((ramp._x + sleigh.tracer._y) - player._x) / 4;
		//friction
		slide_vmag *= debug_sleigh_friction;
		////////////////////////////////////////////////////////////////
		//Apply modified acceleration (Depending on slope angle)
		slide_vmag += test_slide_acceleration * slide_vdir / 57.3;
		player._rotation = slide_vdir;
	} else if (state == 2 || state == 2.1) {
		//Player position
		ramp_tracer._x = player._x - 1;
		ramp_tracer._y = player._y;
		positionArray = new Array();
		ramp_tracer._x = player._x;
		positionArray.push(checkForTop(ramp_tracer, hotspot, 0));
		positionResult = positionArray.average();
		//Slope Angle
		positionArray = new Array();
		ramp_tracer._x = Math.min(meterTarget.x - 3, player._x + SLIDE_MIN_OBJX);
		positionArray.push(checkForTop(ramp_tracer, hotspot, 0));
		////////////////////////////////////////////////////////////////                                                                                                   
		//Get approximative angle of slope
		//From player x/y to adjusted x/y, find slope angle
		player._y = Math.max(Math.min(ramp._y, meterTarget.y), positionResult);
		slide_vdir = Math.min(slide_vdir, Math.atan((positionArray.average() - player._y) / (SLIDE_MIN_OBJX + 2)) / rads);
		player._y -= sleigh.tracer._y;
		////////////////////////////////////////////////////////////////
		//Apply modified acceleration (Depending on slope angle)
		slide_vmag += Math.max(0, test_slide_acceleration * slide_vdir * rads);
		//free acceleration!
		slide_vmag *= 1.01;
		player._rotation = slide_vdir;
		//player._rotation = Math.max(player._rotation, slide_vdir);
		//If next frame leaves ramp, JUMP!
		if (player._x + slide_vmag * 1.2 * Math.cos(slide_vdir * (Math.PI / 180)) >= meterTarget.x - 4) {
			runJump(RAMP_JUMP_ANGLE);
			return;
		}
		player._rotation = slide_vdir;
	}
	player._rotation = Math.max(player._rotation, Math.min(0, RAMP_JUMP_ANGLE));
};

//runJump is the takeoff part, moving from runSlide to runGlide
runJump = function (jumpAngle, jumpPower) {
	if (jumpPower == undefined || jumpPower == null) {
		jumpPower = 0;
	}
	if (jumpAngle == undefined || jumpAngle == null) {
		jumpAngle = player._rotation;
	}
	//Up the boost keep, needs to press again
	keydown_array[KEY_BOOST] = false;
	//stop sfx to stop sliding sfx  
	stopSfx();
	//CHEATING SPEEDS for better sleighs           
	slide_vmag *= debug_takeoff_mult * slide_vmag * slide_vmag + 1;
	push(verifyChallenge);
	push(verifyMedal);
	if (state <> 3) {
		state = 3;
		//Put the ramp BEHIND player
		ramp.swapDepths(ramp_behind_holder);
		changeVolume(slide_vmag);
		bgm0.stop();
		bgm1.stop();
		bgm2.stop();
		bgm0.start(0,999);
		bgm1.start(0,999);
		bgm2.start(0,999);
		//Launch runFly(mag,dir)
		//Initialise glide_vars
		REF_duration = 0;
		//Reset duration timer
		boostEnabled = true;
		glide_vdir = jumpAngle;
		//jumpPower>0 when player is using explosives/spring sleigh
		if (jumpPower > 0) {
			glide_vmag = slide_vmag;
			glide_vx = Math.cos(glide_vdir * rads) * glide_vmag + Math.cos((glide_vdir - 50) * rads) * jumpPower;
			glide_vy = Math.sin(glide_vdir * rads) * glide_vmag + Math.sin((glide_vdir - 50) * rads) * jumpPower;
			player._rotation = Math.atan2(glide_vy, glide_vx) / rads;
		} else {
			player._rotation = glide_vdir;
			glide_vmag = slide_vmag;
			glide_vx = Math.cos(glide_vdir * rads) * glide_vmag;
			glide_vy = Math.sin(glide_vdir * rads) * glide_vmag;
		}
		sleigh_vx = glide_vx * debug_sleigh_takeoff;
		sleigh_vy = glide_vy * 0.9;
		sleigh_vr = -1 * debug_sleigh_spin + Math.random() * (debug_sleigh_spin * 2);
		sleigh_vrmod = -0.5 * debug_sleigh_spin + Math.random() * debug_sleigh_spin;
		//Remove runSlide from main_array;
		clip(runSlide);
		//Add rotate and glide functions
		push(runRotate,true);
		push(runGlide,true);
		push(runProp,true);
		//delayCam(0,2,0);
		//Setup HUDs
		setHUD();
		setBonusHUD();
		initBoost();
	} else {
		glide_vdir = jumpAngle;
		//jumpPower>0 when player is using explosives/spring sleigh
		if (jumpPower > 0) {
			glide_vmag = slide_vmag;
			glide_vx = Math.cos(glide_vdir * rads) * glide_vmag + Math.cos((glide_vdir - 50) * rads) * jumpPower;
			glide_vy = Math.sin(glide_vdir * rads) * glide_vmag + Math.sin((glide_vdir - 50) * rads) * jumpPower;
			player._rotation = Math.atan2(glide_vy, glide_vx) / rads;
		} else {
			player._rotation = glide_vdir;
			glide_vmag = slide_vmag;
			glide_vx = Math.cos(glide_vdir * rads) * glide_vmag;
			glide_vy = Math.sin(glide_vdir * rads) * glide_vmag;
		}
		sleigh_vx = glide_vx * debug_sleigh_takeoff;
		sleigh_vy = glide_vy * 0.9;
		sleigh_vr = -1 * debug_sleigh_spin + Math.random() * (debug_sleigh_spin * 2);
		sleigh_vrmod = -0.5 * debug_sleigh_spin + Math.random() * debug_sleigh_spin;
	}
};

runSleigh = function () {
	if (state == 0 || state == 1 || state == 2) {
		sleigh._x = player._x;
		sleigh._y = player._y;
		sleigh._rotation = player._rotation;
	} else {
		sleigh_vx *= debug_sleigh_resistance;
		sleigh_vy += debug_sleigh_gravity;
		sleigh._rotation += sleigh_vr;
		if (Math.abs(sleigh_vr) <= 12) {
			sleigh_vr += sleigh_vrmod;
		}
		sleigh._x += sleigh_vx;
		sleigh._y += sleigh_vy;
	}
};

push(runSlide);
push(runSleigh);

// ---- layer "Glider", frame 11
//CONFIG
CLASSIC_MODE_GOAL = 6000;
//classicModeGoalBool holds if the game was completed on classic or if pacifist was achieved on story
//classicModeGoalBool = false;
//classicModeGoalBoolTemp prevents multiple triggers in a single run, hence the reset on everyday
classicModeGoalBoolTemp = false;

dayIsOver = false;

GLIDER_ROTATION_SPEED = 2;//Adjustment for rotation/control of all gliders
GLIDER_ROTATION_ALTER = 1.25;//Adjustment for rotation/control depending on speed/max speed (ex: 1 = 2x faster at speed=0, 2 = 3x, 0 = same speed)
GLIDER_ROTATION_MAX_DECREASE = -0.3;//Adjustment for the maximum decrease in control when speed>max (-0.5 = maximum of half speed rotation)

MOUSE_CONTROL_TOLERANCE = 1;//Amount of degrees off target needed for mouse to execute rotation command

GROUND_COLLISION_ADJUST = -7;//Adjust the player._y when check for ground collision, too high dayResults in hovering, too low in sinking in the ground
GROUND_FRICTION = 0.985;//Amount of friction from touching the ground
GROUND_FIXED_FRICTION = 0.3;//Amount of friction substracted from mag

GLIDE_END_TIMER = 30;//Number of frames spent not moving to end the day
//BONUS lowered redzone
RED_ZONE_RESISTANCE = 0.05 * (1 - 0.1 * bonusItemOwn[5]);//Maximum amount of resistance from red zone (From 0 and up, will be substracted from 1)
AIR_RESISTANCE = 0.9965;//Amount of air resistance when flying
//BONUS - recalculate lowered air resistance
AIR_RESISTANCE += (1 - AIR_RESISTANCE) * 0.1 * bonusItemOwn[2];

SEA_RESISTANCE = 0.9;//Amount of resistance applied when underwater
SEA_STOPPING_SPEED = 9;//Speed at which the flight ends underwater
SEA_STOPPING_TIMER = 35;////Number of frames spent under stopping speed before locking controls
SEA_FLOAT = 0.88;//Speed at which "inverted gravity" is applied underwater
SEA_END_TIMER = 40;//Number of frames spent not moving to end the day
SEA_MINIMUM_BOUNCE_ANGLE = -15;//Angle past which the player dives into the sea, not bouncing
SEA_MAXIMUM_BOUNCE_ANGLE = 17;//Angle past which the player dives into the sea, not bouncing
SEA_BOUNCE_FRICTION = 0.85;//Speed loss upon bouncing
SEA_BOUNCE_MINIMUM_SPEED = 20;
SEA_BOUNCE_MINIMUM_DELAY = 9;//# of frames required between two bounces, else you sink
SEA_BUBBLE_AMOUNT = 0.2;//MULT - amount of bubble generated underwater
SEA_BUBBLE_SPEED_USED = 0.15;//MULT - amount of bubble generated from speed
SEA_BUBBLE_DEFAULT = 0.25;//MULT - amount of bubble generated from time
SEA_BUBBLE_DIVE_AMOUNT = 0.6;//MULT - amount of bubble generated when entering the water
SEA_END_SPEED = 0.001;//Speed below which control is taken away from the player when underwater

SNOW_BOOM_MAX_SPEED = 300;//Speed at which effect is maximal
SNOW_BOOM_MIN_SPEED = 25;//Speed required to launch effect


//GLIDER stats
test_turn_rate = _root.stat_glider_spin[playerGlider];//STAT - Rotation speed
test_glider_control = _root.stat_glider_control[playerGlider];//STAT - Vector change speed, amount applied from target to inertia ( 0 to 1 )
test_glider_catch = _root.stat_glider_catch[playerGlider];//STAT - Amount on contorl over falling, accelerating, etc ( 0 to 1 )
test_glider_upcatch = _root.stat_glider_upcatch[playerGlider];//STAT - Amount of speed lost when going UPWARD ONLY
test_gliding_speed = _root.stat_gliding_speed[playerGlider];//STAT - Speed at which lift = lift_max
test_falling_speed = _root.stat_falling_speed[playerGlider];//STAT - Speed at which lift = lift_min
test_red_zone = _root.stat_glider_speed[playerGlider];//STAT - Spped after which resistance increases
test_spin_red_zone = _root.stat_glider_spin_red[playerGlider];//STAT - Spped after which resistance increases
//BONUS - slightly lowered gravity
test_gravity = _root.stat_glider_gravity[playerGlider] * (1 - 0.0333 * bonusItemOwn[6]);//STAT - Gravity
test_lift_max = Math.min(_root.stat_glider_lift_max[playerGlider], test_gravity * 0.999);//STAT - Maximum applied lift
test_lift_min = _root.stat_glider_lift_min[playerGlider];//STAT - Minimum applied lift (Applied even at 0 speed)
test_float = _root.stat_glider_float[playerGlider];//STAT - float in sea, adds up on normal float

//PAYLOAD stats
test_resist = _root.stat_payload_resist[playerPayload];//STAT - resistance taken from Payload, applied underwater

rads = Math.PI / 180;//Constant - Ratio between degrees and Radians
glide_vdir = 0;
glide_vmag = 0;
glide_vx = 0;
glide_vy = 0;
grav_mag = 0;//Accumulated Gravity Vector

//seaBouncesTotal
seaBounces = 0;//counter for number of bounce achieved in a day
seaBounceCount = 0;//counter to distance bounce and prevent bouncing every frame



runGlide = function () {
	changeVolume(REF_speed);
	runSea();
	//BUILD VECTOR                               
	glide_vdir = Math.atan2(glide_vy, glide_vx) / rads;
	glide_vmag = Math.sqrt(glide_vx * glide_vx + glide_vy * glide_vy);
	//Limit CRAZY speeds
	glide_vmag = Math.min(glide_vmag, 2500);
	//ACCELERATION - DRAG 
	//Four different calculations, depending in which quarter the player is facing
	//TESTING - "upcatch", seperate stat for going upward
	if (player._rotation <= 0 && player._rotation >= (-90)) {
		glide_vmag *= 1 - (player._rotation / -85) * 0.1 * test_glider_upcatch;
		//Amount of acceleration
	} else if (player._rotation >= 0 && player._rotation <= 90) {
		glide_vmag *= 1 - (player._rotation / -85) * 0.1 * test_glider_catch;
	} else if (player._rotation >= 90 && player._rotation <= 180) {
		glide_vmag *= 1 - ((player._rotation - 180) / 85) * 0.1 * test_glider_catch;
	} else {
		glide_vmag *= 1 - ((player._rotation + 180) / 85) * 0.1 * test_glider_upcatch;
	}
	//Red zone
	if (REF_speed >= test_red_zone + 0.1) {
		glide_vmag *= 1 - RED_ZONE_RESISTANCE * Math.max(0, Math.min(5, (REF_speed - test_red_zone) / test_red_zone));
		grav_vmag *= 1 - RED_ZONE_RESISTANCE * Math.max(0, Math.min(5, (REF_speed - test_red_zone) / test_red_zone));
	}
	//Falling down - Can capture speed                                                                                                                                                                       
	//CANNOT capture speed when underwater
	if (old_sea_check) {
		if (grav_mag > 0 && player._rotation >= 1 && player._rotation <= 90) {
			glide_vmag += grav_mag * (Math.max(0, player._rotation / 90) / 50) * test_glider_catch;
		} else if (grav_mag > 0 && player._rotation >= 1 && player._rotation <= 90) {
			glide_vmag += grav_mag * (Math.max(0, player._rotation / 90) / 50) * test_glider_catch;
		}
	}
	//Air Resistance                                                         
	glide_vmag *= AIR_RESISTANCE;
	grav_mag *= AIR_RESISTANCE;
	//vdif = Math.min(90, Math.abs(glide_vdir-player._rotation));
	//glide_vdir -= Math.min(1, (90-vdif/90))*(glide_vdir-player._rotation)*test_glider_control;
	//APPLY CONTROL
	if (Math.abs(glide_vdir - player._rotation) >= 180) {
		if (glide_vdir >= 0) {
			glide_vdir -= ((glide_vdir - 360) - player._rotation) * test_glider_control;
		} else {
			glide_vdir -= ((glide_vdir + 360) - player._rotation) * test_glider_control;
		}
	} else {
		glide_vdir -= (glide_vdir - player._rotation) * test_glider_control;
	}
	//DECOMPOSE VECTOR
	glide_vx = Math.cos(glide_vdir * rads) * glide_vmag;
	glide_vy = Math.sin(glide_vdir * rads) * glide_vmag;
	//Gravity & Lift
	glide_ratio_gauge.gotoAndStop(Math.max(1, Math.min(400, Math.floor((glide_vmag - test_falling_speed) / (test_gliding_speed - test_falling_speed) * 400))));
	glide_ratio = glide_ratio_gauge._height / 100;
	if (grav_mag > 0 && glide_ratio > 0) {
		grav_mag *= 1 - (glide_ratio / 50);
	}
	lift = test_lift_min + (test_lift_max - test_lift_min) * glide_ratio;
	grav_mag += test_gravity - lift;
	//MOVE 
	player._y += glide_vy + grav_mag;
	player._x += glide_vx;
	runLanding();
	if (!classicModeGoalBoolTemp) {
		//Classic mode ending
		if (GAME_MODE == "classic") {
			if (!classicModeGoalBool && REF_distance >= CLASSIC_MODE_GOAL) {
				classicModeGoalBool = true;
				//Cutscene/Movie/Classic Outro
				_root.fadeTo("movieClassicOutro");
			}
		} else if (GAME_MODE == "story") {
			if (!medalBool[31] && !dayIsOver && !classicModeGoalBool && player._x >= ground_over_holder.obstacle5._x + 1500 && obstacleDestroyed[4] <> 1) {
				classicModeGoalBool = true;
				//Cutscene/Movie/Pacifist
				_root.fadeTo("moviePacifist");
			}
		}
	}
};




//DEBUG

runRotate = function () {
	//Turning
	//which is also adjusted by GLIDER_ROTATION_ADJUST to turn faster at lower speed
	//GLIDER_ROTATION_MAX_DECREASE specifies the maximum decrease in turn speed (0 to 1, 1 being NO control above 2x max speed)
	if (controlMode == "mouse") {
		if (player.rotationTarget >= MOUSE_CONTROL_TOLERANCE) {
			//Right
			player._rotation += Math.min((player.rotationTarget) / 3, test_turn_rate * GLIDER_ROTATION_SPEED * (1 + Math.min(1, Math.max(GLIDER_ROTATION_MAX_DECREASE, GLIDER_ROTATION_ALTER * ((test_spin_red_zone - REF_speed) / test_spin_red_zone)))));
		}
		if (player.rotationTarget <= -MOUSE_CONTROL_TOLERANCE) {
			//Left
			player._rotation -= Math.min((-player.rotationTarget) / 3, test_turn_rate * GLIDER_ROTATION_SPEED * (1 + Math.min(1, Math.max(GLIDER_ROTATION_MAX_DECREASE, GLIDER_ROTATION_ALTER * ((test_spin_red_zone - REF_speed) / test_spin_red_zone)))));
		}
		//If player is touching the ground and trying to turn, kick it                                                                                                                                                                                                                                                                                                        
		if (checkAboveGround() && REF_speed >= test_falling_speed && (((player._rotation >= -90 && player._rotation <= 90) && player._y + GROUND_COLLISION_ADJUST >= ground_over_holder.ground1._y) || ((player._rotation < (-90) || player._rotation > 90) && player._y + GROUND_COLLISION_ADJUST >= ground_over_holder.ground1._y - player.hitspot._height))) {
			if (player._rotation <= 90 && player._rotation >= -90) {
				if (player.rotationTarget > 0 && player.rotationTarget <= MOUSE_CONTROL_TOLERANCE) {
					player._y -= 0.8;
				}
			} else {
				if (player.rotationTarget < 0 && player.rotationTarget >= -MOUSE_CONTROL_TOLERANCE) {
					player._y -= 0.8;
				}
			}
		}
	} else {
		if (keydown_array[KEY_RIGHT] || keydown_array[KEY_RIGHT2]) {
			player._rotation += test_turn_rate * GLIDER_ROTATION_SPEED * (1 + Math.min(1, Math.max(GLIDER_ROTATION_MAX_DECREASE, GLIDER_ROTATION_ALTER * ((test_spin_red_zone - REF_speed) / test_spin_red_zone))));
		}
		if (keydown_array[KEY_LEFT] || keydown_array[KEY_LEFT2]) {
			player._rotation -= test_turn_rate * GLIDER_ROTATION_SPEED * (1 + Math.min(1, Math.max(GLIDER_ROTATION_MAX_DECREASE, GLIDER_ROTATION_ALTER * ((test_spin_red_zone - REF_speed) / test_spin_red_zone))));
		}
		//If player is touching the ground and trying to turn, kick it                                                                                                                                                                                                                                                                                                        
		if (checkAboveGround() && REF_speed >= test_falling_speed && (((player._rotation >= -90 && player._rotation <= 90) && player._y + GROUND_COLLISION_ADJUST >= ground_over_holder.ground1._y) || ((player._rotation < (-90) || player._rotation > 90) && player._y + GROUND_COLLISION_ADJUST >= ground_over_holder.ground1._y - player.hitspot._height))) {
			if (player._rotation <= 90 && player._rotation >= -90) {
				if (keydown_array[KEY_LEFT] || keydown_array[KEY_LEFT2]) {
					player._y -= 0.8;
					//0.05;
					//glide_vy = -1;
				}
			} else {
				if (keydown_array[KEY_RIGHT] || keydown_array[KEY_RIGHT2]) {
					player._y -= 0.8;
					//0.05;
					//glide_vy = -1;
				}
			}
		}
	}
};


checkAboveGround = function () {
	if (player._x <= ground_over_holder.ground_end._x + ground_over_holder.ground_end._width) {
		return true;
	} else {
		return false;
	}
};


//Crashstrangth holds the last impact with the ground, used for challenges
crashStrength = 0;
//runLanding is the function that verifies if the player is touching the ground, the sea or nothing at all.
runLanding = function () {
	//---------------------------------------------------------------------------------
	//Detect Ground Collision
	//Is player above the ground or sea?
	if (checkAboveGround()) {
		if (((player._rotation >= -90 && player._rotation <= 90) && player._y + GROUND_COLLISION_ADJUST >= ground_over_holder.ground1._y) || ((player._rotation < (-90) || player._rotation > 90) && player._y + GROUND_COLLISION_ADJUST >= ground_over_holder.ground1._y - player.hitspot._height)) {
			//Special FX piling snow in front of character
			push(snowPiling);
			//Crashing and reducing speed
			//vmag should get resistance according to difference in agle to the ground (Hitting straight or landing)
			crashPower = 90 - Math.min(Math.abs(90 - REF_direction), Math.abs(-90 - REF_direction));
			crashStrength = Math.max(crashStrength, REF_speed * playerHitPower * (crashPower / 90));
			bestCrash = Math.max(bestCrash, crashStrength);
			if (crashPower <= 10 || glide_vmag <= SNOW_BOOM_MIN_SPEED) {
				glide_vmag = Math.sqrt(glide_vx * glide_vx + glide_vy * glide_vy) * GROUND_FRICTION;
			} else {
				//Generate BOOM effect
				snowBoom(player._x,ground_over_holder.ground1._y,10 + 25 * (crashPower / 90 * Math.min(1, glide_vmag / SNOW_BOOM_MAX_SPEED)),(10 + 25 * (crashPower / 90 * Math.min(1, glide_vmag / SNOW_BOOM_MAX_SPEED))) / 10,40 + 25 * (crashPower / 90 * Math.min(1, glide_vmag / SNOW_BOOM_MAX_SPEED)),1);
				particlePower = (crashPower / 90 * Math.min(1, glide_vmag / SNOW_BOOM_MAX_SPEED));
				for (k = 0; k <= 3 + 6 * particlePower; k++) {
					generateParticle("snow_part",player._x,player._y,30 + Math.random() * 40 * particlePower,50 + 50 * Math.random(),-90 - (REF_direction - 90) - 25 + Math.random() * 50,Math.random() * 15 + particlePower * 30,-5 + Math.random() * 10,0.99,0.4,500,10);
				}
				//Then adjust speed like the other case
				glide_vmag = (1 - crashPower / 90) * Math.sqrt(glide_vx * glide_vx + glide_vy * glide_vy) * GROUND_FRICTION;
			}
			//reform vector with new direction at 0 degree (or sometimes 180 if going backward?)
			//if (player._rotation>=-90 && player._rotation<=90) {
			if (player._rotation >= -10 && player._rotation <= 10) {
				player._rotation = glide_vdir = 0;
				player._y = ground_over_holder.ground1._y - GROUND_COLLISION_ADJUST;
			} else if (player._rotation >= 170 || player._rotation <= -170) {
				player._rotation = glide_vdir = 180;
				player._y = ground_over_holder.ground1._y - GROUND_COLLISION_ADJUST - Math.floor(player.hitspot._height);
				//empty propeller fuel
				if (test_prop_fuel_max >= 0) {
					test_prop_fuel = Math.max(-1, (test_prop_fuel - test_prop_fuel_max * 0.01));
					glide_vmag *= GROUND_FRICTION;
				}
			} else {
				//when speed is low, use _rotation instead of REF_direction, prevents flipping
				if (REF_speed <= 7) {
					if (player._rotation >= -90 && player._rotation <= 90) {
						player._rotation = 0;
						glide_vdir = 0;
						player._y = ground_over_holder.ground1._y - GROUND_COLLISION_ADJUST;
					} else {
						player._rotation = 180;
						glide_vdir = 180;
						player._y = ground_over_holder.ground1._y - GROUND_COLLISION_ADJUST - Math.floor(player.hitspot._height);
					}
				} else {
					if (REF_direction >= -90 && REF_direction <= 90) {
						player._rotation = 0;
						glide_vdir = 0;
						player._y = ground_over_holder.ground1._y - GROUND_COLLISION_ADJUST;
					} else {
						player._rotation = 180;
						glide_vdir = 180;
						player._y = ground_over_holder.ground1._y - GROUND_COLLISION_ADJUST - Math.floor(player.hitspot._height);
					}
				}
			}
			grav_mag = 0;
			if (player._rotation == 0) {
				if (glide_vmag >= 0.5) {
					glide_vmag = Math.max(0, glide_vmag - GROUND_FIXED_FRICTION);
				} else {
					glide_vmag = 0;
				}
			} else {
				if (glide_vmag >= 0.5) {
					glide_vmag = Math.max(0, glide_vmag - GROUND_FIXED_FRICTION);
				} else {
					glide_vmag = 0;
				}
			}
			glide_vx = Math.cos(glide_vdir * rads) * glide_vmag;
			glide_vy = Math.sin(glide_vdir * rads) * glide_vmag;
			//////////////////////////////////////////
			//Check if player isn't moving to end phase
			if (REF_speed == 0) {
				if (glide_end >= 1) {
					glide_end--;
				} else {
					stageFinished();
				}
			} else {
				glide_end = GLIDE_END_TIMER;
			}
		}
	} else {
		//if "else", player is above sea
	}
};

//Init
old_sea_check = false;//stores if player was in water last frame
bubble_count = 0;//Counter to know when to produce bubbles, depending on distance made underwater

runSea = function () {
	//use stageFinishedInSea with a maximum alt of sea level
	//so the same countdown applies wether you're floating up or surfacing
	seaBounceCount--;
	if (player._y >= sea_holder.ground1._y) {
		boostEnabled = false;
		keydown_array[KEY_BOOST] = false;
		//////////
		//BOUNCE//
		//////////
		if (!old_sea_check && seaBounceCount <= 0 && REF_SPEED >= SEA_BOUNCE_MINIMUM_SPEED && REF_direction >= SEA_MINIMUM_BOUNCE_ANGLE && REF_direction <= SEA_MAXIMUM_BOUNCE_ANGLE) {
			//player is within bouncing parameters
			seaBounces++;
			seaBouncesTotal++;
			bounceAngle = -45 + 30 * (Math.abs(REF_direction - SEA_MINIMUM_BOUNCE_ANGLE) / (SEA_MAXIMUM_BOUNCE_ANGLE - SEA_MINIMUM_BOUNCE_ANGLE));
			player._rotation = bounceAngle;
			glide_vx *= SEA_BOUNCE_FRICTION;
			glide_vy *= -SEA_BOUNCE_FRICTION;
			grav_vmag *= -SEA_BOUNCE_FRICTION;
			seaBounceCount = SEA_BOUNCE_MINIMUM_DELAY;
			//glide_vx = Math.cos(bounceAngle*rads)*REF_SPEED;
			//glide_vy = Math.sin(bounceAngle*rads)*REF_SPEED;
			//grav_vmag = 0;
			player._y = sea_holder.ground1._y - 3;
			waterSplash();
		} else {
			//////////////
			//UNDERWATER//
			//////////////
			if (!old_sea_check) {
				////////DIVING/////////
				waterSplash();
				for (l = 0; l <= REF_speed * SEA_BUBBLE_DIVE_AMOUNT / 25; l++) {
					generateBubble();
				}
			}
			bubble_count += REF_speed * SEA_BUBBLE_SPEED_USED + 1 * SEA_BUBBLE_SPEED_USED;
			while (bubble_count >= 25) {
				generateBubble();
				bubble_count -= 25;
			}
			if (Math.abs(REF_speedy - REF_oldspeedy) <= SEA_END_SPEED) {
				//player is below end speed, stage finished
				stageFinishedInSea(SEA_END_TIMER);
				return;
			}
			glide_vx *= SEA_RESISTANCE * test_resist;
			glide_vy *= SEA_RESISTANCE * test_resist;
			grav_mag *= SEA_RESISTANCE * test_resist;
			grav_mag -= SEA_FLOAT + test_float;
		}
	} else {
		boostEnabled = true;
		if (old_sea_check) {
			stageFinished();
		}
	}
	old_sea_check = (player._y >= sea_holder.ground1._y);
};

stageFinished = function (finishedOutsideOfGame) {
	dayIsOver = true;
	if (finishedOutsideOfGame == undefined || finishedOutsideOfGame == null) {
		finishedOutsideOfGame = false;
	}
	if (!finishedOutsideOfGame) {
		//SECRET 
		//RISE FROM YOUR GRAVE!
		if (GAME_MODE != "arcade" && checkAboveGround() && !secretTriggered && test_day >= 6 && Math.random() <= SECRET_RISE_ODDS) {
			//SECRET TRIGGERED
			runSecretRise();
			return;
		}
	}
	printScreen();
	clearMain();
	_root.gotoAndStop("result");
};

stageFinishedInSea = function (data) {
	dayIsOver = true;
	if (data <> undefined) {
		seaTimer = data;
		clearMain();
		push(runCam);
		push(stageFinishedInSea);
	}
	seaTimer--;
	if (seaTimer <= 0) {
		printScreen();
		clearMain();
		_root.gotoAndStop("result");
	}
	//Look up                                                                                            
	if (player._rotation > 90) {
		player._rotation += (-90 - (-180 - (180 - player._rotation))) / 20;
	} else {
		player._rotation += (-90 - player._rotation) / 20;
	}
	glide_vx *= SEA_RESISTANCE * test_resist;
	glide_vy *= SEA_RESISTANCE * test_resist;
	grav_mag *= SEA_RESISTANCE * test_resist;
	grav_mag -= SEA_FLOAT + test_float;
	glide_vdir = Math.atan2(glide_vy, glide_vx) / rads;
	glide_vmag = Math.sqrt(glide_vx * glide_vx + glide_vy * glide_vy);
	//ACCELERATION - DRAG
	//Four different calculations, depending in which quarter the player is facing
	if (player._rotation <= 0 && player._rotation >= (-90)) {
		glide_vmag *= 1 - (player._rotation / -85) * 0.1 * 0.7 * test_glider_catch;
		//Amount of acceleration
	} else if (player._rotation >= 0 && player._rotation <= 90) {
		glide_vmag *= 1 - (player._rotation / -85) * 0.1 * test_glider_catch;
	} else if (player._rotation >= 90 && player._rotation <= 180) {
		glide_vmag *= 1 - ((player._rotation - 180) / 85) * 0.1 * test_glider_catch;
	} else {
		glide_vmag *= 1 - ((player._rotation + 180) / 85) * 0.1 * 0.7 * test_glider_catch;
	}
	//Red zone
	if (glide_vmag >= test_red_zone + 0.1) {
		glide_vmag *= 1 - RED_ZONE_RESISTANCE * Math.max(0, Math.min(5, (glide_vmag - test_red_zone) / test_red_zone));
	}
	glide_vmag *= AIR_RESISTANCE;
	//DECOMPOSE VECTOR
	glide_vx = Math.cos(glide_vdir * rads) * glide_vmag;
	glide_vy = Math.sin(glide_vdir * rads) * glide_vmag;
	if (player._y + glide_vy + grav_mag <= sea_holder.ground1._y) {
		player._y = sea_holder.ground1._y;
		seaTimer--;
		if (seaTimer <= 0) {
			printScreen();
			clearMain();
			_root.gotoAndStop("result");
		}
	}
	player._y += glide_vy + grav_mag;
	player._x += glide_vx;
};

//data is the # of frames before action, action is what to do, "boom", "end" =default
setTimerOut = function (data, data2) {
	if (data2 <> undefined) {
		_root.timerOutAction = data2;
	} else {
		_root.timerOutAction = "end";
	}
	timerOutCount = data;
	clip(runGlide);
	clip(runRotate);
	push(timerOut);
};

timerOut = function () {
	timerOutCount--;
	if (timerOutCount <= 0) {
		if (_root.timerOutAction == "end") {
			stageFinished(true);
		} else if (_root.timerOutAction == "boom") {
		} else {
			trace("timerOut - Incorrect action");
		}
	}
};

// ---- layer "Propellers", frame 11
test_prop_lift = _root.stat_glider_prop_lift[playerGlider];//STAT - Propelling lift - Lift at 100% at angle-90 while fuel>0
test_prop_resist_x = _root.stat_glider_prop_resist_x[playerGlider];//STAT - Resistance for prop_vx
//BONUS - recalculate lowered air resistance for prop too
test_prop_resist_x += (1 - test_prop_resist_x) * 0.1 * bonusItemOwn[2];
test_prop_resist_y = _root.stat_glider_prop_resist_y[playerGlider];//STAT - Resistance for grav_mag
//BONUS - 10% extra prop fuel per level
test_prop_fuel = _root.stat_glider_prop_fuel[playerGlider] * (1 + 0.1 * bonusItemOwn[7]);//STAT - Number of frame with fuel to power test_prop_lift (0 to INF)
test_prop_fuel_max = test_prop_fuel;//VAR - Simply stores the maximum amount of fuel at the beginning of the round
test_prop_decay = _root.stat_glider_prop_decay[playerGlider];//STAT - Number of frame where propeller lift decays when fuel <=0
test_prop_decay_ref = test_prop_decay;//REFERENCE - Simply stores the MAX decay;

//runProp adds the propelled gliders lift
runProp = function () {
	//PROPELLING LIFT
	//if fuel left
	if (test_prop_fuel >= 0) {
		applyProp(test_prop_lift);
		test_prop_fuel--;
	} else if (test_prop_decay >= 0) {
		//When fuel reach 0, lift degrades until decay<=-1
		applyProp(test_prop_lift * (test_prop_decay / test_prop_decay_ref));
		test_prop_decay--;
	} else {
		//prop fuel out
	}
	glide_vx *= test_prop_resist_x;
};


//applyBoost modifies glide_vx/vy with booster stats
applyProp = function (power) {
	glide_vx += Math.cos((player._rotation - 90) * rads) * power;
	glide_vy += Math.sin((player._rotation - 90) * rads) * power;
	glide_vy *= test_prop_resist_y;
	grav_mag *= 0.99;
};

// ---- layer "Boost", frame 11

initBoost = function () {
	//BONUS - 5% extra boost fuel per level
	debug_fuel = _root.test_upg_fuel[_root.test_player_fuel] * (1 + 0.05 * bonusItemOwn[7]);
	debug_fuel_max = debug_fuel;
	oldFuel = debug_fuel;
	if (stat_boost_type[playerBoost] >= 2) {
		debug_fuel_stage = 0;
	} else {
		debug_fuel_stage = -1;
	}
	debug_boost_level = playerBoost;
	//BONUS - extra boost power
	debug_boost_power = _root.stat_boost_thrust[playerBoost] * (1 + 0.05 * bonusItemOwn[3]);
	import flash.geom.Point;
	//boost disabled until leaving ramp
	boostEnabled = false;
	keydown_array[KEY_BOOST] = false;
	clip(runBoost);
};

initBoost();


//runBoost is run every frame that KEY_BOOST is down, checks if fuel >=1
runBoost = function () {
	if (!boostEnabled) {
		clip(runBoost);
		return;
	}
	if (oldFuel > 0.1 && debug_fuel <= 0.1 && (debug_fuel_stage <= -1 || debug_fuel_stage >= 4)) {
		//fuel just depleted
		//SECRET
		//ROB
		if (GAME_MODE != "arcade" && !secretTriggered && REF_altitude >= 80 && Math.random() <= SECRET_ROB_ODDS) {
			//SECRET TRIGGERED
			runSecretRob();
		}
	}
	oldFuel = debug_fuel;
	if (debug_fuel == -1000) {
		//fuel was depleted
		return;
	}
	switch (debug_boost_level) {
		case 1 :
			//propeller
			if (debug_fuel >= 0.1 && keydown_array[KEY_BOOST]) {
				//fuel is left, run engine
				if (player.boost.boost._currentframe == 5) {
					player.boost.boost.gotoAndStop(2);
				} else {
					player.boost.boost.gotoAndStop(player.boost.boost._currentframe + 1);
				}
				debug_fuel -= stat_boost_economy[1];
				applyBoost(debug_boost_power);
				return;
			} else if (debug_fuel >= 0.1) {
				//fuel left, button released
				player.boost.boost.gotoAndPlay(6);
				clip(runBoost);
			} else if (debug_fuel >= -999) {
				//fuel depleted, run death anim, set fuel to -1000
				player.boost.boost.gotoAndPlay(6);
				debug_fuel = -1000;
				clip(runBoost);
			}
			return;
		case 2 :
			//Rocket
			if (debug_fuel >= 0.1 && keydown_array[KEY_BOOST]) {
				player.boost.boost.gotoAndStop(2);
				//Randomize flame size, const (150 here) is flame length
				player.boost.boost.jet._yscale = 150 + Math.random() * 60;
				debug_fuel -= stat_boost_economy[2];
				applyBoost(debug_boost_power);
			} else {
				player.boost.boost.gotoAndStop(1);
				if (debug_fuel <= 0) {
					debug_fuel = -1000;
				}
				clip(runBoost);
			}
			return;
		case 3 :
			//Pulsejet
			if (debug_fuel >= 0.1 && keydown_array[KEY_BOOST]) {
				player.boost.boost.gotoAndStop(2);
				player.boost.boost.jet._yscale = 300 + Math.random() * 60;
				debug_fuel -= stat_boost_economy[3];
				applyBoost(debug_boost_power);
			} else {
				player.boost.boost.gotoAndStop(1);
				if (debug_fuel <= 0) {
					debug_fuel = -1000;
				}
				clip(runBoost);
			}
			return;
		case 4 :
			//Ramjet
			if (debug_fuel >= 0.1 && keydown_array[KEY_BOOST]) {
				player.boost.boost.gotoAndStop(2);
				if (REF_speed <= 49) {
					player.boost.boost.jet._alpha = 25 + REF_speed;
					player.boost.boost.jet._yscale = 150 + 2 * REF_speed + Math.random() * 100;
					player.boost.boost.jet._xscale = 100 + Math.random() * 15;
					player.boost.boost.jet2._yscale = 300 + 2 * REF_speed + Math.random() * 100;
					player.boost.boost.jet2._xscale = 240 + Math.random() * 15;
					debug_fuel -= stat_boost_economy[4] * 0.6 + (0.4 * REF_speed / 50);
					applyBoost(debug_boost_power * 0.5 + (0.35 * REF_speed / 50));
				} else {
					player.boost.boost.jet._alpha = 100;
					player.boost.boost.jet._yscale = 300 + Math.random() * 150;
					player.boost.boost.jet._xscale = 140 + Math.random() * 15;
					player.boost.boost.jet2._yscale = 650 + Math.random() * 150;
					player.boost.boost.jet2._xscale = 340 + Math.random() * 15;
					debug_fuel -= stat_boost_economy[4];
					applyBoost(debug_boost_power);
				}
			} else {
				player.boost.boost.gotoAndStop(1);
				if (debug_fuel <= 0) {
					debug_fuel = -1000;
				}
				clip(runBoost);
			}
			return;
		case 5 :
			//Balloon
			//Once started, the balloon just deflates
			if (debug_fuel >= 0.1 && player.boost.boost._currentframe == 1 && keydown_array[KEY_BOOST]) {
				player.boost.boost.gotoAndStop(2);
				debug_fuel -= 0.1;
			} else if (debug_fuel <= 0.1) {
				player.boost.boost.gotoAndStop(400);
				debug_fuel = -1000;
				clip(runBoost);
			} else {
				player.boost.boost.gotoAndStop(Math.ceil(((debug_fuel_max - debug_fuel) / debug_fuel_max) * 399) + 1);
				player.boost.boost.jet._yscale = 250 + Math.random() * 40;
				player.boost.boost.jet._xscale = 90 + Math.random() * 10;
				player.boost.boost.jet._x = -50 - (debug_fuel / debug_fuel_max) * 30;
				player.boost.boost.jet._alpha = (debug_fuel / debug_fuel_max) * 30;
				debug_fuel -= stat_boost_economy[5];
				applyBoost(debug_boost_power);
			}
			return;
		case 6 :
			//Canned Air
			if (debug_fuel >= 0.1 && player.boost.boost._currentframe == 1 && keydown_array[KEY_BOOST]) {
				airCanPoint = new Point();
				airCanPoint.x = player.boost.boost.pin._x;
				airCanPoint.y = player.boost.boost.pin._y;
				player.boost.boost.localToGlobal(airCanPoint);
				generateParticle("player_boost6_pin",airCanPoint.x,airCanPoint.y,90,255,REF_direction - 90 + Math.random() * 180,REF_speed * 1.1,35 - Math.random() * 70,0.94,1,300,30);
				airCanPoint = null;
				player.boost.boost.gotoAndStop(2);
				player.boost.boost.jet._yscale = 360 + Math.random() * 100;
				player.boost.boost.jet._xscale = 170 + Math.random() * 8;
				debug_fuel -= stat_boost_economy[6];
				applyBoost(debug_boost_power);
			} else if (debug_fuel >= 0.1) {
				player.boost.boost.jet._yscale = 360 + Math.random() * 100;
				player.boost.boost.jet._xscale = 170 + Math.random() * 8;
				player.boost.boost.jet._alpha = 35 - Math.max(0, (((debug_fuel_max - debug_fuel) - debug_fuel_max * 0.65) / (debug_fuel * 0.65)) * 35);
				debug_fuel -= stat_boost_economy[6];
				applyBoost(debug_boost_power);
			} else {
				player.boost.boost.gotoAndStop(1);
				player.boost.boost.pin._visible = false;
				debug_fuel = -1000;
				clip(runBoost);
			}
			return;
		case 7 :
			//Big Bang
			//start anim
			if (debug_fuel >= 0.1 && player.boost.boost._currentframe == 1 && keydown_array[KEY_BOOST]) {
				player.boost.boost.gotoAndStop(2);
				//Until frame 85  \/
			} else if (player.boost.boost._currentframe <= 85) {
				player.boost.boost.gotoAndStop(player.boost.boost._currentframe + 1);
				//then rocket kicks in  \/
			} else if (debug_fuel >= 0.1) {
				player.boost.boost.jet._yscale = 500 + Math.random() * 100;
				player.boost.boost.jet._xscale = 85 + Math.random() * 8;
				debug_fuel -= stat_boost_economy[7];
				applyBoost(debug_boost_power);
			} else {
				//The firework should leave the payload and "explode" offscreen
				player.boost.boost.gotoAndStop(1);
				debug_fuel = -1000;
				clip(runBoost);
			}
			return;
		case 8 :
			//Cruise Missile
			//The cruise missile offers VERY LITTLE BOOST for the 25 first "fuel" points
			if (debug_fuel >= 0.1 && player.boost.boost._currentframe == 1 && keydown_array[KEY_BOOST]) {
				player.boost.boost.gotoAndStop(2);
				player.boost.boost.jet._alpha = 60;
				player.boost.boost.jet2._alpha = 0;
			} else if (debug_fuel_max - debug_fuel <= 25) {
				player.boost.boost.jet._yscale = 150 + (debug_fuel_max - debug_fuel) * 10 + Math.random() * 100;
				player.boost.boost.jet._xscale = 60 + Math.random() * 8;
				player.boost.boost.jet._alpha = 60 + (debug_fuel_max - debug_fuel) * 1.5;
				player.boost.boost.jet2._yscale = (debug_fuel_max - debug_fuel) * 22 + Math.random() * 100;
				player.boost.boost.jet2._xscale = (debug_fuel_max - debug_fuel) * 6 + Math.random() * 50;
				player.boost.boost.jet2._alpha = (debug_fuel_max - debug_fuel) * 3;
				//Hardcode -1 for the first 25 frames?
				//debug_fuel -= stat_boost_economy[8];
				debug_fuel -= 0.5;
				applyBoost(debug_boost_power * 0.3);
			} else if (debug_fuel >= 0.1) {
				player.boost.boost.jet._yscale = 500 + Math.random() * 100;
				player.boost.boost.jet._xscale = 60 + Math.random() * 8;
				player.boost.boost.jet2._yscale = 550 + Math.random() * 100;
				player.boost.boost.jet2._xscale = 160 + Math.random() * 50;
				debug_fuel -= stat_boost_economy[8];
				applyBoost(debug_boost_power);
			} else {
				//The missile should leave the payload and "explode" offscreen
				//Have a small chance that it won't leave and will explode?
				//Destroying the glider for that day?
				player.boost.boost.gotoAndStop(1);
				debug_fuel = -1000;
				clip(runBoost);
			}
			return;
		case 9 :
			//Whistle rockets
			if (debug_fuel_stage <= 4) {
				if (player.boost.boost._currentframe <= 4 && keydown_array[KEY_BOOST] && debug_fuel_stage <= 3) {
					debug_fuel_stage++;
					debug_fuel = debug_fuel_max;
					player.boost.boost.gotoAndStop(debug_fuel_stage + 5);
					player.boost.boost.jet._yscale = 180 + Math.random() * 100;
					player.boost.boost.jet._xscale = 80 + Math.random() * 8;
					debug_fuel -= stat_boost_economy[9];
					applyBoost(debug_boost_power);
				} else if (debug_fuel >= 0.1) {
					player.boost.boost.jet._yscale = 180 + Math.random() * 100;
					player.boost.boost.jet._xscale = 80 + Math.random() * 8;
					debug_fuel -= stat_boost_economy[9];
					applyBoost(debug_boost_power);
				} else {
					player.boost.boost.gotoAndStop(debug_fuel_stage + 1);
					if (debug_fuel_stage <= 3) {
						debug_fuel = debug_fuel_max;
					} else if (debug_fuel_stage >= 4) {
						debug_fuel_stage = 5;
					}
					clip(runBoost);
				}
			}
			return;
		case 10 :
			//Aux Boosters
			if (debug_fuel_stage <= 4) {
				if (player.boost.boost._currentframe <= 4 && keydown_array[KEY_BOOST] && debug_fuel_stage <= 3) {
					debug_fuel_stage++;
					debug_fuel = debug_fuel_max;
					player.boost.boost.gotoAndStop(debug_fuel_stage + 5);
					player.boost.boost.jet._yscale = 100 + Math.random() * 100;
					player.boost.boost.jet._xscale = 30 + Math.random() * 8;
					debug_fuel -= stat_boost_economy[10];
					applyBoost(debug_boost_power);
				} else if (debug_fuel >= 0.1) {
					player.boost.boost.jet._yscale = 400 + Math.random() * 100 - (debug_fuel / debug_fuel_max) * 300;
					player.boost.boost.jet._xscale = 30 + Math.random() * 8;
					debug_fuel -= stat_boost_economy[10];
					applyBoost(debug_boost_power);
				} else {
					player.boost.boost.gotoAndStop(debug_fuel_stage + 1);
					if (debug_fuel_stage <= 3) {
						debug_fuel = debug_fuel_max;
					} else if (debug_fuel_stage >= 4) {
						debug_fuel_stage = 5;
					}
					clip(runBoost);
				}
			}
			return;
		case 11 :
			//Lift Offs
			if (debug_fuel_stage <= 4) {
				if (player.boost.boost._currentframe <= 5 && keydown_array[KEY_BOOST] && debug_fuel_stage <= 3) {
					debug_fuel_stage++;
					debug_fuel = debug_fuel_max;
					player.boost.boost.gotoAndStop(debug_fuel_stage + 5);
					player.boost.boost.jet._yscale = 150 + Math.random() * 100;
					player.boost.boost.jet._xscale = 50 + Math.random() * 8;
					debug_fuel -= stat_boost_economy[11];
					applyBoost(debug_boost_power);
				} else if (debug_fuel >= 0.1) {
					player.boost.boost.jet._yscale = 450 + Math.random() * 100 - (debug_fuel / debug_fuel_max) * 300;
					player.boost.boost.jet._xscale = 50 + Math.random() * 8;
					debug_fuel -= stat_boost_economy[11];
					applyBoost(debug_boost_power);
				} else {
					liftOffPoint = new Point();
					liftOffPoint.x = player.boost.boost["part" + debug_fuel_stage]._x;
					liftOffPoint.y = player.boost.boost["part" + debug_fuel_stage]._y;
					player.boost.boost.localToGlobal(liftOffPoint);
					generateParticle("player_boost11_part" + debug_fuel_stage,liftOffPoint.x,liftOffPoint.y,155,255,REF_direction,REF_speed,15 - Math.random() * 30,0.94,1,300,30);
					liftOffPoint = null;
					player.boost.boost.gotoAndStop(debug_fuel_stage + 1);
					if (debug_fuel_stage <= 3) {
						debug_fuel = debug_fuel_max;
					} else if (debug_fuel_stage >= 4) {
						debug_fuel_stage = 5;
					}
					clip(runBoost);
				}
			}
			return;
		case 12 :
			//omega ramjet
			//Ramjet is special in the fact that it has reduces power at lower speed
			//Not yet applied, TODO - 
			if (debug_fuel >= 0.1 && keydown_array[KEY_BOOST]) {
				player.boost.boost.gotoAndStop(2);
				if (REF_speed <= 49) {
					player.boost.boost.jet._alpha = 25 + REF_speed;
					player.boost.boost.jet._yscale = 150 + 2 * REF_speed + Math.random() * 100;
					player.boost.boost.jet._xscale = 100 + Math.random() * 15;
					player.boost.boost.jet2._yscale = 300 + 2 * REF_speed + Math.random() * 100;
					player.boost.boost.jet2._xscale = 240 + Math.random() * 15;
					debug_fuel -= stat_boost_economy[4] * 0.6 + (0.4 * REF_speed / 50);
					applyBoost(debug_boost_power * 0.5 + (0.35 * REF_speed / 50));
				} else {
					player.boost.boost.jet._alpha = 100;
					player.boost.boost.jet._yscale = 400 + Math.random() * 250;
					player.boost.boost.jet._xscale = 170 + Math.random() * 25;
					player.boost.boost.jet2._yscale = 850 + Math.random() * 300;
					player.boost.boost.jet2._xscale = 440 + Math.random() * 25;
					debug_fuel -= stat_boost_economy[12];
					applyBoost(debug_boost_power);
				}
			} else {
				player.boost.boost.gotoAndStop(1);
				if (debug_fuel <= 0) {
					debug_fuel = -1000;
				}
				clip(runBoost);
			}
			return;
		case 13 :
			//Omega Balloon
			//Once started, the balloon just deflates
			if (debug_fuel >= 0.1 && player.boost.boost._currentframe == 1 && keydown_array[KEY_BOOST]) {
				player.boost.boost.gotoAndStop(2);
				debug_fuel -= 0.1;
			} else if (debug_fuel <= 0.1) {
				player.boost.boost.gotoAndStop(400);
				debug_fuel = -1000;
				clip(runBoost);
			} else {
				player.boost.boost.gotoAndStop(Math.ceil(((debug_fuel_max - debug_fuel) / debug_fuel_max) * 399) + 1);
				player.boost.boost.jet._yscale = 450 + Math.random() * 60;
				player.boost.boost.jet._xscale = 110 + Math.random() * 15;
				player.boost.boost.jet._x = -50 - (debug_fuel / debug_fuel_max) * 30;
				player.boost.boost.jet._alpha = (debug_fuel / debug_fuel_max) * 60;
				debug_fuel -= stat_boost_economy[13];
				applyBoost(debug_boost_power);
			}
			return;
		case 14 :
			//Omega thrusters
			if (debug_fuel_stage <= 4) {
				if (player.boost.boost._currentframe <= 4 && keydown_array[KEY_BOOST] && debug_fuel_stage <= 3) {
					debug_fuel_stage++;
					debug_fuel = debug_fuel_max;
					player.boost.boost.gotoAndStop(debug_fuel_stage + 5);
					player.boost.boost.jet._yscale = 150 + Math.random() * 100;
					player.boost.boost.jet._xscale = 30 + Math.random() * 8;
					debug_fuel -= stat_boost_economy[10];
					applyBoost(debug_boost_power);
				} else if (debug_fuel >= 0.1) {
					player.boost.boost.jet._yscale = 600 + Math.random() * 200 - (debug_fuel / debug_fuel_max) * 600;
					player.boost.boost.jet._xscale = 65 + Math.random() * 25;
					debug_fuel -= stat_boost_economy[14];
					applyBoost(debug_boost_power);
				} else {
					player.boost.boost.gotoAndStop(debug_fuel_stage + 1);
					if (debug_fuel_stage <= 3) {
						debug_fuel = debug_fuel_max;
					} else if (debug_fuel_stage >= 4) {
						debug_fuel_stage = 5;
					}
					clip(runBoost);
				}
			}
			return;
	}
};


//applyBoost modifies glide_vx/vy with booster stats
applyBoost = function (power, buffMult) {
	//power is the thrust applied
	//buffMult changes the amount of buffer applied to reduce climbing with boosts
	if (buffMult == undefined || buffMult == null) {
		buffMult = 1;
	}
	//boostBuff limit the boost power when going straight up                       
	boostBuff = Math.min(1, Math.abs(-90 - player._rotation) / 90 * 0.15 + 0.85);
	glide_vx += Math.cos(player._rotation * rads) * power * boostBuff;
	glide_vy += Math.sin(player._rotation * rads) * power * boostBuff;
};

// ---- layer "Landscape", frame 11
//debug
debug_ramp_height = _root.test_upg_height[_root.test_player_height]+_root.test_player_length*_root.test_player_length*5;//height of ramp_jump above ground level


//CONFIG
GROUND_MAX_FRAME = 47;//# of frames to select from in ground/ground_over mc
if(GAME_MODE!="classic"){
	SEA_DISTANCE = 1200;//Distance at which ends the land and begins the sea
}else{
	SEA_DISTANCE = 500;//Distance at which ends the land and begins the sea
}
//SEA_DISTANCE = 12;//Distance at which ends the land and begins the sea
GROUND_BEHIND_SPEED = 0.25;//Speed at which the ground back layer moves
GROUND_BEHIND_SETBACK = 240;//Amount of feets the ground behind stops before the ground over, because it moves more slowly
RUNGROUND_MAX_LOOP = 3;//Maximum attempts at moving the grounds mc
SEA_Y_OFFSET = 60;//Distance of the ground above sea level


//Setupground sets the ground mcs AND the sea mcs
setupGround = function () {
	for (i=1; i<=4; i++) {
		ground_holder.attachMovie("ground","ground"+i,ground_holder.getNextHighestDepth());
		ground_holder["ground"+i]._x = -500+i*500;
		ground_holder["ground"+i]._y = ramp._y+debug_ramp_height;
		ground_holder["ground"+i].gotoAndStop(Math.max(1, Math.ceil(Math.random()*GROUND_MAX_FRAME)));
		pushCam(ground_holder["ground"+i],GROUND_BEHIND_SPEED);
		ground_over_holder.attachMovie("ground_over","ground"+i,ground_over_holder.getNextHighestDepth());
		ground_over_holder["ground"+i]._x = -500+i*500;
		ground_over_holder["ground"+i]._y = ramp._y+debug_ramp_height;
		ground_over_holder["ground"+i].gotoAndStop(Math.max(1, Math.ceil(Math.random()*GROUND_MAX_FRAME)));
		pushCam(ground_over_holder["ground"+i],1);
	}
	for (i=1; i<=3; i++) {
		sea_holder.attachMovie("sea_mc","ground"+i,sea_holder.getNextHighestDepth());
		sea_holder["ground"+i]._x = -800+i*800;
		sea_holder["ground"+i]._y = ramp._y+debug_ramp_height+SEA_Y_OFFSET;
		pushCam(sea_holder["ground"+i]);
	}
	ground_holder.attachMovie("ground_behind_end","ground_end",ground_holder.getNextHighestDepth());
	ground_holder.ground_end._x = -500+i*500;
	ground_holder.ground_end._y = ramp._y+debug_ramp_height;
	pushCam(ground_holder.ground_end,GROUND_BEHIND_SPEED);
	ground_over_holder.attachMovie("ground_end","ground_end",ground_over_holder.getNextHighestDepth());
	ground_over_holder.ground_end._x = -500+i*500;
	ground_over_holder.ground_end._y = ramp._y+debug_ramp_height;
	pushCam(ground_over_holder.ground_end,1);
};

runGround = function () {
	//Adjust ground behind _y for 3D effect
	for (i=1; i<=4; i++) {
		ground_holder["ground"+i]._y = ground_over_holder.ground1._y-(REF_altitude+3)*6;
		ground_holder.ground_end._y = ground_over_holder.ground1._y-(REF_altitude+3)*6;
	}
	//Ground wrapping
	runGround_count = 0;
	do {
		runGround_check = false;
		for (i=1; i<=4; i++) {
			//Behind ground layer
			if (ground_holder["ground"+i]._x<=-1000.1) {
				//In the back layer, the "SEA_DISTANCE-500" is used to prevent it from going past the ground layer, since it moves more slowly
				if (Math.abs((ramp._x+hotspot.hotspot3._x+hotspot.hotspot3._width-ground_holder["ground"+i]._x)/FOOT_RATIO)<=SEA_DISTANCE-GROUND_BEHIND_SETBACK) {
					runGround_check = true;
					runGround_count++;
					ground_holder["ground"+i]._x = getRightGround()+500;
					ground_holder["ground"+i].gotoAndStop(Math.max(1, Math.ceil(Math.random()*GROUND_MAX_FRAME)));
					ground_holder.ground_end._x = ground_holder["ground"+i]._x+ground_holder["ground"+i]._width;
				}
			} else if (ground_holder["ground"+i]._x>=1000.1) {
				runGround_check = true;
				runGround_count++;
				ground_holder["ground"+i]._x = getLeftGround()-500;
				ground_holder["ground"+i].gotoAndStop(Math.max(1, Math.ceil(Math.random()*GROUND_MAX_FRAME)));
			}
			//"ground_over" layer                             
			if (ground_over_holder["ground"+i]._x<=-1000.1) {
				if (Math.abs((ramp._x+hotspot.hotspot3._x+hotspot.hotspot3._width-ground_over_holder["ground"+i]._x)/FOOT_RATIO)<=SEA_DISTANCE) {
					runGround_check = true;
					runGround_count++;
					ground_over_holder["ground"+i]._x = getRightGroundOver()+500;
					ground_over_holder["ground"+i].gotoAndStop(Math.max(1, Math.ceil(Math.random()*GROUND_MAX_FRAME)));
					ground_over_holder.ground_end._x = ground_over_holder["ground"+i]._x+ground_over_holder["ground"+i]._width;
				}
			} else if (ground_over_holder["ground"+i]._x>=1000.1) {
				runGround_check = true;
				runGround_count++;
				ground_over_holder["ground"+i]._x = getLeftGroundOver()-500;
				ground_over_holder["ground"+i].gotoAndStop(Math.max(1, Math.ceil(Math.random()*GROUND_MAX_FRAME)));
			}
		}
		if (runGround_count>=RUNGROUND_MAX_LOOP) {
			break;
			//return instead
		}
	} while (runGround_check == true);
	//
	//Sea wrapping
	runGround_count = 0;
	do {
		runGround_check = false;
		for (i=1; i<=3; i++) {
			//Behind ground layer
			if (sea_holder["ground"+i]._x<=-1000.1) {
				runGround_check = true;
				runGround_count++;
				sea_holder["ground"+i]._x = getRightSea()+800;
				sea_holder.ground_end._x = sea_holder["ground"+i]._x+sea_holder["ground"+i]._width;
			} else if (sea_holder["ground"+i]._x>=1000.1) {
				runGround_check = true;
				runGround_count++;
				sea_holder["ground"+i]._x = getLeftSea()-800;
				sea_holder["ground"+i].gotoAndStop(Math.max(1, Math.ceil(Math.random()*GROUND_MAX_FRAME)));
			}
		}
		if (runGround_count>=RUNGROUND_MAX_LOOP) {
			return;
		}
	} while (runGround_check == true);
};

//getLeft/Right functions returns the rightmost/leftmost ._x coordinates of ground mc
getRightGround = function () {
	tempMax = -100000;
	for (l=1; l<=4; l++) {
		if (tempMax<=ground_holder["ground"+l]._x) {
			tempMax = ground_holder["ground"+l]._x;
		}
	}
	return tempMax;
};
getLeftGround = function () {
	tempMax = 100000;
	for (l=1; l<=4; l++) {
		if (tempMax>=ground_holder["ground"+l]._x) {
			tempMax = ground_holder["ground"+l]._x;
		}
	}
	return tempMax;
};
getRightGroundOver = function () {
	tempMax = -100000;
	for (l=1; l<=4; l++) {
		if (tempMax<=ground_over_holder["ground"+l]._x) {
			tempMax = ground_over_holder["ground"+l]._x;
		}
	}
	return tempMax;
};
getLeftGroundOver = function () {
	tempMax = 100000;
	for (l=1; l<=4; l++) {
		if (tempMax>=ground_over_holder["ground"+l]._x) {
			tempMax = ground_over_holder["ground"+l]._x;
		}
	}
	return tempMax;
};
getRightSea = function () {
	tempMax = -100000;
	for (l=1; l<=3; l++) {
		if (tempMax<=sea_holder["ground"+l]._x) {
			tempMax = sea_holder["ground"+l]._x;
		}
	}
	return tempMax;
};
getLeftSea = function () {
	tempMax = 100000;
	for (l=1; l<=3; l++) {
		if (tempMax>=sea_holder["ground"+l]._x) {
			tempMax = sea_holder["ground"+l]._x;
		}
	}
	return tempMax;
};

setupGround();
push(runGround);

// ---- layer "Collision API", frame 11
import flash.display.*;
import flash.geom.*;

function checkForCollision(p_clip1:MovieClip, p_clip2:MovieClip, p_alphaTolerance:Number):Boolean {
	// set up default params:
	//if (p_alphaTolerance == undefined) {
	p_alphaTolerance = 255;
	//}
	// get bounds:                                                                     
	var bounds1:Object = p_clip1.getBounds(_root);
	var bounds2:Object = p_clip2.getBounds(_root);

	// rule out anything that we know can't collide:
	if (((bounds1.xMax<bounds2.xMin) || (bounds2.xMax<bounds1.xMin)) || ((bounds1.yMax<bounds2.yMin) || (bounds2.yMax<bounds1.yMin))) {
		return null;
	}
	// determine test area boundaries:                                                                             
	var bounds:Object = {};
	bounds.xMin = Math.max(bounds1.xMin, bounds2.xMin);
	bounds.xMax = Math.min(bounds1.xMax, bounds2.xMax);
	bounds.yMin = Math.max(bounds1.yMin, bounds2.yMin);
	bounds.yMax = Math.min(bounds1.yMax, bounds2.yMax);

	// set up the image to use:
	var img:BitmapData = new BitmapData(bounds.xMax-bounds.xMin, bounds.yMax-bounds.yMin, true, 0x00000000);
	//_root.attachBitmap(img,_root.getNextHighestDepth());

	// draw in the first image:
	mat = p_clip1.transform.matrix;
	matParent = p_clip1._parent.transform.matrix;
	mat.concat(matParent);
	trace(mat);
	trace(p_clip1.transform.concatenatedMatrix)
	mat.tx -= bounds.xMin;
	mat.ty -= bounds.yMin;
	img.draw(p_clip1,mat,new ColorTransform(1, 1, 1, 1, 255, -255, -255, p_alphaTolerance));

	// overlay the second image:
	mat = p_clip2.transform.matrix;
	matParent = p_clip2._parent.transform.matrix;
	mat.concat(matParent);
	trace(mat);
	trace(p_clip2.transform.concatenatedMatrix)
	mat.tx -= bounds.xMin;
	mat.ty -= bounds.yMin;
	img.draw(p_clip2,mat,new ColorTransform(1, 1, 1, 1, 255, 255, 255, p_alphaTolerance),"difference");

	// find the intersection:
	var intersection:Rectangle = img.getColorBoundsRect(0xFFFFFFFF, 0xFF00FFFF);
	// if there is no intersection, return null:
	if (intersection.width == 0) {
		return false;
	}
	postConsole("checkForCollision returns TRUE");
	return true;
}

function checkForSide(p_clip1:MovieClip, p_clip2:MovieClip, p_alphaTolerance:Number) {

	// set up default params:
	if (p_alphaTolerance == undefined) {
		p_alphaTolerance = 255;
	}
	// get bounds:                        
	var bounds1:Object = p_clip1.getBounds(_root);
	var bounds2:Object = p_clip2.getBounds(_root);

	// rule out anything that we know can't collide:
	if (((bounds1.xMax<bounds2.xMin) || (bounds2.xMax<bounds1.xMin)) || ((bounds1.yMax<bounds2.yMin) || (bounds2.yMax<bounds1.yMin))) {
		return null;
	}
	// determine test area boundaries:                        
	var bounds:Object = {};
	bounds.xMin = Math.max(bounds1.xMin, bounds2.xMin);
	bounds.xMax = Math.min(bounds1.xMax, bounds2.xMax);
	bounds.yMin = Math.max(bounds1.yMin, bounds2.yMin);
	bounds.yMax = Math.min(bounds1.yMax, bounds2.yMax);

	// set up the image to use:
	var img:BitmapData = new BitmapData(bounds.xMax-bounds.xMin, bounds.yMax-bounds.yMin, false);

	// draw in the first image:
	var mat:Matrix = p_clip1.transform.matrix;
	mat.tx -= bounds.xMin;
	mat.ty -= bounds.yMin;
	img.draw(p_clip1,mat,new ColorTransform(1, 1, 1, 1, 255, -255, -255, p_alphaTolerance));

	// overlay the second image:
	mat = p_clip2.transform.matrix;
	mat.tx -= bounds.xMin;
	mat.ty -= bounds.yMin;
	img.draw(p_clip2,mat,new ColorTransform(1, 1, 1, 1, 255, 255, 255, p_alphaTolerance),"difference");

	// find the intersection:
	var intersection:Rectangle = img.getColorBoundsRect(0xFFFFFFFF, 0xFF00FFFF);

	// if there is no intersection, return null:
	if (intersection.width == 0) {
		return null;
	}
	// adjust the intersection to account for the bounds:                        
	intersection.x += bounds.xMin;
	intersection.y += bounds.yMin;

	return intersection.width;
}

function checkForTop(p_clip1:MovieClip, p_clip2:MovieClip, p_alphaTolerance:Number) {

	// set up default params:
	//if (p_alphaTolerance == undefined) {
	p_alphaTolerance = 255;
	//}
	// get bounds:                
	var bounds1:Object = p_clip1.getBounds(_root);
	var bounds2:Object = p_clip2.getBounds(_root);

	// rule out anything that we know can't collide:
	if (((bounds1.xMax<bounds2.xMin) || (bounds2.xMax<bounds1.xMin)) || ((bounds1.yMax<bounds2.yMin) || (bounds2.yMax<bounds1.yMin))) {
		return null;
	}
	// determine test area boundaries:                        
	var bounds:Object = {};
	bounds.xMin = Math.max(bounds1.xMin, bounds2.xMin);
	bounds.xMax = Math.min(bounds1.xMax, bounds2.xMax);
	bounds.yMin = Math.max(bounds1.yMin, bounds2.yMin);
	bounds.yMax = Math.min(bounds1.yMax, bounds2.yMax);

	// set up the image to use:
	var img:BitmapData = new BitmapData(bounds.xMax-bounds.xMin, bounds.yMax-bounds.yMin, false);

	// draw in the first image:
	var mat:Matrix = p_clip1.transform.matrix;
	mat.tx -= bounds.xMin;
	mat.ty -= bounds.yMin;
	img.draw(p_clip1,mat,new ColorTransform(1, 1, 1, 1, 255, -255, -255, p_alphaTolerance));

	// overlay the second image:
	mat = p_clip2.transform.matrix;
	mat.tx -= bounds.xMin;
	mat.ty -= bounds.yMin;
	img.draw(p_clip2,mat,new ColorTransform(1, 1, 1, 1, 255, 255, 255, p_alphaTolerance),"difference");

	// find the intersection:
	var intersection:Rectangle = img.getColorBoundsRect(0xFFFFFFFF, 0xFF00FFFF);

	// if there is no intersection, return null:
	if (intersection.width == 0) {
		return null;
	}
	// adjust the intersection to account for the bounds:                        
	intersection.x += bounds.xMin;
	intersection.y += bounds.yMin;

	return intersection.top;
}

// ---- layer "Obstacles", frame 11
//Obstacles stats--------------------------------------------
OBSTACLE_DISTANCE = new Array(0, 90, 400, 1000, 2200, 4500);//Distance from origin point, in feets, not in pixels!
//OBSTACLE_DISTANCE = new Array(0, 100, 400, 1000, 2500, 6000);//Distance from origin point, in feets, not in pixels!
//BONUS - reduced health for each obstacle
OBSTACLE_HEALTH = new Array(0, 60 * (1 - 0.15 * bonusItemOwn[4]), 250 * (1 - 0.15 * bonusItemOwn[4]), 750 * (1 - 0.15 * bonusItemOwn[4]), 2000 * (1 - 0.15 * bonusItemOwn[4]), 7000 * (1 - 0.15 * bonusItemOwn[4]));//Amount of damage that each obstacle can take
OBSTACLE_BOUNTY = new Array(0, 40, 150, 1000, 2500, 10000);//Points earned by destroying obstacles
OBSTACLE_BOUNTY_UNDER = 0.45;//Mult of bounty earned when obstacle is NOT destroyed but damaged
OBSTACLE_BOUNTY_OVER = 1.25;//Mult of bounty when obstacle is overkilled
PARTICLES_LIFE = 350;//Number of frames particles (such as snow parts) appear before fading out

AFTER_COLLISION_TIMEOUT = 45;//# of frames to wait when player is stuck inside obstacle

for (i = 0; i <= 5; i++) {
	if (obstacle_health_left[i] <= 0) {
		obstacle_health_left[i] = OBSTACLE_HEALTH[i];
	}
}

obstacle_startofday_health = obstacle_health_left;

obstacleDestroyedToday = 0;
obstacleDestroyed = new Array(0, 0, 0, 0, 0);
if (pacifistDays == undefined) {
	pacifistDays = -1;
}

playerHitPower = _root.stat_payload_power[playerPayload];//Power of payload's weight
playerExplosivePower = _root.stat_payload_boom[playerPayload];//Power of explosives
playerExplosiveOut = _root.stat_payload_boom_out[playerPayload];//Frames to wait before fading out after exploding

//Setting obstacles...
if (GAME_MODE == "story") {
	for (i = 1; i <= 5; i++) {
		ground_over_holder.attachMovie("obstacle" + i,"obstacle" + i,ground_over_holder.getNextHighestDepth());
		ground_over_holder["obstacle" + i].gotoAndStop("idle");
		ground_over_holder["obstacle" + i]._y = ground_over_holder.ground1._y;
		ground_over_holder["obstacle" + i]._x = OBSTACLE_DISTANCE[i] * FOOT_RATIO + ramp._x + hotspot.hotspot3._x + hotspot.hotspot3._width;
		ground_over_holder["obstacle" + i].hitspot1._visible = false;
		ground_over_holder["obstacle" + i].hitspot2._visible = false;
		pushCam(ground_over_holder["obstacle" + i],1);
	}
}

checkCollideTarget = function () {
	if (GAME_MODE <> "story") {
		return;
	}
	collide_distance = Math.abs(player._x - ground_over_holder.obstacle1._x);
	collide_target = 1;
	for (i = 2; i <= 5; i++) {
		if (Math.abs(player._x - ground_over_holder["obstacle" + i]._x) <= collide_distance) {
			collide_distance = Math.abs(player._x - ground_over_holder["obstacle" + i]._x);
			collide_target = i;
		}
	}
	runCollide(collide_target);
};

//runCollide is not the detonation of explosives
//its the test for collision on(data=target)
runCollide = function (data) {
	if (REF_direction >= 1 && (data == 1 || data == 2 || data == 3)) {
		//targeting one of the ground obstacles
		REF_direction *= -1;
	}
	hit_power = REF_speed * playerHitPower;
	hit_ratio = Math.min(hit_power / OBSTACLE_HEALTH[data], 6);
	hit_speedLoss = 0.98 - (0.5 * (Math.max(0, 4 - (hit_ratio - 1))) / 4);
	switch (data) {
		case 1 :
			//-----------------------------------------------------------------
			//Snowman
			//if player hits the snowman's body
			if (checkForCollision(player.hitspot, ground_over_holder["obstacle" + data].hitspot1)) {
				postConsole("runCollide into #1");
				pacifistDays = -1;
				obstacle_health_left[data] -= hit_power;
				damageMeterSet(data);
				if (obstacle_health_left[data] <= 0) {
					postConsole("runCollide killed #1");
					//Enough power, snowman is dead
					destroyObstacle(data);
					flashmc.gotoAndPlay("p1");
					glide_vx *= hit_speedLoss;
					glide_vy *= hit_speedLoss;
				} else {
					postConsole("runCollide #1 001");
					//Else if player missed the snowman BUT touched its hat
					if (checkForCollision(player.hitspot, ground_over_holder["obstacle" + data].hitspot2)) {
						generateParticle("snowman_hat",ground_over_holder["obstacle" + data]._x,ground_over_holder["obstacle" + data]._y - 40,ground_over_holder["obstacle" + data]._xscale,100,REF_direction - 20 + 40 * Math.random(),Math.random() * 40 * hit_ratio + (40 * hit_ratio - 1),-Math.random() * 16 - 8,0.9,0.4,500,10);
						ground_over_holder["obstacle" + data].gotoAndStop(2);
					}
					postConsole("runCollide #1 002");
					//If not enough power                                                                                                                                                                                             
					if (collideCount <= 0) {
						if (glide_vx >= 0) {
							player._x = ground_over_holder["obstacle" + data]._x - player._width / 2 + 30;
						} else {
							player._x = ground_over_holder["obstacle" + data]._x + player._width / 2 - 30;
						}
						postConsole("runCollide #1 003");
						freezePlayer();
						snowBoom(ground_over_holder["obstacle" + data]._x,player._y,15,1.3,30,1,REF_direction - 90);
						postConsole("runCollide #1 004");
						for (k = 0; k <= 8; k++) {
							generateParticle("snow_part",ground_over_holder["obstacle" + data]._x,player._y,10 + Math.random() * 30,50 + 50 * Math.random(),(REF_direction - 180) - 40 + Math.random() * 80,Math.random() * 10,-5 + Math.random() * 10,0.99,0.4,300,10);
						}
						postConsole("runCollide #1 005");
						if (hasExplosive()) {
							postConsole("runCollide #1 006");
							//start timer and boom
							push(delayedBoom);
							explodingOnTarget = data;
						} else {
							postConsole("runCollide #1 007");
							//Destruction points for damage
							REF_destruction += OBSTACLE_BOUNTY[data] * OBSTACLE_BOUNTY_UNDER * hit_ratio;
							//timer for dayResults
							setTimerOut(AFTER_COLLISION_TIMEOUT);
						}
					}
				}
				postConsole("runCollide #1 OUT");
			}
			return;
		case 2 :
			//-----------------------------------------------------------------
			//Snowpile
			if (checkForCollision(player.hitspot, ground_over_holder["obstacle" + data].hitspot1)) {
				postConsole("runCollide into #2");
				pacifistDays = -1;
				obstacle_health_left[data] -= hit_power;
				damageMeterSet(data);
				if (obstacle_health_left[data] <= 0) {
					postConsole("runCollide killed #2");
					//Enough power, snowman is dead
					destroyObstacle(data);
					flashmc.gotoAndPlay("p1");
					glide_vx *= hit_speedLoss;
					glide_vy *= hit_speedLoss;
				} else {
					postConsole("runCollide #2 001");
					//If not enough power                                  
					if (collideCount <= 0) {
						if (REF_oldx <= ground_over_holder["obstacle" + data]._x) {
							//player is ramming obstacle from the left
							player._x = getX(ground_over_holder["obstacle" + data], "left", player._y);
						} else {
							//player is ramming obstacle from the right
							player._x = getX(ground_over_holder["obstacle" + data], "right", player._y);
						}
						postConsole("runCollide #2 002");
						freezePlayer();
						snowBoom(ground_over_holder["obstacle" + data]._x,player._y,15 + glide_vmag / 5,1.3,30,1,REF_direction - 90);
						postConsole("runCollide #2 003");
						for (k = 0; k <= 8 + glide_vmag / 20; k++) {
							generateParticle("snow_part",player._x + Math.random() * 30 - 15,player._y + Math.random() * 30 - 15,10 + Math.random() * 30,50 + 50 * Math.random(),(REF_direction - 180) - 40 + Math.random() * 80,Math.random() * 10,-5 + Math.random() * 10,0.99,0.4,300,10);
						}
						postConsole("runCollide #2 004");
						if (hasExplosive()) {
							postConsole("runCollide #2 005");
							//start timer and boom
							push(delayedBoom);
							explodingOnTarget = data;
						} else {
							postConsole("runCollide #2 006");
							//Destruction points for damage
							REF_destruction += OBSTACLE_BOUNTY[data] * OBSTACLE_BOUNTY_UNDER * hit_ratio;
							//timer for dayResults
							setTimerOut(AFTER_COLLISION_TIMEOUT);
						}
					}
					postConsole("runCollide #2 OUT");
				}
				return;
			}
		case 3 :
			//-----------------------------------------------------------------
			//Snow hill
			if (checkForCollision(player.hitspot, ground_over_holder["obstacle" + data].hitspot1)) {
				postConsole("runCollide into #3");
				pacifistDays = -1;
				obstacle_health_left[data] -= hit_power;
				damageMeterSet(data);
				if (obstacle_health_left[data] <= 0) {
					postConsole("runCollide killed #3");
					//Enough power, snowman is dead
					destroyObstacle(data);
					flashmc.gotoAndPlay("p2");
					glide_vx *= hit_speedLoss;
					glide_vy *= hit_speedLoss;
				} else {
					postConsole("runCollide #3 001");
					//If not enough power                                  
					if (collideCount <= 0) {
						if (REF_oldx <= ground_over_holder["obstacle" + data]._x) {
							//player is ramming obstacle from the left
							player._x = getX(ground_over_holder["obstacle" + data], "left", player._y);
						} else {
							//player is ramming obstacle from the right
							player._x = getX(ground_over_holder["obstacle" + data], "right", player._y);
						}
						postConsole("runCollide #3 002");
						freezePlayer();
						if (ground_over_holder["obstacle" + data]._y - player._y >= 290) {
							postConsole("runCollide #3 003");
							//player is hitting the snow
							snowBoom(ground_over_holder["obstacle" + data]._x,player._y,15 + glide_vmag / 5,1.3,30,1,REF_direction - 90);
							for (k = 0; k <= 8 + glide_vmag / 20; k++) {
								generateParticle("snow_part",player._x + Math.random() * 30 - 15,player._y + Math.random() * 30 - 15,10 + Math.random() * 30,50 + 50 * Math.random(),(REF_direction - 180) - 40 + Math.random() * 80,Math.random() * 10,-5 + Math.random() * 10,0.99,0.4,300,10);
							}
						} else {
							postConsole("runCollide #3 004");
							//player is hitting the bottom "rock" part
							snowBoom(ground_over_holder["obstacle" + data]._x,player._y,15 + glide_vmag / 5,1.3,30,1,REF_direction - 90);
							for (k = 0; k <= 6 + glide_vmag / 14; k++) {
								generateParticle("rock_part",player._x + Math.random() * 30 - 15,player._y + Math.random() * 30 - 15,10 + Math.random() * 60,50 + 50 * Math.random(),(REF_direction - 180) - 40 + Math.random() * 80,Math.random() * 10,-5 + Math.random() * 10,0.99,0.4,300,10);
							}
						}
						if (hasExplosive()) {
							postConsole("runCollide #3 005");
							//start timer and boom
							push(delayedBoom);
							explodingOnTarget = data;
						} else {
							postConsole("runCollide #3 006");
							//Destruction points for damage
							REF_destruction += OBSTACLE_BOUNTY[data] * OBSTACLE_BOUNTY_UNDER * hit_ratio;
							//timer for dayResults
							setTimerOut(AFTER_COLLISION_TIMEOUT);
						}
					}
				}
				postConsole("runCollide #3 OUT");
			}
			return;
		case 4 :
			//-----------------------------------------------------------------
			//Iceberg
			if (checkForCollision(player.hitspot, ground_over_holder["obstacle" + data].hitspot1)) {
				postConsole("runCollide into #4");
				pacifistDays = -1;
				obstacle_health_left[data] -= hit_power;
				damageMeterSet(data);
				if (obstacle_health_left[data] <= 0) {
					postConsole("runCollide killed #4");
					//Enough power, snowman is dead
					destroyObstacle(data);
					flashmc.gotoAndPlay("p3");
					glide_vx *= hit_speedLoss;
					glide_vy *= hit_speedLoss;
				} else {
					postConsole("runCollide #4 001");
					//If not enough power                                  
					if (collideCount <= 0) {
						if (REF_oldx <= ground_over_holder["obstacle" + data]._x) {
							//player is ramming obstacle from the left
							player._x = getX(ground_over_holder["obstacle" + data], "left", player._y);
						} else {
							//player is ramming obstacle from the right
							player._x = getX(ground_over_holder["obstacle" + data], "right", player._y);
						}
						postConsole("runCollide #4 002");
						freezePlayer();
						//player is hitting the snow
						snowBoom(ground_over_holder["obstacle" + data]._x,player._y,15 + glide_vmag / 5,1.3,30,1,REF_direction - 90);
						postConsole("runCollide #4 003");
						for (k = 0; k <= 8 + glide_vmag / 20; k++) {
							generateParticle("snow_part",player._x + Math.random() * 30 - 15,player._y + Math.random() * 30 - 15,10 + Math.random() * 30,50 + 50 * Math.random(),(REF_direction - 180) - 40 + Math.random() * 80,Math.random() * 10,-5 + Math.random() * 10,0.99,0.4,300,10);
						}
						if (hasExplosive()) {
							postConsole("runCollide #4 004");
							//start timer and boom
							push(delayedBoom);
							explodingOnTarget = data;
						} else {
							postConsole("runCollide #4 005");
							//Destruction points for damage
							REF_destruction += OBSTACLE_BOUNTY[data] * OBSTACLE_BOUNTY_UNDER * hit_ratio;
							//timer for dayResults
							setTimerOut(AFTER_COLLISION_TIMEOUT);
						}
					}
				}
				postConsole("runCollide #4 OUT");
			}
			return;
		case 5 :
			//-----------------------------------------------------------------
			//The Wall
			if (checkForCollision(player.hitspot, ground_over_holder["obstacle" + data].hitspot1)) {
				postConsole("runCollide into #5");
				pacifistDays = -1;
				obstacle_health_left[data] -= hit_power;
				damageMeterSet(data);
				if (obstacle_health_left[data] <= 0) {
					postConsole("runCollide killed #5");
					//Enough power, obstacle is dead
					destroyObstacle(data);
					flashmc.gotoAndPlay("p4");
					glide_vx *= hit_speedLoss;
					glide_vy *= hit_speedLoss;
				} else {
					postConsole("runCollide #5 001");
					//If not enough power                                  
					if (collideCount <= 0) {
						if (REF_oldx <= ground_over_holder["obstacle" + data]._x) {
							//player is ramming obstacle from the left
							player._x = getX(ground_over_holder["obstacle" + data], "left", player._y);
						} else {
							//player is ramming obstacle from the right
							player._x = getX(ground_over_holder["obstacle" + data], "right", player._y);
						}
						postConsole("runCollide #5 002");
						freezePlayer();
						//player is hitting the snow
						snowBoom(ground_over_holder["obstacle" + data]._x,player._y,15 + glide_vmag / 5,1.3,30,1,REF_direction - 90);
						postConsole("runCollide #5 003");
						for (k = 0; k <= 8 + glide_vmag / 20; k++) {
							generateParticle("snow_part",player._x + Math.random() * 30 - 15,player._y + Math.random() * 30 - 15,10 + Math.random() * 30,50 + 50 * Math.random(),(REF_direction - 180) - 40 + Math.random() * 80,Math.random() * 10,-5 + Math.random() * 10,0.99,0.4,300,10);
						}
						if (hasExplosive()) {
							postConsole("runCollide #5 004");
							//start timer and boom
							push(delayedBoom);
							explodingOnTarget = data;
						} else {
							postConsole("runCollide #5 005");
							//Destruction points for damage
							REF_destruction += OBSTACLE_BOUNTY[data] * OBSTACLE_BOUNTY_UNDER * hit_ratio;
							//timer for dayResults
							setTimerOut(AFTER_COLLISION_TIMEOUT);
						}
					}
				}
				postConsole("runCollide #5 OUT");
			}
			return;
	}
};

//Death event of every obstacles
destroyObstacle = function (data, boom) {
	if (playerGlider == 14) {
		triggerMedal(36);
	}
	postConsole("destroyObstacle");
	if (boom == undefined) {
		boom = false;
	}
	if (boom) {
		boomMult = 0.3;
		//explode_power += playerExplosivePower;
		explode_power = playerExplosivePower / 6;
	} else {
		explode_power = REF_speed;
		boomMult = 1;
	}
	explode_ratio = Math.min(Math.abs(obstacle_health_left[data]) / OBSTACLE_HEALTH[data] + 1, 5);
	switch (data) {
		case 1 :
			destroyedObstacles[0] = 2;
			obstacleDestroyedCount[data]++;
			getChallenge("challenge",20);
			for (i = 0; i <= 10 * explode_ratio; i++) {
				generateParticle("snow_part",ground_over_holder["obstacle" + data]._x - 10 + Math.random() * 20,ground_over_holder["obstacle" + data]._y - Math.random() * 40 - 5,70 - 15 * explode_ratio + 40 * Math.random(),140 - 10 * explode_ratio - Math.random() * 50,REF_direction - 40 + 80 * Math.random(),boomMult * (2 + Math.random() * 5 + (Math.random() * explode_power * 0.6) + explode_power * 0.45),-12 + Math.random() * 24,0.985,0.4,500,10);
			}
			generateParticle("snowman_carrot",ground_over_holder["obstacle" + data]._x,ground_over_holder["obstacle" + data]._y - 30,ground_over_holder["obstacle" + data]._xscale,100,REF_direction - 10 + Math.random() * 20,Math.random() * 30 * explode_ratio + (25 * explode_ratio - 1),-Math.random() * 16 - 8,0.99,0.4,500,10);
			if (ground_over_holder["obstacle" + data]._currentframe == 1) {
				generateParticle("snowman_hat",ground_over_holder["obstacle" + data]._x,ground_over_holder["obstacle" + data]._y - 40,ground_over_holder["obstacle" + data]._xscale,100,REF_direction - 20 + 40 * Math.random(),Math.random() * 40 * explode_ratio + (40 * explode_ratio - 1),-Math.random() * 16 - 8,0.9,0.4,500,10);
			}
			//Playing the correct frame for the snowman after impact                                                                                                                                                                                                      
			if (explode_ratio >= 3) {
				ground_over_holder["obstacle" + data].gotoAndStop(4);
				//Destruction points for overkill
				REF_destruction += OBSTACLE_BOUNTY[data] * OBSTACLE_BOUNTY_OVER;
			} else {
				ground_over_holder["obstacle" + data].gotoAndStop(3);
				//Destruction points for normal kill
				REF_destruction += OBSTACLE_BOUNTY[data];
			}
			//Store in variable
			obstacleDestroyed[data - 1] = 1;
			obstacleDestroyedToday++;
			obstacleDestroyedTotal++;
			break;
		case 2 :
			destroyedObstacles[1] = 2;
			obstacleDestroyedCount[data]++;
			getChallenge("challenge",21);
			flashmc.gotoAndPlay("p2");
			for (i = 0; i <= 15 * explode_ratio; i++) {
				generateParticle("snow_part",ground_over_holder["obstacle" + data]._x - 10 + Math.random() * 20,ground_over_holder["obstacle" + data]._y - Math.random() * 40 - 5,60 - 15 * explode_ratio + 40 * Math.random(),140 - 10 * explode_ratio - Math.random() * 80,REF_direction - 40 + 80 * Math.random(),2 + Math.random() * 5 + (Math.random() * explode_power * 0.6) + explode_power * 0.45,-12 + Math.random() * 24,0.985,0.4,500,10);
			}
			//A few BIG particles
			for (i = 0; i <= 2 * explode_ratio; i++) {
				generateParticle("snow_part",ground_over_holder["obstacle" + data]._x - 10 + Math.random() * 20,ground_over_holder["obstacle" + data]._y - Math.random() * 40 - 5,250 - 25 * explode_ratio + 40 * Math.random(),140 - 10 * explode_ratio - Math.random() * 80,REF_direction - 40 + 80 * Math.random(),2 + Math.random() * 5 + (Math.random() * explode_power * 0.6) + explode_power * 0.45,-12 + Math.random() * 24,0.985,0.4,500,10);
			}
			//Playing the correct frame for the snowpile after impact                                                 
			if (explode_ratio >= 2) {
				ground_over_holder["obstacle" + data].gotoAndStop("overkill");
				//MORE big particles if obstacle is overkilled
				for (i = 0; i <= 3 * explode_ratio; i++) {
					generateParticle("snow_part",ground_over_holder["obstacle" + data]._x - 10 + Math.random() * 20,ground_over_holder["obstacle" + data]._y - Math.random() * 40 - 5,250 - 25 * explode_ratio + 40 * Math.random(),140 - 10 * explode_ratio - Math.random() * 80,REF_direction - 40 + 80 * Math.random(),1 + Math.random() * 4 + (Math.random() * explode_power * 0.4) + explode_power * 0.45,-12 + Math.random() * 24,0.985,0.3,500,10);
				}
				//Destruction points for overkill
				REF_destruction += OBSTACLE_BOUNTY[data] * OBSTACLE_BOUNTY_OVER;
			} else {
				ground_over_holder["obstacle" + data].gotoAndStop("kill");
				//Destruction points for normal kill
				REF_destruction += OBSTACLE_BOUNTY[data];
			}
			//Store in variable
			obstacleDestroyed[data - 1] = 1;
			obstacleDestroyedToday++;
			obstacleDestroyedTotal++;
			break;
		case 3 :
			destroyedObstacles[2] = 2;
			obstacleDestroyedCount[data]++;
			getChallenge("challenge",22);
			flashmc.gotoAndPlay("p3");
			for (i = 0; i <= 6 * explode_ratio; i++) {
				generateParticle("rock_part",ground_over_holder["obstacle" + data]._x - 200 + Math.random() * 400,ground_over_holder["obstacle" + data]._y - Math.random() * 40 - 5,120 - 15 * explode_ratio + 40 * Math.random(),140 - 10 * explode_ratio - Math.random() * 80,REF_direction - 40 + 80 * Math.random(),2 + Math.random() * 5 + (Math.random() * explode_power * 0.6) + explode_power * 0.45,-12 + Math.random() * 24,0.985,0.4,500,10);
			}
			//A few BIG particles
			for (i = 0; i <= 2 * explode_ratio; i++) {
				generateParticle("rock_part",ground_over_holder["obstacle" + data]._x - 400 + Math.random() * 400,ground_over_holder["obstacle" + data]._y - Math.random() * 40 - 5,250 - 25 * explode_ratio + 40 * Math.random(),140 - 10 * explode_ratio - Math.random() * 80,REF_direction - 40 + 80 * Math.random(),2 + Math.random() * 5 + (Math.random() * explode_power * 0.6) + explode_power * 0.45,-12 + Math.random() * 24,0.985,0.4,500,10);
			}
			//A few snow particles
			for (i = 0; i <= 1 * explode_ratio; i++) {
				generateParticle("snow_part",ground_over_holder["obstacle" + data]._x - 200 + Math.random() * 400,ground_over_holder["obstacle" + data]._y - Math.random() * 40 - 5,250 - 25 * explode_ratio + 40 * Math.random(),140 - 10 * explode_ratio - Math.random() * 80,REF_direction - 40 + 80 * Math.random(),2 + Math.random() * 5 + (Math.random() * explode_power * 0.6) + explode_power * 0.45,-12 + Math.random() * 24,0.985,0.4,500,10);
			}
			//Playing the correct frame for the snowpile after impact                                                 
			if (explode_ratio >= 2) {
				ground_over_holder["obstacle" + data].gotoAndStop("overkill");
				//MORE big particles if obstacle is overkilled
				for (i = 0; i <= 1 * explode_ratio; i++) {
					generateParticle("rock_part",ground_over_holder["obstacle" + data]._x - 200 + Math.random() * 400,ground_over_holder["obstacle" + data]._y - Math.random() * 40 - 5,250 - 25 * explode_ratio + 40 * Math.random(),140 - 10 * explode_ratio - Math.random() * 80,REF_direction - 40 + 80 * Math.random(),1 + Math.random() * 4 + (Math.random() * explode_power * 0.4) + explode_power * 0.45,-12 + Math.random() * 24,0.985,0.3,500,10);
				}
				//Destruction points for overkill
				REF_destruction += OBSTACLE_BOUNTY[data] * OBSTACLE_BOUNTY_OVER;
			} else if (explode_ratio >= 1.5) {
				ground_over_holder["obstacle" + data].gotoAndStop("overkillsmall");
				//MORE big particles if obstacle is slightly overkilled
				for (i = 0; i <= 1 * explode_ratio; i++) {
					generateParticle("rock_part",ground_over_holder["obstacle" + data]._x - 100 + Math.random() * 200,ground_over_holder["obstacle" + data]._y - Math.random() * 40 - 5,250 - 25 * explode_ratio + 40 * Math.random(),140 - 10 * explode_ratio - Math.random() * 80,REF_direction - 40 + 80 * Math.random(),1 + Math.random() * 4 + (Math.random() * explode_power * 0.4) + explode_power * 0.45,-12 + Math.random() * 24,0.985,0.3,500,10);
				}
				//Destruction points for normal kill
				REF_destruction += OBSTACLE_BOUNTY[data];
			} else {
				ground_over_holder["obstacle" + data].gotoAndStop("kill");
				REF_destruction += OBSTACLE_BOUNTY[data];
			}
			//Store in variable
			obstacleDestroyed[data - 1] = 1;
			obstacleDestroyedToday++;
			obstacleDestroyedTotal++;
			break;
		case 4 :
			destroyedObstacles[3] = 2;
			obstacleDestroyedCount[data]++;
			getChallenge("challenge",23);
			flashmc.gotoAndPlay("p4");
			//Many big snow parts
			for (i = 0; i <= 10 * explode_ratio; i++) {
				generateParticle("snow_part",ground_over_holder["obstacle" + data]._x - 400 + Math.random() * 800,ground_over_holder["obstacle" + data]._y - Math.random() * 40 - 5,250 - 35 * explode_ratio + 150 * Math.random(),140 - 10 * explode_ratio - Math.random() * 80,REF_direction - 40 + 80 * Math.random(),2 + Math.random() * 5 + (Math.random() * explode_power * 0.6) + explode_power * 0.45,-12 + Math.random() * 24,0.985,0.4,500,10);
			}
			//Playing the correct frame for the snowpile after impact                                                 
			if (explode_ratio >= 1.8) {
				ground_over_holder["obstacle" + data].gotoAndStop("overkill");
				//Destruction points for overkill
				REF_destruction += OBSTACLE_BOUNTY[data] * OBSTACLE_BOUNTY_OVER;
			} else {
				ground_over_holder["obstacle" + data].gotoAndStop("kill");
				//Destruction points for normal kill
				REF_destruction += OBSTACLE_BOUNTY[data];
			}
			//Store in variable
			obstacleDestroyed[data - 1] = 1;
			obstacleDestroyedToday++;
			obstacleDestroyedTotal++;
			break;
		case 5 :
			//if game is not completed yet
			if (_root.GAME_ID <> "COMPLETED") {
				clearMain();
				fadeTo("movieStoryOutro");
			}
			destroyedObstacles[4] = 2;
			obstacleDestroyedCount[data]++;
			getChallenge("challenge",24);
			flashmc.gotoAndPlay("p5");
			//Special wall animation
			effect_holder.attachMovie("the_wall_death","wall_death",effect_holder.getNextHighestDepth());
			//Playing the correct frame for the snowpile after impact                                                 
			if (explode_ratio >= 1.7) {
				ground_over_holder["obstacle" + data].gotoAndStop("overkill");
				//Destruction points for overkill
				REF_destruction += OBSTACLE_BOUNTY[data] * OBSTACLE_BOUNTY_OVER;
			} else {
				ground_over_holder["obstacle" + data].gotoAndStop("kill");
				//Destruction points for normal kill
				REF_destruction += OBSTACLE_BOUNTY[data];
			}
			//Store in variable
			obstacleDestroyed[data - 1] = 1;
			obstacleDestroyedToday++;
			obstacleDestroyedTotal++;
			break;
	}
	postConsole("obstacleDestroyedToday = " + obstacleDestroyedToday);
	verifyChallenge();
	verifyMedal();
};


delayedBoomCount = 30;
delayedBoom = function () {
	postConsole("delayedBoom");
	delayedBoomCount--;
	if (delayedBoomCount <= 0) {
		switch (playerPayload) {
				//boom(x, y,boomDir,boomDirVar,boomPower,boomScale,boomFade,boomRate,boomAmount,smokeAmount)
			case 5 :
				boom(player._x,player._y,player._rotation - 180,40,25,90,6,2,5,5);
				flashmc.gotoAndPlay("p3");
				break;
			case 6 :
				boom(player._x,player._y,player._rotation - 180,90,35,100,5,2,3,7);
				flashmc.gotoAndPlay("p4");
				break;
			case 7 :
				boom(player._x,player._y,player._rotation - 180,140,30,130,7,4,4,6);
				flashmc.gotoAndPlay("p5");
				break;
		}
		setTimerOut(playerExplosiveOut);
		player._visible = false;
		destroyBoom();
		clip(delayedBoom);
		return;
	}
};

//Destroy boom verifies if the explosion kills the obstacle
destroyBoom = function () {
	postConsole("destroyBoom");
	//explode_power+playerExplosivePower
	boom_ratio = Math.min(playerExplosivePower / obstacle_health_left[explodingOnTarget], 6);
	obstacle_health_left[explodingOnTarget] -= playerExplosivePower;
	damageMeterSet(explodingOnTarget);
	if (obstacle_health_left[explodingOnTarget] <= 0) {
		//Modify REF_direction for explosive
		REF_direction = -90;
		destroyObstacle(explodingOnTarget,true);
	} else {
		//Destruction points for damage
		REF_destruction += OBSTACLE_BOUNTY[explodingOnTarget] * OBSTACLE_BOUNTY_UNDER * (hit_ratio + boom_ratio);
	}
};

stopPlayer = function (friction, direction, flash) {
	postConsole("stopPlayer");
	if (friction == undefined) {
		friction = 0;
	}
	if (direction == undefined) {
		direction = 0;
	} else {
		player._rotation = direction;
		glide_vdir = direction;
	}
	if (flash == undefined) {
		flash = 0;
	}
	glide_vmag = Math.sqrt(glide_vx * glide_vx + glide_vy * glide_vy) * friction;
	glide_vx = Math.cos(glide_vdir * rads) * glide_vmag;
	glide_vy = Math.sin(glide_vdir * rads) * glide_vmag;
};

freezePlayer = function () {
	postConsole("freezePlayer");
	//REF_speedx to zero for blurred clouds
	REF_speedx = 0;
	//Run boost with key disabled
	keydown_array[KEY_BOOST] = false;
	runBoost();
	boostEnabled = false;
	clip(runGlide);
	clip(checkCollideTarget);
	clip(runRotate);
	clip(verifyChallenge);
};

//Required by the getX function is the "collider" mc used to test collision with boundaries
_root.attachMovie("collider","collider",_root.getNextHighestDepth());
collider._visible = false;
//getX returns the _x coordinate of the right or left side of a MC at a certain height
getX = function (mc:MovieClip, side:String, height:Number) {
	if ((mc == undefined || mc == null) || (side <> "right" && side <> "left")) {
		trace("getX - MC/Side undefined");
		return -1;
	}
	if (height == undefined || height == null) {
		height = mc._y - mc._height / 2;
	}
	collider._x = mc._x;
	collider._y = height;
	collider.gotoAndStop(side);
	var p_distance = checkForSide(collider, mc);
	if (p_distance == NaN || p_distance == undefined) {
		trace("getX - No actual collision");
		p_distance = 0;
	}
	if (side == "left") {
		return mc._x - p_distance;
	} else {
		return mc._x + p_distance;
	}
};

push(checkCollideTarget);

// ---- layer "Clouds", frame 11
CLOUD_AMOUNT = 3;//Amount of clouds in the sky
CLOUD_ABOVE_AMOUNT = 1;//Amount of clouds in the sky
CLOUD_MIRROR_BUFFER = 50;//Pixels off-screen before mirroring cloud
CLOUD_ABOVE_MIRROR_BUFFER = 500;//Pixels off-screen before mirroring cloud
CLOUD_COUNT = 4;//REF for the number of different clouds mc
CLOUD_BLUR_SPEED = 250;//Speed at which clouds are fully blurred
//debug
skyCloudQuality = 3;//0 to 3
skyCloudWind = -2;//Always moves from 0.5X to full Wind value

//Required Functions
resetClouds = function () {
	for (i=0; i<=CLOUD_AMOUNT-1; i++) {
		cloud_holder["cloud"+i]._x = Math.random()*840-100;
		cloud_holder["cloud"+i]._y = Math.random()*680-100;
		cloud_holder["cloud"+i].vx = skyCloudWind-Math.random(skyCloudWind/2);
		cloud_holder["cloud"+i]._xscale = cloud_holder["cloud"+i]._yscale=cloud_holder["cloud"+i]._alpha=125-Math.random()*90;
		cloud_holder["cloud"+i].gotoAndStop(Math.ceil(Math.random()*CLOUD_COUNT-0.01));
		cloud_holder["cloud"+i].onEnterFrame = function() {
			this._x += this.vx;
		};
		//Add to camera movement
		pushCam(cloud_holder["cloud"+i],cloud_holder["cloud"+i]._xscale/100);
	}
	for (i=CLOUD_AMOUNT; i<=CLOUD_ABOVE_AMOUNT+CLOUD_AMOUNT-1; i++) {
		cloud_above_holder["cloud"+i]._x = Math.random()*1040-200;
		cloud_above_holder["cloud"+i]._y = Math.random()*880-200;
		cloud_above_holder["cloud"+i].vx = skyCloudWind-Math.random(skyCloudWind/2);
		cloud_above_holder["cloud"+i]._xscale = cloud_above_holder["cloud"+i]._yscale=250-Math.random()*90;
		cloud_above_holder["cloud"+i]._alpha = cloud_above_holder["cloud"+i]._xscale-140;
		cloud_above_holder["cloud"+i].gotoAndStop(Math.ceil(Math.random()*CLOUD_COUNT-0.01));
		cloud_above_holder["cloud"+i].onEnterFrame = function() {
			this._x += this.vx;
		};
		//Add to camera movement
		pushCam(cloud_above_holder["cloud"+i],(cloud_above_holder["cloud"+i]._xscale-90)/100);
	}
	blurClouds();
};


//Respawn a single, defined cloud on the other side
resetCloud = function (mc, side) {
	if (mc == undefined) {
		trace("resetCloud(): mc undefined");
		return false;
	} else if (side<>"left" && side<>"right" && side<>"up" && side<>"down") {
		trace("resetCloud(): Side value not correct");
		side = "left";
	}
	mc.gotoAndStop(Math.ceil(Math.random()*CLOUD_COUNT-0.01));
	mc._xscale = cloud_holder["cloud"+i]._yscale=cloud_holder["cloud"+i]._alpha=125-Math.random()*90;
	mc.vx = skyCloudWind-Math.random(skyCloudWind/2);
	//Add to camera movement
	clipCam(mc);
	pushCam(mc,mc._xscale/100);
	switch (side) {
		case "left" :
			mc._x = Math.random()*CLOUD_MIRROR_BUFFER+640+mc._width/2;
			mc._y = Math.random()*680-100;
			break;
		case "right" :
			mc._x = -Math.random()*CLOUD_MIRROR_BUFFER-mc._width/2;
			mc._y = Math.random()*680-100;
			break;
		case "up" :
			mc._x = Math.random()*840-100;
			mc._y = Math.random()*CLOUD_MIRROR_BUFFER+480+mc._height/2;
			break;
		case "down" :
			mc._x = Math.random()*840-100;
			mc._y = -Math.random()*CLOUD_MIRROR_BUFFER-mc._height/2;
			break;
	}
	//No clouds under the sea
	if (mc._y>=sea_holder.ground1._y-70) {
		//cloud is below sea level
		mc._y = sea_holder.ground1._y-700-Math.random()*CLOUD_MIRROR_BUFFER-mc._height/2;
	}
};

//If cloud leaves stage, move and respawn it on the other side
mirrorClouds = function () {
	for (i=0; i<=CLOUD_AMOUNT-1; i++) {
		//Left
		if (cloud_holder["cloud"+i]._x+cloud_holder["cloud"+i]._width/2+CLOUD_MIRROR_BUFFER<=0) {
			resetCloud(cloud_holder["cloud"+i],"left");
		} else if (cloud_holder["cloud"+i]._x-cloud_holder["cloud"+i]._width/2-CLOUD_MIRROR_BUFFER>=640) {
			resetCloud(cloud_holder["cloud"+i],"right");
		} else if (cloud_holder["cloud"+i]._y+cloud_holder["cloud"+i]._height/2+CLOUD_MIRROR_BUFFER<=0) {
			resetCloud(cloud_holder["cloud"+i],"up");
		} else if (cloud_holder["cloud"+i]._y-cloud_holder["cloud"+i]._height/2-CLOUD_MIRROR_BUFFER>=480) {
			resetCloud(cloud_holder["cloud"+i],"down");
		}
	}
	for (i=CLOUD_AMOUNT; i<=CLOUD_ABOVE_AMOUNT+CLOUD_AMOUNT-1; i++) {
		//Left
		if (cloud_above_holder["cloud"+i]._x+cloud_above_holder["cloud"+i]._width/2+CLOUD_ABOVE_MIRROR_BUFFER<=0) {
			resetCloudAbove(cloud_above_holder["cloud"+i],"left");
		} else if (cloud_above_holder["cloud"+i]._x-cloud_above_holder["cloud"+i]._width/2-CLOUD_ABOVE_MIRROR_BUFFER>=640) {
			resetCloudAbove(cloud_above_holder["cloud"+i],"right");
		} else if (cloud_above_holder["cloud"+i]._y+cloud_above_holder["cloud"+i]._height/2+CLOUD_ABOVE_MIRROR_BUFFER<=0) {
			resetCloudAbove(cloud_above_holder["cloud"+i],"up");
		} else if (cloud_above_holder["cloud"+i]._y-cloud_above_holder["cloud"+i]._height/2-CLOUD_ABOVE_MIRROR_BUFFER>=480) {
			resetCloudAbove(cloud_above_holder["cloud"+i],"down");
		}
	}
};


//Cloud above functions
//Respawn a single, defined cloud on the other side
resetCloudAbove = function (mc, side) {
	if (mc == undefined) {
		trace("resetCloudAbove(): mc undefined");
		return false;
	} else if (side<>"left" && side<>"right" && side<>"up" && side<>"down") {
		trace("resetCloudAbove(): Side value not correct");
		side = "left";
	}
	mc.gotoAndStop(Math.ceil(Math.random()*CLOUD_COUNT-0.01));
	mc._x = Math.random()*1040-200;
	mc._y = Math.random()*880-200;
	mc.vx = skyCloudWind-Math.random(skyCloudWind/2);
	mc._xscale = mc._yscale=250-Math.random()*90;
	mc._alpha = mc._xscale-140;
	//Add to camera movement
	clipCam(cloud_holder["cloud"+i]);
	pushCam(cloud_holder["cloud"+i],cloud_holder["cloud"+i]._xscale/100);
	switch (side) {
		case "left" :
			mc._x = Math.random()*CLOUD_MIRROR_BUFFER+1040+mc._width/2;
			mc._y = Math.random()*880-200;
			break;
		case "right" :
			mc._x = -Math.random()*CLOUD_MIRROR_BUFFER-mc._width/2;
			mc._y = Math.random()*880-200;
			break;
		case "up" :
			mc._x = Math.random()*1040-200;
			mc._y = Math.random()*CLOUD_MIRROR_BUFFER+880+mc._height/2;
			break;
		case "down" :
			mc._x = Math.random()*1040-200;
			mc._y = -Math.random()*CLOUD_MIRROR_BUFFER-mc._height/2;
			break;
	}
	//No clouds under the sea
	if (mc._y>=sea_holder.ground1._y-70) {
		//cloud is below sea level
		mc._y = sea_holder.ground1._y-700-Math.random()*CLOUD_MIRROR_BUFFER-mc._height/2;
	}
};




blurClouds = function () {
	if (skyCloudQuality>=1) {
		for (i=0; i<=CLOUD_AMOUNT-1; i++) {
			tempCloudBlur = Math.max(1, Math.ceil((Math.abs(REF_speedx)*cloud_holder["cloud"+i]._xscale/100)/CLOUD_BLUR_SPEED*399)+1);
			cloud_holder["cloud"+i].cloud.gotoAndStop(tempCloudBlur);
		}
		for (i=CLOUD_AMOUNT; i<=CLOUD_ABOVE_AMOUNT+CLOUD_AMOUNT-1; i++) {
			//Cloud above
			tempCloudBlur = Math.max(1, Math.ceil((Math.abs(REF_speedx)*(310-cloud_above_holder["cloud"+i]._xscale)/100)/CLOUD_BLUR_SPEED*399)+1);
			cloud_above_holder["cloud"+i].cloud.gotoAndStop(tempCloudBlur);
		}
	}
};


//SETUP
//Generate clouds
if (skyCloudQuality<>0 && skyCloudQuality<>1 && skyCloudQuality<>2 && skyCloudQuality<>3) {
	trace("skyCloudQuality: incorrect value");
	skyCloudQuality = 0;
}
switch (skyCloudQuality) {
	case 0 :
		//No clouds
		break;
	case 1 :
		//Low quality (No blur)
		for (i=0; i<=CLOUD_AMOUNT-1; i++) {
			cloud_holder.attachMovie("cloudslow","cloud"+i,cloud_holder.getNextHighestDepth());
		}
		for (i=CLOUD_AMOUNT; i<=CLOUD_ABOVE_AMOUNT+CLOUD_AMOUNT-1; i++) {
			cloud_above_holder.attachMovie("cloudslow","cloud"+i,cloud_above_holder.getNextHighestDepth());
		}
		resetClouds();
		break;
	case 2 :
		//Medium quality (low blur)
		for (i=0; i<=CLOUD_AMOUNT-1; i++) {
			cloud_holder.attachMovie("cloudsmed","cloud"+i,cloud_holder.getNextHighestDepth());
		}
		for (i=CLOUD_AMOUNT; i<=CLOUD_ABOVE_AMOUNT+CLOUD_AMOUNT-1; i++) {
			cloud_above_holder.attachMovie("cloudsmed","cloud"+i,cloud_above_holder.getNextHighestDepth());
		}
		resetClouds();
		break;
	case 3 :
		//High quality (Medium blur)
		for (i=0; i<=CLOUD_AMOUNT-1; i++) {
			cloud_holder.attachMovie("cloudshi","cloud"+i,cloud_holder.getNextHighestDepth());
		}
		for (i=CLOUD_AMOUNT; i<=CLOUD_ABOVE_AMOUNT+CLOUD_AMOUNT-1; i++) {
			cloud_above_holder.attachMovie("cloudshi","cloud"+i,cloud_above_holder.getNextHighestDepth());
		}
		resetClouds();
		break;
}

push(mirrorClouds);
push(blurClouds);

// ---- layer "Sky", frame 11
MAX_ALTITUDE = 1000;

//Setup sky
sky_holder.attachMovie("sky","sky",sky_holder.getNextHighestDepth());
sky_holder.sky._x = 0;
sky_holder.sky._y = 0;
sky_holder.sky.gotoAndStop(1);

runSky = function () {
	sky_holder.sky.gotoAndStop(Math.max(1, Math.min(400, Math.ceil(REF_altitude/MAX_ALTITUDE*400))));
	sky_holder.sky.shade._x += cam_vx*0.2;
	if (sky_holder.sky.shade._x<=0) {
		sky_holder.sky.shade._x += sky_holder.sky.shade._width/2;
	}else if (sky_holder.sky.shade._x>=sky_holder.sky.shade._width/2) {
		sky_holder.sky.shade._x -= sky_holder.sky.shade._width/2;
	}
};



push(runSky);

// ---- layer "Effects", frame 11
SNOW_PILING_DELAY = 100;//Snow_count to accumulate BEFORE snow begins piling
SNOW_PILE_LIFE = 500;//# of frames that a snow pile remains after being released
SNOW_PILING_X_ADJUST = stat_glider_pile_offset[getEquip("glider")];//# of pixels to offset pile

//particles var
particleCount = 0;
//snowPiling vars
snow_piling_amount = 0;
snow_piling_count = 0;
snow_piling_check = 0;
//snowBoom vars
snow_boom_count = 0;//counter for crashing boom effect (land and sea)



//generateParticle(type, x, y, scale, alpha, vdir, vmag, vr, resistance, gravity, life, fade)
generateParticle = function (type, x, y, scale, alpha, vdir, vmag, vr, resistance, gravity, life, fade) {
	effect_holder.attachMovie(type,"particle"+particleCount,effect_holder.getNextHighestDepth());
	if (type == "snow_part") {
		maxFrame = 5;
	} else {
		maxFrame = 1;
	}
	effect_holder["particle"+particleCount].gotoAndStop(Math.ceil(Math.random()*(maxFrame-0.1)+0.1));
	pushCam(effect_holder["particle"+particleCount]);
	effect_holder["particle"+particleCount]._x = x;
	effect_holder["particle"+particleCount]._y = y;
	effect_holder["particle"+particleCount]._xscale = scale;
	effect_holder["particle"+particleCount]._yscale = scale;
	effect_holder["particle"+particleCount]._alpha = alpha;
	effect_holder["particle"+particleCount].vx = vmag*Math.cos(vdir/57.3);
	effect_holder["particle"+particleCount].vy = vmag*Math.sin(vdir/57.3);
	effect_holder["particle"+particleCount].vr = vr;
	effect_holder["particle"+particleCount].life = life;
	effect_holder["particle"+particleCount].fade = fade;
	effect_holder["particle"+particleCount].resist = resistance;
	effect_holder["particle"+particleCount].grav = gravity;
	effect_holder["particle"+particleCount].onEnterFrame = function() {
		this.life--;
		if (this.life<=0) {
			if (this.fade>0) {
				this._alpha -= this.fade;
				if (this._alpha<=0) {
					clipCam(this);
					this.removeMovieClip();
				}
			} else {
				clipCam(this);
				this.removeMovieClip();
			}
		}
		this._x += this.vx;
		this._y += this.vy;
		this._rotation += this.vr;
		this.vx *= this.resist;
		this.vy *= this.resist;
		this.vy += this.grav;
	};
	particleCount++;
};

generateBubble = function () {
	effect_holder.attachMovie("bubble","particle"+particleCount,effect_holder.getNextHighestDepth());
	pushCam(effect_holder["particle"+particleCount]);
	effect_holder["particle"+particleCount]._x = player._x-35+Math.random()*70;
	effect_holder["particle"+particleCount]._y = player._y-35+Math.random()*70;
	effect_holder["particle"+particleCount]._xscale = effect_holder["particle"+particleCount]._yscale=50+Math.random()*70;
	effect_holder["particle"+particleCount]._alpha = 30+Math.random()*70;
	//effect_holder["particle"+particleCount].vx = REF_speedx+(Math.random()-0.5)*REF_speedx*0.5;
	//effect_holder["particle"+particleCount].vy = REF_speedy+(Math.random()-0.5)*REF_speedy*0.5;
	effect_holder["particle"+particleCount].vx = Math.cos((REF_direction-10+20*Math.random())*rads)*REF_speed;
	effect_holder["particle"+particleCount].vy = Math.sin((REF_direction-10+20*Math.random())*rads)*REF_speed;
	effect_holder["particle"+particleCount].life = 75+Math.random()*50;
	effect_holder["particle"+particleCount].onEnterFrame = function() {
		this.life--;
		if (this.life<=0) {
			if (this._xscale>=5) {
				this._xscale = this._yscale=this._xscale-2;
			} else {
				clipCam(this);
				this.removeMovieClip();
			}
		}
		this._x += this.vx;
		this._y += this.vy;
		this.vx *= 0.83;
		this.vy *= 0.83;
		this.vy -= 1.4;
		//If bubble is getting close to surface, start fading
		if (this._y<=sea_holder.ground1._y+50) {
			this._alpha -= 3;
			if (this.alpha<=3) {
				clipCam(this);
				this.removeMovieClip();
			}
		}
		//If bubble reaches the surface, shrink and die              
		if (this._y<=sea_holder.ground1._y+5) {
			this.onEnterFrame = function() {
				if (this._xscale>=11) {
					this._xscale = this._yscale=this._xscale-10;
				} else {
					clipCam(this);
					this.removeMovieClip();
				}
			};
		}
	};
	particleCount++;
};


snowPiling = function () {
	if (checkAboveGround() && ((player._rotation>=-90 && player._rotation<=90) && player._y+GROUND_COLLISION_ADJUST>=ground_over_holder.ground1._y) || ((player._rotation<(-90) || player._rotation>90) && player._y+GROUND_COLLISION_ADJUST>=ground_over_holder.ground1._y-player.hitspot._height)) {
		snow_piling_count += glide_vmag/5;
		if (snow_piling_count>=SNOW_PILING_DELAY && snow_piling_check == 0) {
			snow_piling_check = 1;
			if (player._rotation>=-90 && player._rotation<=90) {
				effect_holder.attachMovie("snow_piling","snow_piling"+snow_piling_amount,effect_holder.getNextHighestDepth());
				effect_holder["snow_piling"+snow_piling_amount]._x = player._x+SNOW_PILING_X_ADJUST;
			} else {
				effect_holder.attachMovie("snow_piling_backward","snow_piling"+snow_piling_amount,effect_holder.getNextHighestDepth());
				effect_holder["snow_piling"+snow_piling_amount]._x = player._x-SNOW_PILING_X_ADJUST;
			}
			effect_holder["snow_piling"+snow_piling_amount].stop();
			effect_holder["snow_piling"+snow_piling_amount]._y = ground_over_holder.ground1._y;
		} else if (snow_piling_count>=SNOW_PILING_DELAY+1) {
			if (player._rotation>=-90 && player._rotation<=90) {
				effect_holder["snow_piling"+snow_piling_amount]._x = Math.min(player._x+SNOW_PILING_X_ADJUST, ground_over_holder.ground_end._x+ground_over_holder.ground_end._width-effect_holder["snow_piling"+snow_piling_amount]._width*1.3);
			} else {
				effect_holder["snow_piling"+snow_piling_amount]._x = Math.min(player._x-SNOW_PILING_X_ADJUST, ground_over_holder.ground_end._x+ground_over_holder.ground_end._width-effect_holder["snow_piling"+snow_piling_amount]._width*1.3);
			}
			effect_holder["snow_piling"+snow_piling_amount]._y = ground_over_holder.ground1._y;
			effect_holder["snow_piling"+snow_piling_amount].gotoAndStop(Math.min(1500, Math.ceil(snow_piling_count-SNOW_PILING_DELAY)));
			glide_vx *= Math.max(0.7, 1-(0.3*((snow_piling_count-SNOW_PILING_DELAY)/1500)));
		}
	} else {
		//Countdown before fading out snow piles
		effect_holder["snow_piling"+snow_piling_amount].life = SNOW_PILE_LIFE;
		effect_holder["snow_piling"+snow_piling_amount].onEnterFrame = function() {
			this._y = ground_over_holder.ground1._y;
			this.life--;
			if (this.life<=0) {
				this._alpha -= 1;
				if (this._alpha<=0) {
					clipCam(this);
					this.removeMovieClip();
				}
			}
		};
		pushCam(effect_holder["snow_piling"+snow_piling_amount]);
		snow_piling_count = 0;
		snow_piling_check = 0;
		clip(snowPiling);
		snow_piling_amount++;
	}
};


snowBoom = function (x, y, power, fade, xscale, yscale, rotation, type) {
	postConsole("snowBoom IN");
	if (type == undefined || type == null) {
		type = "snow_boom";
	}
	if (rotation == undefined) {
		rotation = 0;
	}
	//Generate BOOM effect          
	effect_holder.attachMovie(type,"snow_boom"+snow_boom_count,effect_holder.getNextHighestDepth());
	effect_holder["snow_boom"+snow_boom_count]._x = x;
	effect_holder["snow_boom"+snow_boom_count]._y = y;
	effect_holder["snow_boom"+snow_boom_count].power = power;
	effect_holder["snow_boom"+snow_boom_count].fade = fade;
	effect_holder["snow_boom"+snow_boom_count]._xscale = xscale;
	effect_holder["snow_boom"+snow_boom_count]._yscale = yscale;
	effect_holder["snow_boom"+snow_boom_count]._rotation = rotation;
	pushCam(effect_holder["snow_boom"+snow_boom_count]);
	effect_holder["snow_boom"+snow_boom_count].onEnterFrame = function() {
		this._yscale += this.power-this.fade;
		this._xscale += this.fade*0.6;
		this.power = Math.max(0, this.power*0.9-1);
		if (this.power<=1) {
			this._alpha -= 3;
		}
		if (this._yscale<=0) {
			clipCam(this);
			this.removeMovieClip();
		}
	};
	snow_boom_count++;
	postConsole("snowBoom OUT");
};

waterSplash = function (x, y, power) {
	if (x == undefined || x == null || y == undefined || y == null) {
		x = player._x;
		y = sea_holder.ground1._y;
	}
	if (power == undefined || power == null) {
		power = REF_speed;
	}
	//SFX - splash
	playSfx("splash");	
	//High splash                            
	effect_holder.attachMovie("splash","splash"+snow_boom_count,effect_holder.getNextHighestDepth());
	effect_holder["splash"+snow_boom_count]._x = x;
	effect_holder["splash"+snow_boom_count]._y = y;
	effect_holder["splash"+snow_boom_count].power = 16+power;
	effect_holder["splash"+snow_boom_count].fade = power/15;
	effect_holder["splash"+snow_boom_count]._xscale = 30+power/10;
	effect_holder["splash"+snow_boom_count]._yscale = 1;
	pushCam(effect_holder["splash"+snow_boom_count]);
	effect_holder["splash"+snow_boom_count].onEnterFrame = function() {
		this._yscale += this.power-this.fade;
		this._xscale += this.fade*0.6;
		this.power = Math.max(0, this.power*0.9-1);
		if (this.power<=1) {
			this._alpha -= 3;
		}
		if (this._yscale<=0) {
			clipCam(this);
			this.removeMovieClip();
		}
	};
	snow_boom_count++;
	//Flat splash
	effect_holder.attachMovie("splash","splash"+snow_boom_count,effect_holder.getNextHighestDepth());
	effect_holder["splash"+snow_boom_count]._x = x;
	effect_holder["splash"+snow_boom_count]._y = y;
	effect_holder["splash"+snow_boom_count].power = 2+power*0.5;
	effect_holder["splash"+snow_boom_count].fade = power/20;
	effect_holder["splash"+snow_boom_count]._xscale = 140+power/6;
	effect_holder["splash"+snow_boom_count]._yscale = 1;
	pushCam(effect_holder["splash"+snow_boom_count]);
	effect_holder["splash"+snow_boom_count].onEnterFrame = function() {
		this._yscale += this.power-this.fade;
		this._xscale += this.fade;
		this.power = Math.max(0, this.power*0.9-1);
		if (this.power<=1) {
			this._alpha -= 3;
		}
		if (this._yscale<=0) {
			clipCam(this);
			this.removeMovieClip();
		}
	};
	snow_boom_count++;
};




///EXPLOSION EFFECT
//Maximum rotation speed of puffs
BOOM_POWER_VAR = 0.35;
_root.effect_holder.boomCount = 0;
count = 0;

//boom(x, y,boomDir,boomDirVar,boomPower,boomScale,boomFade,boomRate,boomAmount,smokeAmount)

boom = function (x, y, boomDir, boomDirVar, boomPower, boomScale, boomFade, boomRate, boomAmount, smokeAmount) {
	//DEBUG
	//boomDir = 0;
	//Base direction
	//boomDirVar = 80;
	//Variation in direction
	//boomPower = 20;
	//Power of explosion/how far everything flies off
	//boomScale = 100;
	//Initial scale of puffs
	//boomFade = 2;
	//Decrease in puffs scale
	//boomAmount = 5;
	//Amount of orange trails
	//smokeAmount = 3;
	//Amount of yellow/white smoke (for each)
	//Explosion
	for (i=1; i<=boomAmount; i++) {
		effect_holder.createEmptyMovieClip("trail"+i,effect_holder.getNextHighestDepth());
		//effect_holder._quality = "MEDIUM"
		pushCam(effect_holder["trail"+i]);
		effect_holder["trail"+i]._x = x;
		effect_holder["trail"+i]._y = y;
		effect_holder["trail"+i].count = Math.random()*6;
		effect_holder["trail"+i].boomScale = boomScale;
		effect_holder["trail"+i].boomFade = boomFade;
		effect_holder["trail"+i].boomRate = boomRate;
		effect_holder["trail"+i].vx = Math.cos((((Math.random()-0.5)*boomDirVar)+boomDir)*0.01745)*(boomPower-(BOOM_POWER_VAR*boomPower*(Math.random()-0.5)));
		effect_holder["trail"+i].vy = Math.sin((((Math.random()-0.5)*boomDirVar)+boomDir)*0.01745)*(boomPower-(BOOM_POWER_VAR*boomPower*(Math.random()-0.5)));
		effect_holder["trail"+i].onEnterFrame = function() {
			this._x += this.vx;
			this._y += this.vy;
			this.vx *= 0.96;
			this.vy *= 0.97;
			this.vy += 0.7;
			this.boomScale -= this.boomFade;
			if (this.boomScale<=30) {
				this.onEnterFrame = null;
				this.removeMovieClip();
				return;
			}
			this.count--;
			if (this.count<=0) {
				_root.effect_holder.attachMovie("explosion_puff_1","boom"+_root.effect_holder.boomCount,_root.effect_holder.getNextHighestDepth());
				_root.effect_holder["boom"+_root.effect_holder.boomCount]._xscale = _root.effect_holder["boom"+_root.effect_holder.boomCount]._yscale=this.boomScale+(0.2*this.boomScale*(Math.random()-0.65));
				_root.effect_holder["boom"+_root.effect_holder.boomCount]._x = this._x;
				_root.effect_holder["boom"+_root.effect_holder.boomCount]._y = this._y;
				_root.effect_holder["boom"+_root.effect_holder.boomCount].vr = 50*(Math.random()-0.5);
				_root.effect_holder["boom"+_root.effect_holder.boomCount].onEnterFrame = function() {
					this._rotation += this.vr;
					this.vr *= 0.95;
				};
				_root.effect_holder.boomCount++;
				this.count = this.boomRate;
			}
		};
	}
	for (i=1; i<=smokeAmount; i++) {
		//1
		effect_holder.attachMovie("explosion_puff_2","boom"+_root.effect_holder.boomCount,effect_holder.getNextHighestDepth());
		//effect_holder._quality = "MEDIUM"
		pushCam(effect_holder["boom"+_root.effect_holder.boomCount]);
		effect_holder["boom"+_root.effect_holder.boomCount]._x = x+(Math.random()-0.5)*20;
		effect_holder["boom"+_root.effect_holder.boomCount]._y = y+(Math.random()-0.5)*20;
		effect_holder["boom"+_root.effect_holder.boomCount]._xscale = effect_holder["boom"+_root.effect_holder.boomCount]._yscale=boomScale+boomScale*(Math.random()-0.5)*0.5;
		if (Math.random()>=0.5) {
			puffDir = boomDir+90;
		} else {
			puffDir = boomDir-90;
		}
		effect_holder["boom"+_root.effect_holder.boomCount].vx = Math.cos((((Math.random()-0.5)*boomDirVar/1)+puffDir)*0.01745)*((boomPower/3)-(BOOM_POWER_VAR*boomPower*(Math.random()-0.5)));
		effect_holder["boom"+_root.effect_holder.boomCount].vy = Math.sin((((Math.random()-0.5)*boomDirVar/1)+puffDir)*0.01745)*((boomPower/3)-(BOOM_POWER_VAR*boomPower*(Math.random()-0.5)));
		effect_holder["boom"+_root.effect_holder.boomCount].onEnterFrame = function() {
			this._x += this.vx;
			this._y += this.vy;
			this.vx *= 0.92;
			this.vy *= 0.92;
		};
		_root.effect_holder.boomCount++;
		//2
		effect_holder.attachMovie("explosion_puff_3","boom"+_root.effect_holder.boomCount,effect_holder.getNextHighestDepth());
		//effect_holder._quality = "MEDIUM"
		pushCam(effect_holder["boom"+_root.effect_holder.boomCount]);
		effect_holder["boom"+_root.effect_holder.boomCount]._x = x+(Math.random()-0.5)*20;
		effect_holder["boom"+_root.effect_holder.boomCount]._y = y+(Math.random()-0.5)*20;
		effect_holder["boom"+_root.effect_holder.boomCount]._xscale = effect_holder["boom"+_root.effect_holder.boomCount]._yscale=boomScale+boomScale*(Math.random()-0.5)*0.5;
		if (Math.random()>=0.5) {
			puffDir = boomDir+90;
		} else {
			puffDir = boomDir-90;
		}
		effect_holder["boom"+_root.effect_holder.boomCount].vx = Math.cos((((Math.random()-0.5)*boomDirVar/1)+puffDir)*0.01745)*((boomPower/3)-(BOOM_POWER_VAR*boomPower*(Math.random()-0.5)));
		effect_holder["boom"+_root.effect_holder.boomCount].vy = Math.sin((((Math.random()-0.5)*boomDirVar/1)+puffDir)*0.01745)*((boomPower/3)-(BOOM_POWER_VAR*boomPower*(Math.random()-0.5)));
		effect_holder["boom"+_root.effect_holder.boomCount].onEnterFrame = function() {
			this._x += this.vx;
			this._y += this.vy;
			this.vx *= 0.92;
			this.vy *= 0.92;
		};
		_root.effect_holder.boomCount++;
	}
};

// ---- layer "Obstacle Indicator", frame 11
//obstacle_ind.gotoAndStop("outend");
oIActiveDistance = new Array(0, 50, 112, 225, 400, 700);
oIIsActive = false;

obstacle_ind.gotoAndStop("outend");
obstacle_ind._visible = false;

if (GAME_MODE<>"story") {
	obstacle_ind._visible = false;
	obstacle_ind._alpha = 0;
	obstacle_ind = stop();
} else {
	obstacle_ind._x = 535;
	obstacle_ind.onEnterFrame = function() {
		oIDistance = Math.abs(player._x-ground_over_holder.obstacle1._x);
		oITarget = 1;
		for (i=2; i<=5; i++) {
			if (Math.abs(player._x-ground_over_holder["obstacle"+i]._x)<=oIDistance) {
				oIDistance = Math.abs(player._x-ground_over_holder["obstacle"+i]._x);
				oITarget = i;
			}
		}
		//trace(oITarget+" at "+oIDistance/FOOT_RATIO+", "+oIIsActive);
		if (oIIsActive == false && _root.obstacleDestroyed[oITarget-1] == 0 && oIDistance/FOOT_RATIO<=oIActiveDistance[oITarget]) {
			this.gotoAndPlay("in");
			this._visible = true;
			oIIsActive = true;
		} else if (oIIsActive && (_root.obstacleDestroyed[oITarget-1]<>0 || oIDistance/FOOT_RATIO>oIActiveDistance[oITarget])) {
			this.gotoAndPlay("out");
			oIIsActive = false;
		}
		switch (oITarget) {
			case 1 :
				oIHeight = -55;
				break;
			case 2 :
				oIHeight = -100;
				break;
			case 3 :
				oIHeight = -250;
				break;
			case 4 :
				oIHeight = -400;
				break;
			case 5 :
				oIHeight = -1500;
				break;
		}
		this.pointer.gotoAndStop(oITarget);
		this.pointer.body._rotation = Math.atan2(_root.player._y-(ground_over_holder["obstacle"+oITarget]._y+oIHeight), _root.player._x-ground_over_holder["obstacle"+oITarget]._x)/0.01745-180;
		this._y = Math.max(75, Math.min(300, ground_over_holder["obstacle"+oITarget]._y+oIHeight));
		if (_root.obstacleDestroyed[oITarget-1] == 0) {
			this.num.num.text = Math.round(oIDistance/FOOT_RATIO);
		} else {
			this.num.num.text = "";
		}
	};
}

// ---- layer "Slide Meter", frame 11
import flash.geom.Point;

//SLIDE_METER_THRESHOLD_BEFORE = 700;//Distance at which slide meter begins working
SLIDE_METER_THRESHOLD_BEFORE = 30*test_player_length*test_player_length+700;//Distance at which slide meter begins working
SLIDE_METER_THRESHOLD_AFTER = 100;//Distance past which slide meter stops working
SLIDE_METER_TRIGGER_LOW = 64;//% above which level 1
SLIDE_METER_TRIGGER_MED = 85;//% above which level 2
SLIDE_METER_TRIGGER_HIGH = 94;//% above which level 3

slideMeter.gotoAndStop(1);
slideMeter._visible = false;
slideMeterState = -1;
if (debug_sleigh_jump>0) {
	enableSlideMeter = true;//Use this depending on sleigh
	runSlideJumpBool = true;
	slideMeterState = 0;
	meterFrame = 1;
} else {
	enableSlideMeter = false;
	runSlideJumpBool = false;
}
slideMeterKeyPushed = "";

runSlideMeter = function () {
	hotspot._x = ramp._x;
	hotspot._y = ramp._y;
	slideMeter._x = player._x;
	slideMeter._y = player._y;
	meterTarget = new Point(hotspot.hotspot3.meterTarget._x, hotspot.hotspot3.meterTarget._y);
	hotspot.hotspot3.localToGlobal(meterTarget);
	meterFrame = Math.sqrt(Math.pow(meterTarget.x-player._x, 2)+Math.pow(meterTarget.y-player._y, 2));
	if (meterFrame<=SLIDE_METER_THRESHOLD_BEFORE && player._x<=meterTarget.x) {
		if (slideMeterState == 0) {
			//meter shows up
			slideMeter.gotoAndPlay("in");
			slideMeter._visible = true;
			slideMeterState = 0.5;
			slideMeterKeyPushed = "";
		}
		meterFrame = Math.min(100, Math.max(1, 100-Math.ceil(meterFrame/SLIDE_METER_THRESHOLD_BEFORE*100)));
	} else if (player._x>=meterTarget.x) {
		meterFrame = Math.min(100, Math.max(1, 100-Math.ceil(meterFrame/SLIDE_METER_THRESHOLD_AFTER*100)));
		if (slideMeterState == 1) {
			//Slide meter fades out
			slideMeterState = 2;
			slideMeter.gotoAndPlay("out");
		}
		if (meterFrame<=1) {
			//If falls to 1, turn off
			slideMeter.meter.gotoAndStop(1);
			runSlideJumpBool = false;
			slideMeter.gotoAndPlay("out");
			clip(runSlideMeter);
			return;
		}
	} else {
		meterFrame = 1;
	}
	if (slideMeterState == 1) {
		slideMeter.gotoAndStop(meterFrame);
	}
	slideMeter.meter.gotoAndStop(meterFrame);
	//Triggered
	if (slideMeterKeyPushed == 1 && slideMeterState>0) {
		slideMeterKeyPushed = null;
		if (meterFrame>=SLIDE_METER_TRIGGER_HIGH) {
			trace("Level 3");
			slideMeter.gotoAndPlay("level3");
		} else if (meterFrame>=SLIDE_METER_TRIGGER_MED) {
			trace("Level 2");
			slideMeter.gotoAndPlay("level2");
		} else if (meterFrame>=SLIDE_METER_TRIGGER_LOW) {
			trace("Level 1");
			slideMeter.gotoAndPlay("level1");
		} else {
			trace("Level 0");
			slideMeter.gotoAndPlay("out");
		}
		clip(runSlideMeter);
		runSlideJump(meterFrame);
		return;
	}
};

runSlideJump = function (data) {
	if (runSlideJumpBool) {
		runSlideJumpBool = false;
		if (state>=3) {
			//player has already left the ramp
			//Simply modify the current glide_vx/vy
			glide_vx += Math.cos((glide_vdir-35)*rads)*(debug_sleigh_jump*Math.max(20, data)/100);
			glide_vy += Math.sin((glide_vdir-35)*rads)*(debug_sleigh_jump*Math.max(20, data)/100);
			player._rotation = Math.atan2(glide_vy, glide_vx)/rads;
			sleigh.sleigh.gotoAndPlay(2);
		} else {
			//player is on ramp
			//Force take-off before time with modified values
			runJump(Math.max(RAMP_JUMP_ANGLE-30, player._rotation),debug_sleigh_jump*Math.max(20, data)/100);
			sleigh.sleigh.gotoAndPlay(2);
		}
		if (playerSleigh == 7) {
			//Player is equipped with (ka)Boom Box
			//boom(x, y,boomDir,boomDirVar,boomPower,boomScale,boomFade,boomRate,boomAmount,smokeAmount)
			boom(player._x,player._y,player._rotation,60,45,90,6,2,6,8);
		}
	}
};

if (enableSlideMeter) {
	push(runSlideMeter);
}

// ---- layer "Destruction-meter", frame 11
destructionMeter.gotoAndStop("idle");
destructionMeter.meter.gotoAndStop(1);

damageMeterSet = function (data) {
	//trace(obstacle_startofday_health[data])
	//trace(OBSTACLE_HEALTH[data])
	//trace(400-Math.floor(0.01+(obstacle_health_left[data]/OBSTACLE_HEALTH[data])*399.98))
	destructionMeter.meter.oStart = 400-Math.floor(0.01+(obstacle_startofday_health[data]/OBSTACLE_HEALTH[data])*399.98);
	destructionMeter.meter.oHealth = 400-Math.floor(0.01+(obstacle_health_left[data]/OBSTACLE_HEALTH[data])*399.98);
	if (destructionMeter.meter.oHealth>=400) {
		destructionMeter.meter.damageMeterDelay = 4;
		destructionMeter.meter.damageMeterTimer = destructionMeter.meter.damageMeterTimerMax=20;
		destructionMeter.meter.damageMeterDestroyed = true;
		destructionMeter.gotoAndPlay("cleanin");
	} else {
		destructionMeter.meter.damageMeterDelay = 5;
		destructionMeter.meter.damageMeterTimer = destructionMeter.meter.damageMeterTimerMax=30;
		destructionMeter.meter.damageMeterDestroyed = false;
		destructionMeter.gotoAndPlay("in");
	}
	destructionMeter.meter.gotoAndStop(destructionMeter.meter.oStart);
	destructionMeter.meter.baseRoot = destructionMeter.meter.damageMeterTimer;
	destructionMeter.meter.onEnterFrame = function() {
		if (this.damageMeterDelay>=1) {
			this.damageMeterDelay--;
			return;
		}
		if (this.damageMeterDestroyed) {
			this.damageMeterDestroyed = false;
			_root.destructionMeter.gotoAndPlay("destroyed");
		}
		this.damageMeterTimer = Math.max(-1, this.damageMeterTimer-1);
		this.gotoAndStop(Math.max(1, Math.ceil(this.oStart+(this.oHealth-this.oStart)*(1-(Math.pow(this.damageMeterTimer, 2)/this.baseRoot)/this.damageMeterTimerMax))));
		if (this.damageMeterTimer<=-1) {
			this.onEnterFrame = null;
		}
	};
};

// ---- layer "Bonus Huds", frame 11
bonusHud.gotoAndStop("empty");

//debug
test_bonus_hud_level = _root.bonusItemOwn[11];

setBonusHUD = function () {
	if (test_bonus_hud_level >= 1 && test_bonus_hud_level <= 3) {
		bonusHud.gotoAndPlay(test_bonus_hud_level + "in");
		push(runBonusHUD);
	} else {
		bonusHud.gotoAndStop("empty");
	}
};

runBonusHUD = function () {
	//res goes from +/- 0.95 to 1.05
	//red goes from 0 to 1+
	//floor EVERY value to avoid "."
	bhRedZone = (Math.max(0, Math.min(5, (REF_speed - test_red_zone) / test_red_zone)));
	if (player._rotation <= 0 && player._rotation >= (-90)) {
		bhResistance = (1 - (player._rotation / -85) * 0.1 * test_glider_upcatch);
		//Amount of acceleration
	} else if (player._rotation >= 0 && player._rotation <= 90) {
		bhResistance = (1 - (player._rotation / -85) * 0.1 * test_glider_catch);
	} else if (player._rotation >= 90 && player._rotation <= 180) {
		bhResistance = (1 - ((player._rotation - 180) / 85) * 0.1 * test_glider_catch);
	} else {
		bhResistance = (1 - ((player._rotation + 180) / 85) * 0.1 * test_glider_upcatch);
	}
	bhDistance = Math.floor(REF_distance);
	bhRedZone = Math.floor(bhRedZone * 80);
	bhResistance = -Math.floor((bhResistance - 1) * 2000);
	switch (test_bonus_hud_level) {
		case 1 :
			bonusHud.hud.dis.text = bhDistance;
			return;
		case 2 :
			bonusHud.hud.dis.text = bhDistance;
			bonusHud.hud.res.text = bhResistance;
			return;
		case 3 :
			bonusHud.hud.dis.text = bhDistance;
			bonusHud.hud.res.text = bhResistance;
			bonusHud.hud.red.text = bhRedZone;
			return;
		default :
			//nothing!
	}
};

// ---- layer "HUDs", frame 11
hud.stop();

//debug
test_hud_level = _root.stat_glider_hud[playerGlider];

setHUD = function () {
	if (playerBoost >= 1 && test_hud_level == 1) {
		test_hud_level = 8;
	}
	hud.gotoAndPlay(test_hud_level + "in");
	hud.hud.speed.redzone.gotoAndStop(_root.stat_glider_speed[playerGlider]);
	push(runHUD);
};

runHUD = function () {
	switch (test_hud_level) {
		case 1 :
			hud.hud.gotoAndStop(Math.ceil(REF_altitude * 2 + 60));
			hud.hud.speed.gotoAndStop(Math.ceil(REF_speed / 50 * 400));
			return;
		case 2 :
			hud.hud.alt.gotoAndStop(Math.ceil(REF_altitude * 2 + 120));
			hud.hud.speed.gotoAndStop(Math.ceil(REF_speed / 100 * 400));
			hud.hud.fuel.gotoAndStop(401 - Math.ceil(debug_fuel / debug_fuel_max * 400));
			return;
		case 3 :
			hud.hud.alt.gotoAndStop(Math.ceil(REF_altitude * 2 + 200));
			hud.hud.speed.gotoAndStop(Math.ceil(REF_speed / 150 * 400));
			hud.hud.fuel.gotoAndStop(401 - Math.ceil(debug_fuel / debug_fuel_max * 400));
			hud.hud.compass._rotation = player._rotation;
			return;
		case 4 :
			hud.hud.alt.gotoAndStop(Math.ceil(REF_altitude * 2 + 200));
			hud.hud.speed.gotoAndStop(Math.ceil(REF_speed / 200 * 400));
			hud.hud.fuel.gotoAndStop(401 - Math.ceil(debug_fuel / debug_fuel_max * 400));
			hud.hud.prop.gotoAndStop(401 - Math.ceil(test_prop_fuel / test_prop_fuel_max * 400));
			hud.hud.gotoAndStop(Math.ceil(REF_distance / 2000 * 800));
			hud.hud.compass._rotation = player._rotation;
			return;
		case 5 :
			hud.hud.alt.gotoAndStop(Math.ceil(REF_altitude * 2));
			hud.hud.speed.gotoAndStop(Math.ceil(REF_speed / 100 * 400));
			hud.hud.fuel.gotoAndStop(401 - Math.ceil(debug_fuel / debug_fuel_max * 400));
			hud.hud.prop.gotoAndStop(401 - Math.ceil(test_prop_fuel / test_prop_fuel_max * 400));
			return;
		case 6 :
			hud.hud.alt.gotoAndStop(Math.ceil(REF_altitude + 500));
			hud.hud.speed.gotoAndStop(Math.ceil(REF_speed / 200 * 400));
			hud.hud.fuel.gotoAndStop(401 - Math.ceil(debug_fuel / debug_fuel_max * 400));
			hud.hud.prop.gotoAndStop(401 - Math.ceil(test_prop_fuel / test_prop_fuel_max * 400));
			return;
		case 7 :
			hud.hud.alt.gotoAndStop(Math.ceil(REF_altitude + 500));
			hud.hud.speed.gotoAndStop(Math.ceil(REF_speed / 345 * 400));
			hud.hud.txt_speed.text = Math.ceil(REF_speed);
			hud.hud.fuel.gotoAndStop(401 - Math.ceil(debug_fuel / debug_fuel_max * 400));
			return;
		case 8 :
			hud.hud.gotoAndStop(Math.ceil(REF_altitude * 2 + 60));
			hud.hud.speed.gotoAndStop(Math.ceil(REF_speed / 50 * 400));
			hud.hud.fuel.gotoAndStop(401 - Math.ceil(debug_fuel / debug_fuel_max * 400));
			return;
		case 9 :
			hud.hud.alt.gotoAndStop(Math.ceil(REF_altitude + 500));
			hud.hud.speed.gotoAndStop(Math.ceil(REF_speed / 300 * 400));
			hud.hud.txt_speed.text = Math.ceil(REF_speed);
			hud.hud.fuel.gotoAndStop(401 - Math.ceil(debug_fuel / debug_fuel_max * 400));
			hud.hud.glideometer.gotoAndStop(Math.ceil(arcade_glide_meter / 200 * 400));
			hud.hud.gotoAndStop(arcadeGetGlider());
			return;
		case 10 :
			hud.hud.alt.gotoAndStop(Math.ceil(REF_altitude));
			hud.hud.speed.gotoAndStop(Math.ceil(REF_speed / 320 * 400));
			hud.hud.fuel.gotoAndStop(401 - Math.ceil(debug_fuel / debug_fuel_max * 400));
			hud.hud.prop.gotoAndStop(401 - Math.ceil(test_prop_fuel / test_prop_fuel_max * 400));
			hud.hud.gotoAndStop(Math.ceil(REF_distance / 6900 * 800));
			hud.hud.compass._rotation = player._rotation;
			return;
		case 11 :
			hud.hud.alt.gotoAndStop(Math.ceil(REF_altitude + 500));
			hud.hud.speed.gotoAndStop(Math.ceil(REF_speed / 595 * 400));
			hud.hud.txt_speed.text = Math.ceil(REF_speed);
			hud.hud.fuel.gotoAndStop(401 - Math.ceil(debug_fuel / debug_fuel_max * 400));
			return;
		case 12 :
			hud.hud.alt.gotoAndStop(Math.ceil(REF_altitude + 500));
			hud.hud.speed.gotoAndStop(Math.ceil(REF_speed / 200 * 400));
			hud.hud.fuel.gotoAndStop(401 - Math.ceil(debug_fuel / debug_fuel_max * 400));
			return;
	}
};

// ---- layer "Stats Ref", frame 11
runStatsReturn = function () {
	REF_altitude = Math.ceil(((ground_over_holder.ground1._y-player._y)/FOOT_RATIO-0.6)*10)/10;
	REF_speed = Math.ceil(Math.sqrt(Math.pow(glide_vx, 2)+Math.pow(glide_vy+grav_mag, 2))*10)/10;
	REF_oldspeedx = REF_speedx;
	REF_oldspeedy = REF_speedy;
	REF_speedx = glide_vx;
	REF_speedy = glide_vy+grav_mag;
	REF_distance = Math.ceil((player._x-(ramp._x+hotspot.hotspot3._x+hotspot.hotspot3._width))/FOOT_RATIO*10)/10;
	REF_direction = Math.atan2(REF_oldy-(player._y+cam_vy), REF_oldx-(player._x+cam_vx))/rads;
	if (!((player._rotation>=-90 && player._rotation<=90) && player._y+GROUND_COLLISION_ADJUST>=ground_over_holder.ground1._y) && !((player._rotation<(-90) || player._rotation>90) && player._y+GROUND_COLLISION_ADJUST>=ground_over_holder.ground1._y-player.hitspot._height)) {
		REF_duration += 0.035;
	}
	REF_real_duration += 0.035;
	REF_oldx = player._x;
	REF_oldy = player._y;
	REF_max_altitude = Math.max(REF_max_altitude, REF_altitude);
	REF_max_depth = Math.min(REF_max_depth, REF_altitude);
	REF_max_speed = Math.max(REF_max_speed, REF_speed);
	REF_max_distance = Math.max(REF_max_distance, REF_distance);
	REF_min_distance = Math.min(REF_min_distance, REF_distance);
	player.hitspot.gotoAndStop(1+Math.floor(Math.max(0, Math.min(399, REF_speed))));
};

REF_duration = 0;
REF_destruction = 0;
REF_max_altitude = 0;
REF_max_depth = 0;
REF_max_speed = 0;
REF_max_distance = 0;
REF_min_distance = 0;
REF_oldx = 0;
REF_oldy = 0;

push(runStatsReturn);

// ---- layer "Cash Functions", frame 13
//These functions take the corresponding data (distance, altitude, etc) and return the earnings generated

//BONUS - each function gets % increase "*(1+0.05*bonusItemOwn[1])"

getCashAlt = function (data) {
	///modeMult increases rewards for classic mode, since there's no destruction
	modeMult = 1.1;
	if (GAME_MODE == "classic") {
		modeMult = 1.35;
	}
	if (data<=500) {
		return Math.ceil((0.5*data+data*(data*0.0021))*modeMult*(1+0.05*bonusItemOwn[1]));
	} else {
		return Math.ceil((250*Math.log(0.05*data-20.9)+420)*modeMult*(1+0.05*bonusItemOwn[1]));
	}
};
getCashDis = function (data) {
	///modeMult increases rewards for classic mode, since there's no destruction
	modeMult = 1.1;
	if (GAME_MODE == "classic") {
		modeMult = 1.35;
	}
	return Math.ceil(data*0.58*modeMult*(1+0.05*bonusItemOwn[1]));
};
getCashDur = function (data) {
	///modeMult increases rewards for classic mode, since there's no destruction
	modeMult = 1.1;
	if (GAME_MODE == "classic") {
		modeMult = 1.35;
	}
	//For duration, < x seconds is exponential, >x seconds is nerfed down (to avoid exploits);         
	if (data<=100) {
		return Math.ceil((0.95*data+data*(data*0.02))*modeMult*(1+0.05*bonusItemOwn[1]));
	} else {
		return Math.ceil((data+3)*(1+0.05*bonusItemOwn[1]));
	}
};

getCashSpe = function (data) {
	///modeMult increases rewards for classic mode, since there's no destruction
	modeMult = 1.1;
	if (GAME_MODE == "classic") {
		modeMult = 1.35;
	}
	return Math.ceil((1*data+data*(data*0.002))*modeMult*(1+0.05*bonusItemOwn[1])-21);
};
getCashDes = function (data) {
	return Math.ceil(data*(1+0.05*bonusItemOwn[1]));
};




getArcadeAlt = function (data, budget) {
	if (arcadeBudgetMult == undefined) {
		trace("arcadeBudgetMult error");
		arcadeBudgetMult = 2.5;
	}
	if (data<=500) {
		return Math.ceil((0.5*data+data*(data*0.0021))*arcadeBudgetMult);
	} else {
		return Math.ceil((250*Math.log(0.05*data-20.9)+420)*arcadeBudgetMult);
	}
};
getArcadeDis = function (data, budget) {
	return Math.ceil((data*0.58)*arcadeBudgetMult);
};
getArcadeDur = function (data, budget) {
	//For duration, < x seconds is exponential, >x seconds is nerfed down (to avoid exploits); 
	if (data<=100) {
		return Math.ceil((0.95*data+data*(data*0.02))*arcadeBudgetMult);
	} else {
		return Math.ceil((data+3)*arcadeBudgetMult);
	}
};

getArcadeSpe = function (data, budget) {
	return Math.ceil(((1*data+data*(data*0.002))-21)*arcadeBudgetMult);
};

// ---- layer "Save", frame 14
save_game.save_game.backbtn.onRelease = function() {
	_root.save_game.gotoAndPlay("out");
	_root.sstate = 0;
};

save_game.saveGameConfirm.gotoAndStop("outend")
save_game.save_game.state1.gotoAndStop(4);
for (i = 2; i <= 4; i++) {
	save_game.save_game["state" + i].gotoAndStop(1);
	save_game.save_game["state" + i].onRollOver = function() {
		this.gotoAndStop(2);
	};
	save_game.save_game["state" + i].onRollOut = function() {
		this.gotoAndStop(1);
	};
	save_game.save_game["state" + i].onPress = function() {
		this.gotoAndStop(3);
	};
	save_game.save_game["state" + i].onDragOut = function() {
		this.gotoAndStop(2);
	};
	save_game.save_game["state" + i].onDragOver = function() {
		this.gotoAndStop(3);
	};
	save_game.save_game["state" + i].onMouseUp = function() {
		this.gotoAndStop(1);
	};
	save_game.save_game["state" + i].onReleaseOutside = function() {
		this.gotoAndStop(1);
	};
	save_game.save_game["state" + i].onRelease = function() {
		this.gotoAndStop(2);
		trace("Here are the game IDs...");
		trace(_root["saveState" + this.saveSlot].GAME_ID);
		trace(GAME_ID);
		trace(_root["saveState" + this.saveSlot].GAME_ID >= 0 && root["saveState" + this.saveSlot].GAME_ID <> GAME_ID)
		trace(_root["saveState" + this.saveSlot].GAME_ID <> GAME_ID)
		trace(_root["saveState" + this.saveSlot].GAME_ID)
		trace(_root.GAME_ID);
		trace(_root.GAME_ID == root["saveState" + this.saveSlot].GAME_ID);
		trace("*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+");
		if (_root["saveState" + this.saveSlot].GAME_ID >= 0 && _root["saveState" + this.saveSlot].GAME_ID <> GAME_ID) {
			_root.save_game.saveSlot = this.saveSlot;
			save_game.saveGameConfirm.gotoAndPlay("in");
			save_game.saveGameConfirm.saveGameConfirm.btnYes.onRelease = function() {
				//Save on this state
				_root.saveGame(_root.save_game.saveSlot);
				this.savedAnim.gotoAndPlay("in");
				refreshSaveLabels();
				save_game.saveGameConfirm.gotoAndPlay("out");
			};
			save_game.saveGameConfirm.saveGameConfirm.btnNo.onRelease = function() {
				save_game.saveGameConfirm.gotoAndPlay("out");
			};
		} else {
			//Save on this state
			_root.saveGame(this.saveSlot);
			this.savedAnim.gotoAndPlay("in");
			refreshSaveLabels();
		}
	};
	save_game.save_game["state" + i].saveSlot = i - 1;
	save_game.save_game["state" + i].savedAnim.gotoAndStop("end");
}
save_game.gotoAndStop(1);


refreshSaveLabels = function () {
	getSharedObject();
	for (i = 1; i <= 4; i++) {
		save_game.save_game["state" + i].mode.text = _root["saveState" + (i - 1)].game_mode;
		save_game.save_game["state" + i].completed._visible = false;
		trace(_root["saveState" + (i - 1)].GAME_ID);
		if (_root["saveState" + (i - 1)].GAME_ID == "COMPLETED") {
			save_game.save_game["state" + i].completed._visible = true;
		}
		if (_root["saveState" + (i - 1)].game_mode == " Empty") {
			save_game.save_game["state" + i].day.text = "";
			save_game.save_game["state" + i].cash.text = "";
			if (i == 1) {
				save_game.save_game["state" + i].savedate.text = "File reserved for auto-save";
			} else {
				save_game.save_game["state" + i].savedate.text = "Click to save on this file";
			}
		} else {
			save_game.save_game["state" + i].day.text = "Day " + _root["saveState" + (i - 1)].day;
			save_game.save_game["state" + i].cash.text = _root["saveState" + (i - 1)].player_cash + " $";
			save_game.save_game["state" + i].savedate.text = _root["saveState" + (i - 1)].save_date;
		}
	}
};

// ---- layer "Challenges", frame 14
//Btns
for (l=1; l<=35; l++) {
	challenge.board.body["btn"+(l)].onRollOver = function() {
		this.gotoAndStop(2);
		_root.refreshChallenge(this.ID);
	};
	challenge.board.body["btn"+(l)].onRollOut = function() {
		this.gotoAndStop(1);
		_root.refreshChallenge(_root.offId);
	};
	challenge.board.body["btn"+(l)].onPress = function() {
		this.gotoAndStop(3);
	};
	challenge.board.body["btn"+(l)].onDragOut = function() {
		this.gotoAndStop(2);
	};
	challenge.board.body["btn"+(l)].onDragOver = function() {
		this.gotoAndStop(3);
	};
	challenge.board.body["btn"+(l)].onReleaseOutside = function() {
		this.gotoAndStop(1);
		_root.refreshChallenge(_root.offId);
	};
	challenge.board.body["btn"+(l)].onRelease = function() {
		_root.offId = this.ID;
		this.gotoAndStop(2);
		_root.refreshChallenge(this.ID);
	};
	challenge.board.body["btn"+(l)].ID = l;
}

//Back button
challenge.board.back.gotoAndStop(1);
chalenge.board.back.back.gotoAndStop(1);
challenge.board.back.onRollOver = function() {
	this.onEnterFrame = function() {
		this.gotoAndStop(Math.min(10, this._currentframe+1));
		if (this._currentframe>=10) {
			this.onEnterFrame = null;
		}
	};
	this.back.gotoAndStop(2);
};
challenge.board.back.onRollOut = function() {
	this.onEnterFrame = function() {
		this.gotoAndStop(Math.max(1, this._currentframe-1));
		if (this._currentframe<=1) {
			this.onEnterFrame = null;
		}
	};
	this.back.gotoAndStop(1);
};
challenge.board.back.onMouseDown = function() {
	if (this.hitTest(_root._xmouse, _root._ymouse, true)) {
		this.back.gotoAndStop(3);
	}
};
challenge.board.back.onMouseUp = function() {
	if (!this.hitTest(_root._xmouse, _root._ymouse, true)) {
		this.onEnterFrame = function() {
			this.gotoAndStop(Math.max(1, this._currentframe-1));
			if (this._currentframe<=1) {
				this.onEnterFrame = null;
			}
		};
		this.back.gotoAndStop(1);
	}
};
challenge.board.back.onDragOut = function() {
	if (this.back._currentframe == 3) {
		this.back.gotoAndStop(2);
	}
};
challenge.board.back.onDragOver = function() {
	if (this.back._currentframe == 2) {
		this.back.gotoAndStop(3);
	}
};
challenge.board.back.onRelease = function() {
	this.onEnterFrame = function() {
		this.gotoAndStop(Math.max(1, this._currentframe-1));
		if (this._currentframe<=1) {
			this.onEnterFrame = null;
		}
	};
	this.back.gotoAndStop(1);
	this._parent._parent.gotoAndPlay("out");
	_root.sstate = 0;
};


//FUNCTIONS
checkChallenge = function () {
	if (GAME_MODE == "story") {
		challenge.board.body.gotoAndStop("story");
	} else {
		challenge.board.body.gotoAndStop("classic");
	}
	for (l=0; l<=challengeGoals.length-1; l++) {
		challenge.board.body["btn"+(l+1)].gotoAndStop(1);
		challenge.board.body["btn"+(l+1)].icon.gotoAndStop(l+1);
		trace(challengeBool[l]);
		if (challengeBool[l]) {
			challenge.board.body["btn"+(l+1)].bg.gotoAndStop(l+2);
		} else {
			challenge.board.body["btn"+(l+1)].bg.gotoAndStop(1);
		}
	}
};

refreshChallenge = function (id) {
	//highlight
	if (offId == 0) {
		challenge.board.body.high._x = 10000;
	} else {
		challenge.board.body.high._x = challenge.board.body["btn"+(offId)]._x;
		challenge.board.body.high._y = challenge.board.body["btn"+(offId)]._y;
	}
	if (id == undefined || id == null) {
		id = 0;
	}
	if (id<=0) {
		challenge.board.body.challenge._alpha = 0;
		challenge.board.body.challenge.gotoAndStop(1);
		challenge.board.body.challenge.difficulty._visible = false;
		challenge.board.body.challenge.difficulty.gotoAndStop(1);
		challenge.board.body.challenge.txt_points.text = "";
	} else {
		if (challengeBool[id-1]) {
			challenge.board.body.challenge._alpha = 100;
			challenge.board.body.challenge.difficulty.gotoAndStop(challengeDiff[id-1]);
			challenge.board.body.challenge.txt_points.text = challengeRewards[challengeDiff[id-1]-1]+" $";
		} else {
			challenge.board.body.challenge._alpha = 60;
			challenge.board.body.challenge.difficulty.gotoAndStop(challengeDiff[id-1]+7);
			challenge.board.body.challenge.txt_points.text = "";
		}
		challenge.board.body.challenge.difficulty._visible = true;
		challenge.board.body.challenge.gotoAndStop(id);
	}
};

challenge.gotoAndStop(1);
offId = 0;//id used when NOT overing buttons
challenge.board.body.high._x = 10000;
checkChallenge();
refreshChallenge(0);

// ---- layer "Challenges", frame 15
budget.gotoAndStop(1);
budget.note.btn1.onRelease = function() {
	_root.GAME_MODE = "arcade";
	_root.loadGame(-1);
	resetChallenges();

	_root.arcadePickedBudget = 1;
	_root.arcadeBudgetMult = 2.6;
	_root.setCash(_root.shop_cash1,1000,1000,18);
	_root.test_player_cash = 1000;
	_root.budget.gotoAndPlay(2);
	_root.sstate = 0;
	_root.gotoAndStop("arcade_ready");
	this.onRelease = null;
};
budget.note.btn2.onRelease = function() {
	_root.GAME_MODE = "arcade";
	_root.loadGame(-1);
	resetChallenges();

	_root.arcadePickedBudget = 2;
	_root.arcadeBudgetMult = 2.2;
	_root.setCash(_root.shop_cash1,5000,5000,18);
	_root.test_player_cash = 5000;
	_root.budget.gotoAndPlay(2);
	_root.sstate = 0;
	_root.gotoAndStop("arcade_ready");
	this.onRelease = null;
};
budget.note.btn3.onRelease = function() {
	_root.GAME_MODE = "arcade";
	_root.loadGame(-1);
	resetChallenges();

	_root.arcadePickedBudget = 3;
	_root.arcadeBudgetMult = 1.75;
	_root.setCash(_root.shop_cash1,25000,25000,18);
	_root.test_player_cash = 25000;
	_root.budget.gotoAndPlay(2);
	_root.sstate = 0;
	_root.gotoAndStop("arcade_ready");
	this.onRelease = null;
};

// ---- layer "Challenges", frame 16
if(budget._currentframe<=2){
	budget.gotoAndStop("end");
}
