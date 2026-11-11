// Library symbol "!Cutscenes/!planetCrusher/planetCrusher"

// ---- layer "Layer 3", frame 62
_root.playSfx("planetCrusherDeep");

// ---- layer "Layer 3", frame 144
_root.playSfx("planetCrusherSlow");

// ---- layer "Layer 4", frame 85
for (i=0; i<=25; i++) {
	this.attachMovie("planetCrusher_particle","planetPart"+i,this.getNextHighestDepth());
	this["planetPart"+i]._xscale = this["planetPart"+i]._yscale = 20+Math.random()*60
	this["planetPart"+i]._alpha = 20+Math.random()*80
	this["planetPart"+i]._x = 0;
	this["planetPart"+i]._y = -125;
	this["planetPart"+i].vx = -2+Math.random()*4;
	this["planetPart"+i].vy = -Math.random()*3;
	this["planetPart"+i].vr = -10+Math.random()*20;
	this["planetPart"+i].onEnterFrame = function() {
		this.vx*=0.97
		this._x += this.vx;
		this._y += this.vy;
		this._rotation += this.vr;
	};
}

// ---- layer "Layer 1", frame 136
import flash.filters.BlurFilter;

blur = new BlurFilter(0, 0, 1);
blurFilters = new Array(blur);

this.shakeMod = 0.1;
this.shake = 0;
this.onEnterFrame = function() {
	this.shake += this.shakeMod;
	this.shake *= 1.04;
	this.anim._x = -this.shake/2+Math.random()*this.shake;
	this.anim._y = -this.shake/2+Math.random()*this.shake;
	blur = new BlurFilter(this.shake*3, this.shake*5, 1);
	blurFilters = new Array(blur);
	this.anim.filters = blurFilters;
};

// ---- layer "Layer 1", frame 161
import flash.filters.BlurFilter;

blur = new BlurFilter(this.shake*3, this.shake*5, 1);
blurFilters = new Array(blur);

this.shakeMod = -0.5;
this.onEnterFrame = function() {
	this.shake = Math.max(0, this.shake+this.shakeMod);
	this.anim._x = -this.shake/2+Math.random()*this.shake;
	this.anim._y = -this.shake/2+Math.random()*this.shake;
	blur = new BlurFilter(this.shake*3, this.shake*5, 1);
	blurFilters = new Array(blur);
	this.anim.filters = blurFilters;
};

// ---- layer "Layer 1", frame 211
this.shakeMod = null;
this.shake = null;
this.blur = null;
this.blurFilters = null;
this.anim.filters = [];

_root.getChallenge("medal",45);

// ---- layer "Layer 1", frame 276
stop();

_root.stopMainArray = false;
