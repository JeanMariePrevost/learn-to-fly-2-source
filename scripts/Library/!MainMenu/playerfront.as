// Library symbol "!MainMenu/playerfront"

// ---- layer "Secret Button", frame 1
secretButton.onRelease = function() {
	if (_root.modesUnlocked<>true) {
		_root.mainmenu.gotoAndPlay("secretButtonFrame");
	}
	_root.modesUnlocked = true;
	_root.profileState.modesUnlocked = true;
	_root.triggerMedal(39);
};

stop();
