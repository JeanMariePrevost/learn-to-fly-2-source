// Library symbol "!Cutscenes/!INTRO"

// ---- layer "ASsfx", frame 1
_root.playSfx("INTRO_wind");

// ---- layer "ASsfx", frame 275
//_root.playBgm("old1");

// ---- layer "ASsfx", frame 287
_root.playSfx("INTRO_wakeup");

// ---- layer "ASsfx", frame 524
_root.playBgm("old2",null,null,0.3);

// ---- layer "ASsfx", frame 583
_root.playSfx("INTRO_crashStuff");

// ---- layer "ASsfx", frame 629
_root.playSfx("INTRO_typingShort");

// ---- layer "ASsfx", frame 742
_root.playSfx("INTRO_typing2");
_root.playSfx("INTRO_wakeup");

// ---- layer "ASsfx", frame 936
_root.playSfx("INTRO_shortWhooshHit");

// ---- layer "ASsfx", frame 1022
_root.stopBgm();

// ---- layer "ASsfx", frame 1075
_root.playBgm("rock2",null,false,0.95);

// ---- layer "ASsfx", frame 1137
_root.playSfx("INTRO_glassBreak");

// ---- layer "ASsfx", frame 1488
_root.stopBgm();

// ---- layer "Layer 30", frame 1488
stop();
_root.skipScene();
