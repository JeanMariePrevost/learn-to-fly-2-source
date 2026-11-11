// Library symbol "!System/!AchievementGet/achievement"

// ---- layer "Layer 2", frame 2
medalFlash._visible = false;

if (this.isAMedal) {
	medalFlash._visible = true;
	_root.playSfx("pop1");
	//HERE - put medal get SFX
} else {
	medalFlash._visible = false;
	medalFlash._x = 14000;
	_root.playSfx("pop1");
}

// ---- layer "Layer 1", frame 136
stop();
_root.retractPopup();
this.removeMovieClip();
