// Library symbol "!Stage/stage_day"

// ---- layer "Layer 1", frame 1
day1.text = _root.test_day;

// ---- layer "Layer 1", frame 2
day1.text = _root.test_day;
day2.text = _root.test_day-1;
day3.text = _root.test_day-2;
day4.text = _root.test_day-3;

// ---- layer "Layer 1", frame 3
quote.seed = Math.random();

if (quote.seed<=0.33) {
	quote.gotoAndStop(1);
} else if (quote.seed<=0.66) {
	quote.gotoAndStop(2);
} else {
	quote.gotoAndStop(3);
}
