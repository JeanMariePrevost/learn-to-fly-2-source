// Library symbol "!System/!Preloader/preloader"

// ---- layer "btn", frame 401
stop();

txt1._visible = txt2._visible = txt3._visible = false;

startBtn.startBtn.onRelease = function() {
	_root.forceMute = 1;
	_root.gotoAndPlay("init");
};

startMuted.startBtn.onRelease = function() {
	_root.forceMute = 0;
	_root.gotoAndPlay("init");
};
