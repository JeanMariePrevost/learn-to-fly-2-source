// Library symbol "!Game/!Player/player_glider11"

// ---- layer "Layer 2", frame 4
//if propeller fuel if left, this.gotoAndPlay(1);
if (_root.test_prop_fuel>0) {
	this.gotoAndPlay(1);
}

// ---- layer "Layer 2", frame 15 ("idle")
stop();
