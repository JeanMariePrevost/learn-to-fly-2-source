// Library symbol "!Result/results_arcade_BP"

// ---- layer "Layer 13", frame 1
bonusCount = 0;

this.onEnterFrame = function() {
	this.txt.text = Math.floor(this._parent.arcadeEarnedBP*Math.min(1, Math.max(0, (0.245*Math.log(bonusCount+0.4)+0.2))));
	bonusCount++;
};

// ---- layer "Layer 13", frame 25 ("end")
stop();

this.onEnterFrame = null;
this.txt.text = this._parent.arcadeEarnedBP;
