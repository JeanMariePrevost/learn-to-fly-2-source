// Library symbol "!Secrets/!riseFromYourGrave"

// ---- layer "Layer 2", frame 200


_root.flashmc.gotoAndPlay("p2");



//_root.player.boost.gotoAndStop(1);
//_root.boom(_root.player._x,_root.player._y,-90,80,20,130,7,4,5,8);

//_root.debug_fuel = _root.test_upg_fuel[_root.test_player_fuel]*(1+0.05*_root.bonusItemOwn[7]);
//_root.debug_fuel_max = _root.debug_fuel;
//_root.debug_fuel_stage = 0;
//_root.debug_boost_level = _root.playerBoost;
//_root.debug_boost_power = _root.stat_boost_thrust[_root.playerBoost]*(1+0.05*_root.bonusItemOwn[3]);
//_root.player.boost.gotoAndStop(_root.playerBoost+1);//Equipped Boost
//_root.player.boost.boost.gotoAndStop(1);


_root.delayCam(0,65,0);
_root.player._y = _root.ground_holder["ground" + 1]._y - 7000;
_root.runJump(-20,200);
_root.bgmVolume = oldMute;
oldMute = null;
_root.refreshMasterVolume();

this.onEnterFrame = null;
_root.stopMainArray = false;

this.gotoAndStop("off");

// ---- layer "Layer 2", frame 201 ("off")
stop();

// ---- layer "Layer 3", frame 7
_root.playSfx("rise",false,1.45);

// ---- layer "Layer 1", frame 1
stop();

// ---- layer "Layer 1", frame 2 ("in")
txt.text = "";
txtString = "I command you to rise\nfrom the snow\nand fly some more";
txtCount = 0;
txtCounta = 2;

if (_root.mute == 1) {
	oldMute = _root.bgmVolume;
	_root.bgmVolume *= 0.1;
	_root.refreshMasterVolume();
} else {
	oldMute = _root.bgmVolume;
}

this.onEnterFrame = function() {
	txt.text = txtString.substr(0, txtCount);
	if (txtCount >= txtString.legnth()) {
	}
	txtCounta--;
	if (txtCounta <= 0) {
		txtCounta = 2;
		txtCount++;
	}
};
