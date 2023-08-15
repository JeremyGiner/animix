package animix.event;

import animix.aspect.Damage;
import animix.entity.Ani;
import mon_calc.entity.Mon;
import mon_calc.ds.EEventType;
import mon_calc.entity.Move;
import mon_calc.entity.EStat;

typedef DamageCalcContext = {
    var type :EEventType;
	var factor :Null<Float>;
	var crit_chance :Null<Float>;
	var power :Int;
	var damage :Damage;

	var att_mon :Ani;
	var att_stat :Int;

	var def_mon :Ani;
	var def_stat :Int;
	var att_side :Bool;
}