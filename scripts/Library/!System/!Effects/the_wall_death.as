// Library symbol "!System/!Effects/the_wall_death"

// ---- layer "Layer 1", frame 30
PIECES_LIFE = 135;//Number of frames pieces respawn to the top of the screen
part_count = 0;


generatePieces = function () {
	this.attachMovie("snow_part","part"+part_count,this.getNextHighestDepth());
	this["part"+part_count]._xscale = this["part"+part_count]._yscale=50+Math.random()*250;
	this["part"+part_count].gotoAndStop(Math.ceil(4.99*Math.random()+0.01));
	this["part"+part_count]._alpha = 50+Math.random()*70;
	this["part"+part_count]._x = 740*Math.random()-50;
	this["part"+part_count]._y = -this["part"+part_count]._height-Math.random()*200;
	this["part"+part_count].vy = 10+Math.random()*35+this["part"+part_count]._xscale/15;
	this["part"+part_count].life = PIECES_LIFE;
	this["part"+part_count].onEnterFrame = function() {
		this.life--;
		this._y += this.vy;
		if (this._y>=this._height+480) {
			if (this.life>=1) {
				this._xscale = this._yscale=50+Math.random()*250;
				this.gotoAndStop(Math.ceil(4.99*Math.random()+0.01));
				this._alpha = 50+Math.random()*70;
				this._x = 740*Math.random()-50;
				this._y = -this._height-Math.random()*50;
				this.vy = 10+Math.random()*35+this._xscale/15;
			} else {
				this.removeMovieClip();
			}
		}
	};
	part_count++;
};

//First frame, generate some pieces
for (i=0; i<=3; i++) {
	generatePieces();
}

// ---- layer "Layer 1", frame 79
for (i=0; i<=3; i++) {
	generatePieces();
}

// ---- layer "Layer 1", frame 98
generatePieces();

// ---- layer "Layer 1", frame 119
generatePieces();

// ---- layer "Layer 1", frame 142
generatePieces();

// ---- layer "Layer 1", frame 167
generatePieces();

// ---- layer "Layer 1", frame 527
this.stop();
this.removeMovieClip();
