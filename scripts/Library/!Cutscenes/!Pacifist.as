// Library symbol "!Cutscenes/!Pacifist"

// ---- layer "ASsfx", frame 1
_root.playSfx("PACIFIST_whoosh");

// ---- layer "ASsfx", frame 234
_root.playSfx("PACIFIST_whoosh2");

// ---- layer "ASsfx", frame 360
_root.playSfx("INTRO_typing2");

// ---- layer "ASsfx", frame 444
_root.playSfx("PACIFIST_flyBy");

// ---- layer "ASsfx", frame 521
_root.playSfx("INTRO_typing2");

// ---- layer "ASsfx", frame 626
_root.playSfx("typingLong");

// ---- layer "ASsfx", frame 808
_root.playSfx("PACIFIST_borderlandsIntroSound");

// ---- layer "ASsfx", frame 954
_root.playSfx("PACIFIST_whooshNCrash");

// ---- layer "ASsfx", frame 1106
//Pacifist SPLIT for nuke / nuclear
if (_root.playerPayload == 7) {
	//Player has nuke
	gotoAndPlay("nuke");
} else {
	gotoAndPlay("nonuke");
}

// ---- layer "ASsfx", frame 1107 ("nonuke")
_root.playSfx("PACIFIST_houseCrash");

// ---- layer "ASsfx", frame 1280
gotoAndPlay("finale");

// ---- layer "ASsfx", frame 1295
_root.playSfx("PACIFIST_nuclear");

// ---- layer "Guide: Cam", frame 1628
stop();
_root.skipScene();

// ---- layer "Layer 22", frame 1559
_root.triggerMedal(31);
