// Library symbol "!Shop/shop_arcade_budget_note"

// ---- layer "text", frame 1
score1.text = "(No score yet)";
score2.text = "(No score yet)";
score3.text = "(No score yet)";

if (_root.arcadeScore1 > 0) {
	score1.text = _root.arcadeScore1 + " points";
}
if (_root.arcadeScore2 > 0) {
	score2.text = _root.arcadeScore2 + " points";
}
if (_root.arcadeScore3 > 0) {
	score3.text = _root.arcadeScore3 + " points";
}

if (_root.arcadeScore1 + _root.arcadeScore2 + _root.arcadeScore3 >= 15000) {
	_root.triggerMedal(26);
}
