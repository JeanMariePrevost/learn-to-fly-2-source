// Library symbol "!System/!Effects/explosion"

// ---- layer "Layer 1", frame 1
//DEBUG
boomPower = 20;//Power of explosion/how far everything flies off
boomScale = 100;//Initial scale of puffs
boomFade = 0.5;//Decrease in puffs scale
boomAmount = 5;//Amount of orange trails
boomRate = 5;//# of frames between each trail spawning of puffs
boomGravity = 0.4;//Amount of gravity applied to booms
smokeAmount = 5;//Amount of yellow/white smoke (for each)


//INIT
BOOM_SPIN = 10;//Maximum rotation speed of puffs

boomCount = 0;

//Explosion
for (i=1; i<=boomAmount; i++) {
	this.createEmptyMovieClip("trail"+i,this.getNextHighestDepth());
	this["boom"+boomCount].vx = 1;
	this["boom"+boomCount].vx = 1;
	this["boom"+boomCount].vr = 1;
	this["boom"+boomCount].gravity = boomGravity;
	this["boom"+boomCount].boomScale = boomScale;
	this["boom"+boomCount].boomFade = boomFade;
	this["boom"+boomCount].count = 1;
	this["boom"+boomCount].countMax = BOOM_SPAWN_RATE;
	this["boom"+boomCount].onEnterFrame = function() {
		this._x += this.vx;
		this._y += this.vy;
		this.vx *= 0.95;
		this.vy *= 0.95;
		this.vy += this.gravity;
		this.boomScale -= this.boomFade;
		if (this.boomScale<=10) {
			this.onEnterFrame = null;
			this.removeMovieClip();
		}
		this.count--;
		if (this.count<=0) {
			this.attachMovie("explosion_puff_1","boom"+boomCount,this.getNextHighestDepth());
			this["boom"+boomCount]._xscale = this["boom"+boomCount]._yscale=this.boomScale;
			this["boom"+boomCount].vr = this.vr;
			this["boom"+boomCount].onEnterFrame = function() {
				this._rotation += this.vr;
			};
			this.count = this.countMax;
		}
	};
}
