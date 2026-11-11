// Library symbol "!Stage/stage"

// ---- layer "Control", frame 1
if (_root.GAME_MODE == "classic") {
	this.gotoAndStop(3);

} else {


	currentTopObstacle = 0;
	for (k = 0; k <= 4; k++) {
		trace(_root.obstacleDestroyedCount);
		if (_root.obstacleDestroyedCount[k + 1] <= 0) {
			currentTopObstacle = k;
			break;
		}
	}

	nextTarget.gotoAndStop(currentTopObstacle + 1);

	for (i = 1; i <= 5; i++) {
		if (_root.obstacleDestroyedCount[i] >= 1) {
			killList["obst" + i]._visible = true;
		} else {
			killList["obst" + i]._visible = false;
		}
	}

	hint.gotoAndStop(Math.floor(Math.random() * 22) + 1);
	//Randomize hint rotation
	hint._rotation = -10 + Math.random() * 20;
	//Hint_shadow is used to project the shadows behind map, while hint is above map
	hint_shadow._rotation = hint._rotation;
	hint_shadow.gotoAndStop(hint._currentframe);

	//Randomzie "Day" post-it
	quote.seed = Math.random();

	if (_root.test_day <= 3) {
		quote.gotoAndStop(1);
	} else {
		if (quote.seed <= 0.6) {
			quote.gotoAndStop(1);
		} else if (quote.seed <= 0.8) {
			quote.gotoAndStop(2);
		} else {
			quote.gotoAndStop(3);
		}
	}

	btnNext._y -= 500;


	this.stop();
}

// ---- layer "Control", frame 3
//Randomize hint rotation
hint._rotation = -10 + Math.random() * 20;
hint.gotoAndStop(Math.floor(Math.random() * 22) + 1);
//Hint_shadow is used to project the shadows behind map, while hint is above map
hint_shadow._rotation = hint._rotation;
hint_shadow.gotoAndStop(hint._currentframe);

//Randomzie "Day" post-it
quote.seed = Math.random();

if (_root.test_day <= 3) {
	quote.gotoAndStop(1);
} else {
	if (quote.seed <= 0.6) {
		quote.gotoAndStop(1);
	} else if (quote.seed <= 0.8) {
		quote.gotoAndStop(2);
	} else {
		quote.gotoAndStop(3);
	}
}

// ---- layer "Control", frame 4
//Randomize hint rotation
hint._rotation = -10 + Math.random() * 20;
hint.gotoAndStop(Math.floor(Math.random() * 22) + 1);
//Hint_shadow is used to project the shadows behind map, while hint is above map
hint_shadow._rotation = hint._rotation;
hint_shadow.gotoAndStop(hint._currentframe);

//Randomzie "Day" post-it
quote.seed = Math.random();

if (_root.test_day <= 3) {
	quote.gotoAndStop(1);
} else {
	if (quote.seed <= 0.6) {
		quote.gotoAndStop(1);
	} else if (quote.seed <= 0.8) {
		quote.gotoAndStop(2);
	} else {
		quote.gotoAndStop(3);
	}
}

// ---- layer "btnNext", frame 1
btnNext._alpha = 1;

// ---- layer "btnNext", frame 3
btnNext._alpha = 1;

// ---- layer "btnNext", frame 4
btnNext._alpha = 1;
