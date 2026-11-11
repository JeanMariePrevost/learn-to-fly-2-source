// Library symbol "!System/!Preloader/preloader_commentFx"

// ---- layer "Layer 1", frame 9 ("out")
if (this._parent._parent.currentStage>=5) {
	newComment = "end";
} else {
	do {
		newComment = Math.ceil(0.01+Math.random()*25.98);
	} while (newComment == txtMc._currentFrame);
}

txtMc.gotoAndStop(newComment);

// ---- layer "Layer 1", frame 15
this.gotoAndStop("idle");
