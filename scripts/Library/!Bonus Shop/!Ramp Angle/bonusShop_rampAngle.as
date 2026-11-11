// Library symbol "!Bonus Shop/!Ramp Angle/bonusShop_rampAngle"

// ---- layer "Objects", frame 1
slider.up = 2;
slider.down = 114;
slider.hitArea = slider.hitSpot;
slider.hitSpot._visible = false;

slider.onPress = function() {
	startDrag(this, false, this._x, this.up, this._x, this.down);
	slider.onMouseMove = function() {
		_root.RAMP_JUMP_ANGLE_OVER = Math.max(2, Math.min(102, Math.round(101*((this._y-this.up)/this.down)+1)));
		this._parent.gotoAndStop(_root.RAMP_JUMP_ANGLE_OVER);
		_root.RAMP_ANGLE_SLIDER_Y = Math.round(this._y);
		//_root.RAMP_JUMP_ANGLE = Math.ceil(290*Math.log(0.003*_root.RAMP_ANGLE_SLIDER_Y+1)-62);
		//_root.RAMP_JUMP_ANGLE = Math.ceil(290*Math.log(0.003*_root.RAMP_ANGLE_SLIDER_Y+1)-46);
		_root.RAMP_JUMP_ANGLE = Math.ceil(-156*Math.log(-0.00415*_root.RAMP_ANGLE_SLIDER_Y+1)-60);
		//determine RAMP_ANGLE
		
		trace(_root.RAMP_ANGLE_SLIDER_Y + "   " + _root.RAMP_JUMP_ANGLE);
	};
};

slider.onRelease = slider.onReleaseOutside=function () {
	this.stopDrag();
	this.onMouseMove = null;
};

if (_root.RAMP_ANGLE_SLIDER_Y<=-1) {
	slider._y = 40;
	this.gotoAndStop(1);
} else {
	slider._y = Math.ceil(_root.RAMP_ANGLE_SLIDER_Y);
}
this.gotoAndStop(Math.max(2, Math.min(102, Math.round(101*((slider._y-slider.up)/slider.down)+1))));

resetBtn.onRelease = function() {
	with (this._parent) {
		slider._y = 40;
		gotoAndStop(Math.max(2, Math.min(102, Math.round(101*((slider._y-slider.up)/slider.down)+1))));
	}
	_root.RAMP_ANGLE_SLIDER_Y = 40;
	_root.RAMP_JUMP_ANGLE_OVER=1;
	_root.RAMP_JUMP_ANGLE = -40;
};

doneBtn.onRelease = function() {
	_root.bonus.gotoAndPlay("out");
	this.onRelease = null;
};

blocker._alpha = 1;
blocker.onRelease = blocker.onPress=function () {
	//null
};
