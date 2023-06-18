package mon_calc.ds.enumeration;

enum abstract EPriorityAttack(Int) {
	
	var Recharge;
	var MainStatus;
	var Flinch;
	var Confusion; // after recharging, sleep, freeze, and flinching
	var AccuracyCheck;

	var BeforeDamage;
	var Damage;
	var AfterDamage;
}