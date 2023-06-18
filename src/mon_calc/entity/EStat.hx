package mon_calc.entity;

enum abstract EStat(Int) {
	var Health = 0;
	var Att = 1;
	var Def = 2;
	var Mag = 3;
	var Res = 4;
	var Speed = 5;

	var Accuracy = 6;
	var Evasion = 7;
}