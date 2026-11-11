// Library symbol "!Cutscenes/Pacifist_elements/camFrame"

// ---- layer "actions", frame 1
function camControl() {
	parentColor.setTransform(camColor.getTransform());
	var scaleX = sX/this._width;
	var scaleY = sY/this._height;
	_parent._x = cX-(this._x*scaleX);
	_parent._y = cY-(this._y*scaleY);
	_parent._xscale = 100*scaleX;
	_parent._yscale = 100*scaleY;
}
function resetStage() {
	var resetTrans = {ra:100, rb:0, ga:100, gb:0, ba:100, bb:0, aa:100, ab:0};
	parentColor.setTransform(resetTrans);
	_parent._xscale = 100;
	_parent._yscale = 100;
	_parent._x = 0;
	_parent._y = 0;
}
// make frame invisible
this._visible = false;
// Capture stage parameters
var oldMode = Stage.scaleMode;
Stage.scaleMode = "exactFit";
var cX = Stage.width/2;
var cY = Stage.height/2;
var sX = Stage.width;
var sY = Stage.height;
Stage.scaleMode = oldMode;
// create color instances for color 
// transforms (if any).
var camColor = new Color(this);
var parentColor = new Color(_parent);
// Make the stage move so that the 
// v-cam is centered on the
// viewport every frame
this.onEnterFrame = camControl;
// Make an explicit call to the camControl
// function to make sure it also runs on the
// first frame.
camControl();
// If the v-cam is ever removed (unloaded)
// the stage, return the stage to the default
// settings.
this.onUnload = resetStage;
