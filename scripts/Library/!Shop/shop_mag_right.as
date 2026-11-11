// Library symbol "!Shop/shop_mag_right"

// ---- layer "back", frame 1
btn_back.onRelease = function() {
	_root.shop_mag.gotoAndPlay("out");
	_root.sstate = 0;
	_root.refreshSpecial()
};
