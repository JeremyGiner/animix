package mon_calc.ds.event;

import mon_calc.entity.Mon;
import mon_calc.effect.Damage;
import mon_calc.ds.EEventType;
import mon_calc.entity.Move;
import mon_calc.entity.EStat;

typedef DamageCalcContext = {
    var type :EEventType;
	var factor :Null<Float>;
	var crit_chance :Null<Float>;
	var power :Int;
	var damage :Damage;

	var att_mon :Mon;
	var att_stat :Int;

	var def_mon :Mon;
	var def_stat :Int;
	var def_side :Bool;
}