// Library symbol "!Result/results"

// ---- layer "Control", frame 1
////DEBUG
//test_cash_alt = 2000;
//test_cash_dis = 100;
//test_cash_dur = 300;
//test_cash_spe = 400;
//test_cash_des = 500;
////DEBUG END

//Results jingle threshold
result_threshold1 = 500;//Total cash above which theme 2 is played
result_threshold2 = 1000;//Total cash above which theme 3 is played

//These 5 aren't the values, just switches used to see if "record" was played
record_dis = 0;
record_alt = 0;
record_dur = 0;
record_spe = 0;
record_des = 0;


test_dis = _root.REF_max_distance;
test_alt = _root.REF_max_altitude;
test_dur = _root.REF_duration;
test_spe = _root.REF_max_speed;
test_des = _root.REF_destruction;

test_cash_alt = _root.getCashAlt(test_alt);
test_cash_dis = _root.getCashDis(test_dis);
test_cash_dur = _root.getCashDur(test_dur);
test_cash_spe = _root.getCashSpe(test_spe);
test_cash_des = _root.getCashDes(test_des);

//prevent NaN
test_cash_alt = isNaN(test_cash_alt) ? 0 : test_cash_alt;
test_cash_dis = isNaN(test_cash_dis) ? 0 : test_cash_dis;
test_cash_dur = isNaN(test_cash_dur) ? 0 : test_cash_dur;
test_cash_spe = isNaN(test_cash_spe) ? 0 : test_cash_spe;
test_cash_des = isNaN(test_cash_des) ? 0 : test_cash_des;

test_cash_total = test_cash_alt+test_cash_dis+test_cash_dur+test_cash_spe+test_cash_des;

//Skip animation
this.skipped = false;
this.onMouseDown = function() {
	this.onMouseDown = null;
	_root.skipScene = null;
	this.skipped = true;
	title.gotoAndStop("end");
	this.gotoAndPlay("result");
};

_root.skipScene = function() {
	_root.dayResults.onMouseDown();
};


//BGM
if (test_cash_total<result_threshold1) {
	_root.playBgm("victory1",null,false);
	this.gotoAndPlay("result1");
} else if (test_cash_total<result_threshold2) {
	_root.playBgm("victory2",null,false);
	this.gotoAndPlay("result2");
} else {
	_root.playBgm("victory3",null,false);
}

//Blurring bmd
this.onEnterFrame = function() {
	_root.addBlur(_root.snapshot);
};

// ---- layer "Control", frame 50
title.txtDay.txt.text = _root.test_day-1;

// ---- layer "Control", frame 60
score.meter_dis.gotoAndStop(1);
score.meter_alt.gotoAndStop(1);
score.meter_dur.gotoAndStop(1);
score.meter_spe.gotoAndStop(1);
score.meter_des.gotoAndStop(1);
score.record_dis.gotoAndStop(2);
score.record_alt.gotoAndStop(2);
score.record_dur.gotoAndStop(2);
score.record_spe.gotoAndStop(2);
score.record_des.gotoAndStop(2);
score.txt_dis.text="";
score.txt_alt.text="";
score.txt_dur.text="";
score.txt_spe.text="";
score.txt_des.text="";
title.txtDay.txt.text = _root.test_day-1;

// ---- layer "Control", frame 70
cash.txt_cash_dis.text="0 $";
cash.txt_cash_alt.text="0 $";
cash.txt_cash_dur.text="0 $";
cash.txt_cash_spe.text="0 $";
cash.txt_cash_des.text="0 $";
title.txtDay.txt.text = _root.test_day-1;

// ---- layer "Control", frame 80
count = 0;

this.onEnterFrame = function() {
	score.txt_dis.text = Math.floor(10*Math.min(test_dis, (test_dis/20)*count))/10;
	cash.txt_cash_dis.text = (Math.floor(10*Math.min(test_cash_dis, (test_cash_dis/20)*count))/10)+" $";
	if (score.txt_dis.text.indexOf(".") == -1) {
		score.txt_dis.text = score.txt_dis.text+".0";
	}
	score.meter_dis.gotoAndStop(Math.floor(1+Math.min(test_dis, (test_dis/20)*count)/(_root.test_old_dis+1)*400));
	if (score.meter_dis._currentframe == 400 && record_dis == 0) {
		record_dis = 1;
		score.record_dis.gotoAndPlay(3);
	}
	if (count-10>=0) {
		score.txt_alt.text = Math.floor(10*Math.min(test_alt, (test_alt/20)*(count-10)))/10;
		cash.txt_cash_alt.text = (Math.floor(10*Math.min(test_cash_alt, (test_cash_alt/20)*(count-10)))/10)+" $";
		if (score.txt_alt.text.indexOf(".") == -1) {
			score.txt_alt.text = score.txt_alt.text+".0";
		}
		score.meter_alt.gotoAndStop(Math.floor(1+Math.min(test_alt, (test_alt/20)*(count-10))/(_root.test_old_alt+1)*400));
		if (score.meter_alt._currentframe == 400 && record_alt == 0) {
			record_alt = 1;
			score.record_alt.gotoAndPlay(3);
		}
	}
	if (count-20>=0) {
		score.txt_dur.text = Math.floor(10*Math.min(test_dur, (test_dur/20)*(count-20)))/10;
		cash.txt_cash_dur.text = (Math.floor(10*Math.min(test_cash_dur, (test_cash_dur/20)*(count-20)))/10)+" $";
		if (score.txt_dur.text.indexOf(".") == -1) {
			score.txt_dur.text = score.txt_dur.text+".0";
		}
		score.meter_dur.gotoAndStop(Math.floor(1+Math.min(test_dur, (test_dur/20)*(count-20))/(_root.test_old_dur+1)*400));
		if (score.meter_dur._currentframe == 400 && record_dur == 0) {
			record_dur = 1;
			score.record_dur.gotoAndPlay(3);
		}
	}
	if (count-30>=0) {
		score.txt_spe.text = Math.floor(10*Math.min(test_spe, (test_spe/20)*(count-30)))/10;
		cash.txt_cash_spe.text = (Math.floor(10*Math.min(test_cash_spe, (test_cash_spe/20)*(count-30)))/10)+" $";
		if (score.txt_spe.text.indexOf(".") == -1) {
			score.txt_spe.text = score.txt_spe.text+".0";
		}
		score.meter_spe.gotoAndStop(Math.floor(1+Math.min(test_spe, (test_spe/20)*(count-30))/(_root.test_old_spe+1)*400));
		if (score.meter_spe._currentframe == 400 && record_spe == 0) {
			record_spe = 1;
			score.record_spe.gotoAndPlay(3);
		}
	}
	if (count-40>=0) {
		score.txt_des.text = Math.floor(10*Math.min(test_des, (test_des/20)*(count-40)))/10;
		cash.txt_cash_des.text = (Math.floor(10*Math.min(test_cash_des, (test_cash_des/20)*(count-40)))/10)+" $";
		if (score.txt_des.text.indexOf(".") == -1) {
			score.txt_des.text = score.txt_des.text+".0";
		}
		txt_cashdes.text = Math.floor(Math.min(test_cash_des, (test_cash_des/20)*(count-40)));
		score.meter_des.gotoAndStop(Math.floor(1+Math.min(test_des, (test_des/20)*(count-40))/(_root.test_old_des+1)*400));
		if (score.meter_des._currentframe == 400 && record_des == 0) {
			record_des = 1;
			score.record_des.gotoAndPlay(3);
		}
	}
	count++;
};

// ---- layer "Control", frame 146 ("result")
title.txtDay.txt.text = _root.test_day-1;
total.txt_cash.text = "0 $";

if (this.skipped == true) {
	count = 20;
} else {
	count = 0;
}

//Set every field with item full value
if (record_dis<>1) {
	score.record_dis.gotoAndStop(2);
}
if (record_alt<>1) {
	score.record_alt.gotoAndStop(2);
}
if (record_dur<>1) {
	score.record_dur.gotoAndStop(2);
}
if (record_spe<>1) {
	score.record_spe.gotoAndStop(2);
}
if (record_des<>1) {
	score.record_des.gotoAndStop(2);
}

score.txt_dis.text = Math.floor(10*test_dis)/10;
cash.txt_cash_dis.text = (Math.floor(10*test_cash_dis)/10)+" $";
if (score.txt_dis.text.indexOf(".") == -1) {
	score.txt_dis.text = score.txt_dis.text+".0";
}
score.meter_dis.gotoAndStop(Math.min(400, Math.floor(1+test_dis/(_root.test_old_dis+1)*400)));
if (score.meter_dis._currentframe == 400 && record_dis == 0) {
	record_dis = 1;
	score.record_dis.gotoAndPlay(3);
}

score.txt_alt.text = Math.floor(10*test_alt)/10;
cash.txt_cash_alt.text = (Math.floor(10*test_cash_alt)/10)+" $";
if (score.txt_alt.text.indexOf(".") == -1) {
	score.txt_alt.text = score.txt_alt.text+".0";
}
score.meter_alt.gotoAndStop(Math.min(400, Math.floor(1+test_alt/(_root.test_old_alt+1)*400)));
if (score.meter_alt._currentframe == 400 && record_alt == 0) {
	record_alt = 1;
	score.record_alt.gotoAndPlay(3);
}

score.txt_dur.text = Math.floor(10*test_dur)/10;
cash.txt_cash_dur.text = (Math.floor(10*test_cash_dur)/10)+" $";
if (score.txt_dur.text.indexOf(".") == -1) {
	score.txt_dur.text = score.txt_dur.text+".0";
}
score.meter_dur.gotoAndStop(Math.min(400, Math.floor(1+test_dur/(_root.test_old_dur+1)*400)));
if (score.meter_dur._currentframe == 400 && record_dur == 0) {
	record_dur = 1;
	score.record_dur.gotoAndPlay(3);
}

score.txt_spe.text = Math.floor(10*test_spe)/10;
cash.txt_cash_spe.text = (Math.floor(10*test_cash_spe)/10)+" $";
if (score.txt_spe.text.indexOf(".") == -1) {
	score.txt_spe.text = score.txt_spe.text+".0";
}
score.meter_spe.gotoAndStop(Math.min(400, Math.floor(1+test_spe/(_root.test_old_spe+1)*400)));
if (score.meter_spe._currentframe == 400 && record_spe == 0) {
	record_spe = 1;
	score.record_spe.gotoAndPlay(3);
}

score.txt_des.text = Math.floor(10*test_des)/10;
cash.txt_cash_des.text = (Math.floor(10*test_cash_des)/10)+" $";
if (score.txt_des.text.indexOf(".") == -1) {
	score.txt_des.text = score.txt_des.text+".0";
}
score.meter_des.gotoAndStop(Math.min(400, Math.floor(1+test_des/(_root.test_old_des+1)*400)));
if (score.meter_des._currentframe == 400 && record_des == 0) {
	record_des = 1;
	score.record_des.gotoAndPlay(3);
}

this.onEnterFrame = function() {
	total.txt_cash.text = (Math.floor(10*Math.min(test_cash_total, (test_cash_total/20)*count))/10)+" $";
	count++;
};

//Next Screen
this.onMouseDown = function() {
	this.onMouseDown = null;
	_root.skipScene = null;
	//UPDATE RECORDS
	_root.test_old_dis = Math.max(_root.test_old_dis, test_dis);
	_root.test_old_alt = Math.max(_root.test_old_alt, test_alt);
	_root.test_old_dur = Math.max(_root.test_old_dur, test_dur);
	_root.test_old_spe = Math.max(_root.test_old_spe, test_spe);
	_root.test_old_des = Math.max(_root.test_old_des, test_des);

	_root.test_player_cash += test_cash_total;
	if (_root.challengeNameHolder.length<=0) {
		_root.stopBgm(9);
		_root.fadeTo("shop");
		_root.saveGame(0);
	} else {
		this.gotoAndPlay("challenge");
	}
};

_root.skipScene = function() {
	_root.dayResults.onMouseDown();
};

// ---- layer "Control", frame 164
title.txtDay.txt.text = _root.test_day-1;
stop();

// ---- layer "Control", frame 165 ("challenge")
skippingChallenges = false;

//Next Screen
this.onMouseDown = function() {
	this.onMouseDown = null;
	_root.skipScene = null;
	skippingChallenges = true;
	this.gotoAndPlay("challenge_results");
};

_root.skipScene = function() {
	_root.dayResults.onMouseDown();
};	

total.gotoAndStop(1);
total.txt_cash.txt_cash.text = test_cash_total+" $";

// ---- layer "Control", frame 193
score.txt5.text = "";
score.txt4.text = "";
score.txt3.text = "";
score.txt2.text = "";
score.txt1.txt.text = "";
score.txtCash5.text = "";
score.txtCash4.text = "";
score.txtCash3.text = "";
score.txtCash2.text = "";
score.txtCash1.txt.text = "";
score.icon1.gotoAndStop("empty");
score.icon2.gotoAndStop("empty");
score.icon3.gotoAndStop("empty");
score.icon4.gotoAndStop("empty");
score.icon5.gotoAndStop("empty");

// ---- layer "Control", frame 204 ("challenge_results")
if (skippingChallenges) {
	timerValue = 3;
} else {
	timerValue = 20;
}

timerCount = timerValue;
timerIndex = 0;

challengeTimer = function () {
	timerCount--;
	if (timerCount<=0 && timerIndex>=0) {
		timerCount = timerValue;
		pushChallenge();
		timerIndex++;
		if (timerIndex>=_root.challengeNameHolder.length) {
			//finished displaying challenges
			total.gotoAndPlay("flash");
			timerIndex = -1;
			this.onMouseDown = function() {
				this.onMouseDown = null;
				_root.skipScene = null;
				_root.stopBgm(10);
				_root.fadeTo("shop");
				_root.saveGame(0);
			};
			this.onEnterFrame = null;
		}
	}
};

pushChallenge = function () {
	score.icon5.gotoAndStop(score.icon4._currentframe);
	score.icon4.gotoAndStop(score.icon3._currentframe);
	score.icon3.gotoAndStop(score.icon2._currentframe);
	score.icon2.gotoAndStop(score.icon1._currentframe);
	score.icon1.gotoAndStop(_root.challengeIndexHolder[timerIndex]+1);
	score.txt5.text = score.txt4.text;
	score.txt4.text = score.txt3.text;
	score.txt3.text = score.txt2.text;
	score.txt2.text = score.txt1.txt.text;
	score.txt1.txt.text = _root.challengeNameHolder[timerIndex];
	score.txtCash5.text = score.txtCash4.text;
	score.txtCash4.text = score.txtCash3.text;
	score.txtCash3.text = score.txtCash2.text;
	score.txtCash2.text = score.txtCash1.txt.text;
	score.txtCash1.txt.text = _root.challengeRewardHolder[timerIndex]+" $";
	test_cash_total += _root.challengeRewardHolder[timerIndex];
	total.txt_cash.txt_cash.text = test_cash_total+" $";
	total.gotoAndPlay("bump");
	score.gotoAndPlay(2);
};

this.onMouseDown = function() {
	this.onMouseDown = null;
	_root.skipScene = null;
	timerValue = 3;
	timerCount = Math.min(timerCount, timerValue);
};

_root.skipScene = function() {
	_root.dayResults.onMouseDown();
};

this.onEnterFrame = function() {
	challengeTimer();
};

score.txt5.text = "";
score.txt4.text = "";
score.txt3.text = "";
score.txt2.text = "";
score.txt1.txt.text = "";
score.txtCash5.text = "";
score.txtCash4.text = "";
score.txtCash3.text = "";
score.txtCash2.text = "";
score.txtCash1.txt.text = "";
score.icon1.gotoAndStop("empty");
score.icon2.gotoAndStop("empty");
score.icon3.gotoAndStop("empty");
score.icon4.gotoAndStop("empty");
score.icon5.gotoAndStop("empty");

// ---- layer "Control", frame 212
stop();
