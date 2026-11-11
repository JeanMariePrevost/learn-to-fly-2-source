// Library symbol "!System/!Effects/destruction_meter"

// ---- layer "smoke", frame 2
for (i=1; i<=5; i++) {
	this["smoke"+i].removeMovieClip();
}
for (i=1; i<=5; i++) {
	this.attachMovie("destruction_meter_smoke","smoke"+i,this.getNextHighestDepth());
	this["smoke"+i]._x = i*80-50;
	this["smoke"+i]._y = -30+Math.random()*80;
	this["smoke"+i]._xscale = this["smoke"+i]._yscale=80+Math.random()*60;
	this["smoke"+i]._alpha = 60+Math.random()*50;
	this["smoke"+i]._rotation = Math.random()*360;
	this["smoke"+i].vx = 3+Math.random()*4;
	this["smoke"+i].vy = -5-Math.random()*8;
	this["smoke"+i].vr = -8+Math.random()*16;
}

for (i=1; i<=10; i++) {
	this["ice"+i].removeMovieClip();
}
for (i=1; i<=10; i++) {
	this.attachMovie("destruction_meter_ice","ice"+i,this.getNextHighestDepth());
	this["ice"+i].gotoAndStop(Math.ceil(0.01+6.98*Math.random()));
	this["ice"+i]._x = Math.random()*380;
	this["ice"+i]._y = Math.random()*10;
	this["ice"+i]._xscale = this["ice"+i]._yscale=40+Math.random()*50;
	this["ice"+i]._rotation = Math.random()*360;
	this["ice"+i].vx = -1+Math.random()*9;
	this["ice"+i].vy = -6-Math.random()*18;
	this["ice"+i].vr = -25+Math.random()*50;
}

this.onEnterFrame = function() {
	for (i=1; i<=5; i++) {
		if (this["smoke"+i] != null) {
			this["smoke"+i].vx *= 0.98;
			this["smoke"+i].vy *= 0.95;
			this["smoke"+i].vr *= 0.99;
			this["smoke"+i]._x += this["smoke"+i].vx;
			this["smoke"+i]._y += this["smoke"+i].vy;
			this["smoke"+i]._xscale += 4;
			this["smoke"+i]._yscale += 4;
			this["smoke"+i]._rotation += this["smoke"+i].vr;
			this["smoke"+i]._alpha -= 4;
			if (this["smoke"+i]._alpha<=0) {
				this["smoke"+i].removeMovieClip();
			}
		}
	}
	for (i=1; i<=12; i++) {
		if (this["ice"+i] != null) {
			this["ice"+i].vx *= 0.98;
			this["ice"+i].vy = this["ice"+i].vy*0.98+1;
			this["ice"+i].vr *= 0.98;
			this["ice"+i]._x += this["ice"+i].vx;
			this["ice"+i]._y += this["ice"+i].vy;
			this["ice"+i]._rotation += this["ice"+i].vr;
			if (this["ice"+i]._y>=40) {
				this["ice"+i].removeMovieClip();
			}
		}
	}
};

// ---- layer "smoke", frame 16
for (i=1; i<=5; i++) {
	this["smoke"+i].removeMovieClip();
}
for (i=1; i<=5; i++) {
	this.attachMovie("destruction_meter_smoke","smoke"+i,this.getNextHighestDepth());
	this["smoke"+i]._x = i*80-50;
	this["smoke"+i]._y = -30+Math.random()*80;
	this["smoke"+i]._xscale = this["smoke"+i]._yscale=80+Math.random()*60;
	this["smoke"+i]._alpha = 60+Math.random()*50;
	this["smoke"+i]._rotation = Math.random()*360;
	this["smoke"+i].vx = 3+Math.random()*4;
	this["smoke"+i].vy = -5-Math.random()*7;
	this["smoke"+i].vr = -8+Math.random()*16;
}

for (i=1; i<=12; i++) {
	this["ice"+i].removeMovieClip();
}

this.onEnterFrame = function() {
	for (i=1; i<=5; i++) {
		if (this["smoke"+i] != null) {
			this["smoke"+i].vx *= 0.98;
			this["smoke"+i].vy *= 0.95;
			this["smoke"+i].vr *= 0.99;
			this["smoke"+i]._x += this["smoke"+i].vx;
			this["smoke"+i]._y += this["smoke"+i].vy;
			this["smoke"+i]._xscale += 5;
			this["smoke"+i]._yscale += 5;
			this["smoke"+i]._rotation += this["smoke"+i].vr;
			this["smoke"+i]._alpha -= 7;
			if (this["smoke"+i]._alpha<=0) {
				this["smoke"+i].removeMovieClip();
			}
		}
	}
};

// ---- layer "smoke", frame 41
for (i=1; i<=5; i++) {
	this["smoke"+i].removeMovieClip();
}
for (i=1; i<=5; i++) {
	this.attachMovie("destruction_meter_smoke","smoke"+i,this.getNextHighestDepth());
	this["smoke"+i]._x = 40+i*60;
	this["smoke"+i]._y = -60+Math.random()*30;
	this["smoke"+i]._xscale = this["smoke"+i]._yscale=50+Math.random()*60;
	this["smoke"+i]._alpha = 60+Math.random()*50;
	this["smoke"+i]._rotation = Math.random()*360;
	this["smoke"+i].vx = -3+Math.random()*8;
	this["smoke"+i].vy = -8+Math.random()*16;
	this["smoke"+i].vr = -8+Math.random()*16;
}

for (i=1; i<=35; i++) {
	this["ice"+i].removeMovieClip();
}
for (i=1; i<=35; i++) {
	this.attachMovie("destruction_meter_ice","ice"+i,1000+i);
	this["ice"+i].gotoAndStop(Math.ceil(0.01+6.98*Math.random()));
	this["ice"+i]._x = Math.random()*380;
	this["ice"+i]._y = -80+Math.random()*60;
	this["ice"+i]._xscale = this["ice"+i]._yscale=20+Math.random()*40;
	this["ice"+i]._rotation = Math.random()*360;
	this["ice"+i].vx = -5+Math.random()*18;
	this["ice"+i].vy = -Math.random()*35;
	this["ice"+i].vr = -25+Math.random()*70;
}

this.onEnterFrame = function() {
	for (i=1; i<=5; i++) {
		if (this["smoke"+i] != null) {
			this["smoke"+i].vx *= 0.98;
			this["smoke"+i].vy *= 0.95;
			this["smoke"+i].vr *= 0.99;
			this["smoke"+i]._x += this["smoke"+i].vx;
			this["smoke"+i]._y += this["smoke"+i].vy;
			this["smoke"+i]._xscale += 5;
			this["smoke"+i]._yscale += 5;
			this["smoke"+i]._rotation += this["smoke"+i].vr;
			this["smoke"+i]._alpha -= 7;
			if (this["smoke"+i]._alpha<=0) {
				this["smoke"+i].removeMovieClip();
			}
		}
	}
	for (i=1; i<=35; i++) {
		if (this["ice"+i] != null) {
			this["ice"+i].vx *= 0.98;
			this["ice"+i].vy = this["ice"+i].vy*0.98+1;
			this["ice"+i].vr *= 0.98;
			this["ice"+i]._x += this["ice"+i].vx;
			this["ice"+i]._y += this["ice"+i].vy;
			this["ice"+i]._rotation += this["ice"+i].vr;
			if (this["ice"+i]._y>=40) {
				this["ice"+i].removeMovieClip();
			}
		}
	}
};

// ---- layer "Meter", frame 8
stop();

// ---- layer "Meter", frame 15
stop();

// ---- layer "Meter", frame 30
stop();

// ---- layer "Meter", frame 117
stop();
