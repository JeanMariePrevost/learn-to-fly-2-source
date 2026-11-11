// Library symbol "!Shop/!mc/shop_mag_page_right_OMEGA"

// ---- layer "Highlight", frame 1
stop();
getBuyable = function (mc, stat, hl) {
	if (hl<>0) {
		mc.txt_name.text = _root["stat_"+mc.type+"_name"][mc.lvl];
		if (_root.test_player_cash<=_root["stat_"+mc.type+"_cost"][mc.lvl]-1 && (_root["test_upg_"+mc.type][mc.lvl]+2) == 2) {
			stat.gotoAndStop("afford");
			mc.txt_cost.gotoAndStop("cant");
			mc._alpha = 60;
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
	icon1.lvl = 3;
	icon2.type = "sleigh";
	icon2.lvl = 4;
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
	icon1.lvl = 7;
	//icon2.type = "sleigh";
	//icon2.lvl = 6;
	icon1._visible = true;
	hl1._visible = true;
	icon2._visible = false;
	hl2._visible = false;
	icon1.icon.gotoAndStop(icon1.lvl);
	icon1.meter1.gotoAndStop(_root.getMeter("stat_sleigh_speed", icon1.lvl));
	icon1.meter2.gotoAndStop(_root.getMeter("stat_sleigh_jump", icon1.lvl));
	//icon2.icon.gotoAndStop(icon2.lvl);
	//icon2.meter1.gotoAndStop(_root.getMeter("stat_sleigh_speed", icon2.lvl));
	//icon2.meter2.gotoAndStop(_root.getMeter("stat_sleigh_jump", icon2.lvl));
	stat1.gotoAndStop(_root["test_upg_"+icon1.type][icon1.lvl]+2);
	stat2.gotoAndStop(2);
	getBuyable(icon1,stat1,hl1);
	getBuyable(icon2,stat2,0);
};
getPage();

// ---- layer "Page Label", frame 4 ("sleigh3")
getPage = function () {
	//icon1.type = "sleigh";
	//icon1.lvl = 7;
	//icon2.type = "sleigh";
	//icon2.lvl = 6;
	icon1._visible = false;
	hl1._visible = false;
	icon2._visible = false;
	hl2._visible = false;
	//icon1.icon.gotoAndStop(icon1.lvl);
	//icon1.meter1.gotoAndStop(_root.getMeter("stat_sleigh_speed", icon1.lvl));
	//icon1.meter2.gotoAndStop(_root.getMeter("stat_sleigh_jump", icon1.lvl));
	//icon2.icon.gotoAndStop(icon2.lvl);
	//icon2.meter1.gotoAndStop(_root.getMeter("stat_sleigh_speed", icon2.lvl));
	//icon2.meter2.gotoAndStop(_root.getMeter("stat_sleigh_jump", icon2.lvl));
	stat1.gotoAndStop(3);
	stat2.gotoAndStop(2);
	getBuyable(icon1,stat1,0);
	getBuyable(icon2,stat2,0);
};
getPage();

// ---- layer "Page Label", frame 5 ("glider1")
getPage = function () {
	icon1.type = "glider";
	icon1.lvl = 3;
	icon2.type = "glider";
	icon2.lvl = 4;
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

// ---- layer "Page Label", frame 6 ("glider2")
getPage = function () {
	icon1.type = "glider";
	icon1.lvl = 7;
	icon2.type = "glider";
	icon2.lvl = 8;
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

// ---- layer "Page Label", frame 7 ("glider3")
getPage = function () {
	icon1.type = "glider";
	icon1.lvl = 11;
	icon2.type = "glider";
	icon2.lvl = 12;
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

// ---- layer "Page Label", frame 8 ("glider4")
getPage = function () {
	icon1.type = "glider";
	icon1.lvl = 15;
	icon2.type = "glider";
	icon2.lvl = 16;
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

// ---- layer "Page Label", frame 9 ("boost1")
getPage = function () {
	icon1.type = "boost";
	icon1.lvl = 3;
	icon2.type = "boost";
	icon2.lvl = 4;
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

// ---- layer "Page Label", frame 10 ("boost2")
getPage = function () {
	icon1.type = "boost";
	icon1.lvl = 7;
	icon2.type = "boost";
	icon2.lvl = 8;
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

// ---- layer "Page Label", frame 11 ("boost3")
getPage = function () {
	icon1.type = "boost";
	icon1.lvl = 11;
	//icon2.type = "boost";
	//icon2.lvl = 10;
	icon1._visible = true;
	hl1._visible = true;
	icon2._visible = false;
	hl2._visible = false;
	icon1.icon.gotoAndStop(icon1.lvl);
	icon1.meter1.gotoAndStop(_root.getMeter("stat_boost_thrust", icon1.lvl));
	icon1.meter2.gotoAndStop(_root["stat_boost_type"][icon1.lvl]+1);
	//icon2.icon.gotoAndStop(icon2.lvl);
	//icon2.meter1.gotoAndStop(_root.getMeter("stat_boost_thrust", icon2.lvl));
	//icon2.meter2.gotoAndStop(_root["stat_boost_type"][icon2.lvl]+1);
	stat1.gotoAndStop(_root["test_upg_"+icon1.type][icon1.lvl]+2);
	stat2.gotoAndStop(2);
	getBuyable(icon1,stat1,hl1);
	getBuyable(icon2,stat2,0);
};
getPage();

// ---- layer "Page Label", frame 12 ("boost4")
getPage = function () {
	icon1.type = "boost";
	icon1.lvl = 14;
	//icon2.type = "payload";
	//icon2.lvl = 6;
	icon1._visible = true;
	hl1._visible = true;
	icon2._visible = false;
	hl2._visible = false;
	icon1.icon.gotoAndStop(icon1.lvl);
	icon1.meter1.gotoAndStop(_root.getMeter("stat_boost_thrust", icon1.lvl));
	icon1.meter2.gotoAndStop(_root["stat_boost_type"][icon1.lvl]+1);
	//icon2.icon.gotoAndStop(icon2.lvl);
	//icon2.meter1.gotoAndStop(_root.getMeter("stat_boost_power", icon2.lvl));
	//icon2.meter2.gotoAndStop(_root.getMeter("stat_boost_weight", icon2.lvl));
	stat1.gotoAndStop(_root["test_upg_"+icon1.type][icon1.lvl]+2);
	stat2.gotoAndStop(2);
	getBuyable(icon1,stat1,hl1);
	getBuyable(icon2,stat2,0);
};
getPage();

// ---- layer "Page Label", frame 13 ("payload1")
getPage = function () {
	icon1.type = "payload";
	icon1.lvl = 3;
	icon2.type = "payload";
	icon2.lvl = 4;
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

// ---- layer "Page Label", frame 14 ("payload2")
getPage = function () {
	icon1.type = "payload";
	icon1.lvl = 7;
	icon2.type = "payload";
	icon2.lvl = 8;
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

// ---- layer "Next Page", frame 2
this.btn_next.onRelease = function() {
	_root.flipPage("sleigh2","sleigh2")
};

// ---- layer "Next Page", frame 3
this.btn_next.onRelease = function() {
	_root.flipPage("sleigh3","sleigh3")
};

// ---- layer "Next Page", frame 5
this.btn_next.onRelease = function() {
	_root.flipPage("glider2","glider2")
};

// ---- layer "Next Page", frame 6
this.btn_next.onRelease = function() {
	_root.flipPage("glider3","glider3")
};

// ---- layer "Next Page", frame 7
this.btn_next.onRelease = function() {
	_root.flipPage("glider4","glider4")
};

// ---- layer "Next Page", frame 9
this.btn_next.onRelease = function() {
	_root.flipPage("boost2","boost2")
};

// ---- layer "Next Page", frame 10
this.btn_next.onRelease = function() {
	_root.flipPage("boost3","boost3")
};

// ---- layer "Next Page", frame 11
this.btn_next.onRelease = function() {
	_root.flipPage("boost4","boost4")
};

// ---- layer "Next Page", frame 13
this.btn_next.onRelease = function() {
	_root.flipPage("payload2","payload2")
};
