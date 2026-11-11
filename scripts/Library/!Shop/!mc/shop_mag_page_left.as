// Library symbol "!Shop/!mc/shop_mag_page_left"

// ---- layer "Highlight", frame 1
stop();
getBuyable = function (mc, stat, hl) {
	if (hl<>0) {
		mc.txt_name.text = _root["stat_"+mc.type+"_name"][mc.lvl];
		if (_root.test_player_cash<=_root["stat_"+mc.type+"_cost"][mc.lvl]-1 && (_root["test_upg_"+mc.type][mc.lvl]+2) == 2) {
			stat.gotoAndStop("afford");
			mc.txt_cost.gotoAndStop("cant");
			mc._alpha = 85;
		} else {
			mc.txt_cost.gotoAndStop("can");
			mc._alpha = 100;
		}
		if (_root["test_upg_"+mc.type][mc.lvl] == 0) {
			mc.txt_cost.txt_cost.text = _root["stat_"+mc.type+"_cost"][mc.lvl]+"$";
		} else {
			mc.txt_cost.txt_cost.text = "";
		}
	} else {
		stat.gotoAndStop(2);
	}
};


hl1._alpha = 0;
hl2._alpha = 0;


//put commands here\/
hl1.onRelease = function() {
	this._alpha = 60;
	_root.buySpecial(icon1.type,icon1.lvl);
	_root.refreshMag();
};
hl2.onRelease = function() {
	this._alpha = 60;
	_root.buySpecial(icon2.type,icon2.lvl);
	_root.refreshMag();
};


//---static
hl1.onEnterFrame = function() {
	if (this.ac == 1) {
		this._alpha = Math.min(60, this._alpha+20);
	} else if (this.ac == 0) {
		this._alpha = Math.max(0, this._alpha-8);
	}
};

hl1.onRollOver = function() {
	this.ac = 1;
	_root.showHint(icon1.type,icon1.lvl);
};
hl1.onRollOut = function() {
	this.ac = 0;
	_root.hideHint();
};
hl1.onPress = function() {
	this._alpha = 100;
	this.ac = 2;
};
hl1.onReleaseOutside = function() {
	this._alpha = 60;
	this.ac = 0;
};

hl2.onEnterFrame = function() {
	if (this.ac == 1) {
		this._alpha = Math.min(60, this._alpha+20);
	} else if (this.ac == 0) {
		this._alpha = Math.max(0, this._alpha-8);
	}
};

hl2.onRollOver = function() {
	this.ac = 1;
	_root.showHint(icon1.type,icon2.lvl);
};
hl2.onRollOut = function() {
	this.ac = 0;
	_root.hideHint();
};
hl2.onPress = function() {
	this._alpha = 100;
	this.ac = 2;
};
hl2.onReleaseOutside = function() {
	this._alpha = 60;
	this.ac = 0;
};

// ---- layer "Page Label", frame 2 ("sleigh1")
getPage = function () {
	icon1.type = "sleigh";
	icon1.lvl = 1;
	icon2.type = "sleigh";
	icon2.lvl = 2;
	icon1._visible = true;
	hl1._visible = true;
	icon2._visible = true;
	hl2._visible = true;
	icon1.icon.gotoAndStop(icon1.lvl);
	icon1.meter1.gotoAndStop(_root.getMeter("stat_sleigh_speed", icon1.lvl));
	icon1.meter2.gotoAndStop(_root.getMeter("stat_sleigh_jump", icon1.lvl));
	icon2.icon.gotoAndStop(icon2.lvl);
	icon2.meter1.gotoAndStop(_root.getMeter("stat_sleigh_speed", icon2.lvl));
	icon2.meter2.gotoAndStop(_root.getMeter("stat_sleigh_jump", icon2.lvl));
	stat1.gotoAndStop(_root["test_upg_"+icon1.type][icon1.lvl]+2);
	stat2.gotoAndStop(_root["test_upg_"+icon2.type][icon2.lvl]+2);
	getBuyable(icon1,stat1,hl1);
	getBuyable(icon2,stat2,hl2);
};
getPage();

// ---- layer "Page Label", frame 3 ("sleigh2")
getPage = function () {
	icon1.type = "sleigh";
	icon1.lvl = 5;
	icon2.type = "sleigh";
	icon2.lvl = 6;
	icon1._visible = true;
	hl1._visible = true;
	icon2._visible = true;
	hl2._visible = true;
	icon1.icon.gotoAndStop(icon1.lvl);
	icon1.meter1.gotoAndStop(_root.getMeter("stat_sleigh_speed", icon1.lvl));
	icon1.meter2.gotoAndStop(_root.getMeter("stat_sleigh_jump", icon1.lvl));
	icon2.icon.gotoAndStop(icon2.lvl);
	icon2.meter1.gotoAndStop(_root.getMeter("stat_sleigh_speed", icon2.lvl));
	icon2.meter2.gotoAndStop(_root.getMeter("stat_sleigh_jump", icon2.lvl));
	stat1.gotoAndStop(_root["test_upg_"+icon1.type][icon1.lvl]+2);
	stat2.gotoAndStop(_root["test_upg_"+icon2.type][icon2.lvl]+2);
	getBuyable(icon1,stat1,hl1);
	getBuyable(icon2,stat2,hl2);
};
getPage();

// ---- layer "Page Label", frame 4 ("glider1")
getPage = function () {icon1.type = "glider";
icon1.lvl = 1;
icon2.type = "glider";
icon2.lvl = 2;

icon1._visible = true;
hl1._visible = true;
icon2._visible = true;
hl2._visible = true;

icon1.icon.gotoAndStop(icon1.lvl);
icon1.meter1.gotoAndStop(_root.getMeter("stat_glider_flight", icon1.lvl));
icon1.meter2.gotoAndStop(_root.getMeter("stat_glider_speed", icon1.lvl));
icon2.icon.gotoAndStop(icon2.lvl);
icon2.meter1.gotoAndStop(_root.getMeter("stat_glider_flight", icon2.lvl));
icon2.meter2.gotoAndStop(_root.getMeter("stat_glider_speed", icon2.lvl));
stat1.gotoAndStop(_root["test_upg_"+icon1.type][icon1.lvl]+2);
stat2.gotoAndStop(_root["test_upg_"+icon2.type][icon2.lvl]+2);
getBuyable(icon1,stat1,hl1);
getBuyable(icon2,stat2,hl2);
};
getPage();

// ---- layer "Page Label", frame 5 ("glider2")
getPage = function () {icon1.type = "glider";
icon1.lvl = 5;
icon2.type = "glider";
icon2.lvl = 6;

icon1._visible = true;
hl1._visible = true;
icon2._visible = true;
hl2._visible = true;

icon1.icon.gotoAndStop(icon1.lvl);
icon1.meter1.gotoAndStop(_root.getMeter("stat_glider_flight", icon1.lvl));
icon1.meter2.gotoAndStop(_root.getMeter("stat_glider_speed", icon1.lvl));
icon2.icon.gotoAndStop(icon2.lvl);
icon2.meter1.gotoAndStop(_root.getMeter("stat_glider_flight", icon2.lvl));
icon2.meter2.gotoAndStop(_root.getMeter("stat_glider_speed", icon2.lvl));
stat1.gotoAndStop(_root["test_upg_"+icon1.type][icon1.lvl]+2);
stat2.gotoAndStop(_root["test_upg_"+icon2.type][icon2.lvl]+2);
getBuyable(icon1,stat1,hl1);
getBuyable(icon2,stat2,hl2);
};
getPage();

// ---- layer "Page Label", frame 6 ("glider3")
getPage = function () {icon1.type = "glider";
icon1.lvl = 9;
icon2.type = "glider";
icon2.lvl = 10;

icon1._visible = true;
hl1._visible = true;
icon2._visible = true;
hl2._visible = true;

icon1.icon.gotoAndStop(icon1.lvl);
icon1.meter1.gotoAndStop(_root.getMeter("stat_glider_flight", icon1.lvl));
icon1.meter2.gotoAndStop(_root.getMeter("stat_glider_speed", icon1.lvl));
icon2.icon.gotoAndStop(icon2.lvl);
icon2.meter1.gotoAndStop(_root.getMeter("stat_glider_flight", icon2.lvl));
icon2.meter2.gotoAndStop(_root.getMeter("stat_glider_speed", icon2.lvl));
stat1.gotoAndStop(_root["test_upg_"+icon1.type][icon1.lvl]+2);
stat2.gotoAndStop(_root["test_upg_"+icon2.type][icon2.lvl]+2);
getBuyable(icon1,stat1,hl1);
getBuyable(icon2,stat2,hl2);
};
getPage();

// ---- layer "Page Label", frame 7 ("glider4")
getPage = function () {
	if (_root.GAME_MODE == "story") {
		icon2.type = "glider";
		icon2.lvl = 14;
		icon2._visible = true;
		hl2._visible = true;
		icon2.icon.gotoAndStop(icon2.lvl);
		icon2.meter1.gotoAndStop(_root.getMeter("stat_glider_flight", icon2.lvl));
		icon2.meter2.gotoAndStop(_root.getMeter("stat_glider_speed", icon2.lvl));
		stat2.gotoAndStop(_root["test_upg_"+icon2.type][icon2.lvl]+2);
		getBuyable(icon2,stat2,hl2);
		if (_root["test_upg_"+icon2.type][icon2.lvl]<=0) {
			//since the brick is a secret, keep it hidden until its bought
			icon2._alpha = 0;
		} else {
			icon2._alpha = 255;
		}
	} else {
		icon2._visible = false;
		hl2._visible = false;
		//icon2.icon.gotoAndStop(icon2.lvl);
		//icon2.meter1.gotoAndStop(_root.getMeter("stat_glider_flight", icon2.lvl));
		//icon2.meter2.gotoAndStop(_root.getMeter("stat_glider_speed", icon2.lvl));
		stat2.gotoAndStop(2);
		getBuyable(icon2,stat2,0);
	}
	icon1.type = "glider";
	icon1.lvl = 13;
	icon1._visible = true;
	hl1._visible = true;
	icon1.icon.gotoAndStop(icon1.lvl);
	icon1.meter1.gotoAndStop(_root.getMeter("stat_glider_flight", icon1.lvl));
	icon1.meter2.gotoAndStop(_root.getMeter("stat_glider_speed", icon1.lvl));
	stat1.gotoAndStop(_root["test_upg_"+icon1.type][icon1.lvl]+2);
	getBuyable(icon1,stat1,hl1);
};
getPage();

// ---- layer "Page Label", frame 8 ("boost1")
getPage = function () {icon1.type = "boost";
icon1.lvl = 1;
icon2.type = "boost";
icon2.lvl = 2;

icon1._visible = true;
hl1._visible = true;
icon2._visible = true;
hl2._visible = true;

icon1.icon.gotoAndStop(icon1.lvl);
icon1.meter1.gotoAndStop(_root.getMeter("stat_boost_thrust", icon1.lvl));
icon1.meter2.gotoAndStop(_root["stat_boost_type"][icon1.lvl]+1);
icon2.icon.gotoAndStop(icon2.lvl);
icon2.meter1.gotoAndStop(_root.getMeter("stat_boost_thrust", icon2.lvl));
icon2.meter2.gotoAndStop(_root["stat_boost_type"][icon2.lvl]+1);
stat1.gotoAndStop(_root["test_upg_"+icon1.type][icon1.lvl]+2);
stat2.gotoAndStop(_root["test_upg_"+icon2.type][icon2.lvl]+2);
getBuyable(icon1,stat1,hl1);
getBuyable(icon2,stat2,hl2);
};
getPage();

// ---- layer "Page Label", frame 9 ("boost2")
getPage = function () {icon1.type = "boost";
icon1.lvl = 5;
icon2.type = "boost";
icon2.lvl = 6;

icon1._visible = true;
hl1._visible = true;
icon2._visible = true;
hl2._visible = true;

icon1.icon.gotoAndStop(icon1.lvl);
icon1.meter1.gotoAndStop(_root.getMeter("stat_boost_thrust", icon1.lvl));
icon1.meter2.gotoAndStop(_root["stat_boost_type"][icon1.lvl]+1);
icon2.icon.gotoAndStop(icon2.lvl);
icon2.meter1.gotoAndStop(_root.getMeter("stat_boost_thrust", icon2.lvl));
icon2.meter2.gotoAndStop(_root["stat_boost_type"][icon2.lvl]+1);
stat1.gotoAndStop(_root["test_upg_"+icon1.type][icon1.lvl]+2);
stat2.gotoAndStop(_root["test_upg_"+icon2.type][icon2.lvl]+2);
getBuyable(icon1,stat1,hl1);
getBuyable(icon2,stat2,hl2);
};
getPage();

// ---- layer "Page Label", frame 10 ("boost3")
getPage = function () {icon1.type = "boost";
icon1.lvl = 9;
icon2.type = "boost";
icon2.lvl = 10;

icon1._visible = true;
hl1._visible = true;
icon2._visible = true;
hl2._visible = true;

icon1.icon.gotoAndStop(icon1.lvl);
icon1.meter1.gotoAndStop(_root.getMeter("stat_boost_thrust", icon1.lvl));
icon1.meter2.gotoAndStop(_root["stat_boost_type"][icon1.lvl]+1);
icon2.icon.gotoAndStop(icon2.lvl);
icon2.meter1.gotoAndStop(_root.getMeter("stat_boost_thrust", icon2.lvl));
icon2.meter2.gotoAndStop(_root["stat_boost_type"][icon2.lvl]+1);
stat1.gotoAndStop(_root["test_upg_"+icon1.type][icon1.lvl]+2);
stat2.gotoAndStop(_root["test_upg_"+icon2.type][icon2.lvl]+2);
getBuyable(icon1,stat1,hl1);
getBuyable(icon2,stat2,hl2);
};
getPage();

// ---- layer "Page Label", frame 11 ("payload1")
getPage = function () {icon1.type = "payload";
icon1.lvl = 1;
icon2.type = "payload";
icon2.lvl = 2;

icon1._visible = true;
hl1._visible = true;
icon2._visible = true;
hl2._visible = true;

icon1.icon.gotoAndStop(icon1.lvl);
icon1.meter1.gotoAndStop(_root.getMeter("stat_payload_power", icon1.lvl));
icon1.meter2.gotoAndStop(_root.getMeter("stat_payload_weight", icon1.lvl));
icon2.icon.gotoAndStop(icon2.lvl);
icon2.meter1.gotoAndStop(_root.getMeter("stat_payload_power", icon2.lvl));
icon2.meter2.gotoAndStop(_root.getMeter("stat_payload_weight", icon2.lvl));
stat1.gotoAndStop(_root["test_upg_"+icon1.type][icon1.lvl]+2);
stat2.gotoAndStop(_root["test_upg_"+icon2.type][icon2.lvl]+2);
getBuyable(icon1,stat1,hl1);
getBuyable(icon2,stat2,hl2);
};
getPage();

// ---- layer "Page Label", frame 12 ("payload2")
getPage = function () {icon1.type = "payload";
icon1.lvl = 5;
icon2.type = "payload";
icon2.lvl = 6;

icon1._visible = true;
hl1._visible = true;
icon2._visible = true;
hl2._visible = true;

icon1.icon.gotoAndStop(icon1.lvl);
icon1.meter1.gotoAndStop(_root.getMeter("stat_payload_power", icon1.lvl));
icon1.meter2.gotoAndStop(_root.getMeter("stat_payload_weight", icon1.lvl));
icon2.icon.gotoAndStop(icon2.lvl);
icon2.meter1.gotoAndStop(_root.getMeter("stat_payload_power", icon2.lvl));
icon2.meter2.gotoAndStop(_root.getMeter("stat_payload_weight", icon2.lvl));
stat1.gotoAndStop(_root["test_upg_"+icon1.type][icon1.lvl]+2);
stat2.gotoAndStop(_root["test_upg_"+icon2.type][icon2.lvl]+2);
getBuyable(icon1,stat1,hl1);
getBuyable(icon2,stat2,hl2);
};
getPage();

// ---- layer "PreviousPage", frame 3
this.btn_prev.useHandCursor = false;

this.btn_prev.onRelease = function() {
	_root.flipPage("sleigh1","sleigh1",true)
};

// ---- layer "PreviousPage", frame 5
this.btn_prev.useHandCursor = false;

this.btn_prev.onRelease = function() {
	_root.flipPage("glider1","glider1",true)
};

// ---- layer "PreviousPage", frame 6
this.btn_prev.useHandCursor = false;

this.btn_prev.onRelease = function() {
	_root.flipPage("glider2","glider2",true)
};

// ---- layer "PreviousPage", frame 7
this.btn_prev.useHandCursor = false;

this.btn_prev.onRelease = function() {
	_root.flipPage("glider3","glider3",true)
};

// ---- layer "PreviousPage", frame 9
this.btn_prev.useHandCursor = false;

this.btn_prev.onRelease = function() {
	_root.flipPage("boost1","boost1",true)
};

// ---- layer "PreviousPage", frame 10
this.btn_prev.useHandCursor = false;

this.btn_prev.onRelease = function() {
	_root.flipPage("boost2","boost2",true)
};

// ---- layer "PreviousPage", frame 12
this.btn_prev.useHandCursor = false;

this.btn_prev.onRelease = function() {
	_root.flipPage("payload1","payload1",true)
};
