// Library symbol "!Bonus Shop/bonus_points"

// ---- layer "txt", frame 1
oldPoints = _root.test_player_points;
points.gotoAndStop(1);
points.txt.txt.text = this.oldPoints;

this.gotoAndStop("off");

// ---- layer "txt", frame 2 ("in")
points.gotoAndStop(1);
points.txt.txt.text = this.oldPoints;
trace(oldPoints);
trace(this.oldPoints);
trace(_root.bonusPointsPopUp.oldPoints);

// ---- layer "txt", frame 30
if (_root.test_player_points<>undefined) {
	counterInit = counter=20;//Number of frame for animation
	points.txt.txt.text = this.oldPoints;
	points.gotoAndPlay(2);

	this.onEnterFrame = function() {
		points.txt.txt.text = Math.ceil(_root.test_player_points+counter*((this.oldPoints-_root.test_player_points)/counterInit));
		counter = Math.max(0, counter-1);
		if (counter<=0) {
			this.onEnterFrame = null;
			points.txt.txt.text = _root.test_player_points;
		}
	};
}

// ---- layer "txt", frame 106
gotoAndStop("off");

// ---- layer "txt", frame 107 ("off")
stop();

// ---- layer "logo", frame 98 ("out")
points.gotoAndStop(1);
points.txt.txt.text = _root.test_player_points;
