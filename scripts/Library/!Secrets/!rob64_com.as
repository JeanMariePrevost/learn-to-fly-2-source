// Library symbol "!Secrets/!rob64_com"

// ---- layer "Layer 2", frame 11
_root.playSfx("radioTransmissionStart",false,1.35);

// ---- layer "Layer 2", frame 42
_root.playSfx("rob-LocationComfirmedSendingSupplies");

// ---- layer "Layer 2", frame 142
_root.playSfx("radioTransmissionEnd");

// ---- layer "Icon", frame 1
stop();

// ---- layer "Icon", frame 2 ("in")
if (_root.mute == 1) {
	oldMute = _root.bgmVolume;
	_root.bgmVolume *= 0.1;
	_root.refreshMasterVolume();
} else {
	oldMute = _root.bgmVolume;
}

// ---- layer "Icon", frame 14
icon.gotoAndStop("idle");

// ---- layer "Icon", frame 43
icon.gotoAndPlay("talk");

// ---- layer "Icon", frame 77
icon.gotoAndStop("idle");

// ---- layer "Icon", frame 91
icon.gotoAndPlay("talk");

// ---- layer "Icon", frame 122
icon.gotoAndStop("idle");

//SECRET

_root.secretSupplyBox.play();
_root.secretSupplyBox._x = 520;
_root.secretSupplyBox._y = -100;
_root.secretSupplyBox.onEnterFrame = function() {
	this._x -= (this._x-_root.player._x)/12;
	this._y -= (this._y-_root.player._y)/16;
	if (Math.sqrt(Math.pow(this._x-_root.player._x, 2)+Math.pow(this._y-_root.player._y, 2))<=70) {
		//item close enough
		//Fuel
		_root.player.boost.gotoAndStop(1);
		_root.flashmc.gotoAndPlay("p1");
		_root.debug_fuel = _root.test_upg_fuel[_root.test_player_fuel]*(1+0.05*_root.bonusItemOwn[7]);
		_root.debug_fuel_max = _root.debug_fuel;
		_root.debug_fuel_stage = 0;
		_root.debug_boost_level = _root.playerBoost;
		_root.debug_boost_power = _root.stat_boost_thrust[_root.playerBoost]*(1+0.05*_root.bonusItemOwn[3]);
		_root.player.boost.gotoAndStop(_root.playerBoost+1);//Equipped Boost
		_root.player.boost.boost.gotoAndStop(1);

		this.onEnterFrame = null;
		this.stop();
		this._x = 10000;
		this._visible = false;
	}
};

// ---- layer "Icon", frame 156
stop();

_root.bgmVolume = oldMute;
oldMute = null;
