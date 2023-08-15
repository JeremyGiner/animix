package mon_calc.aspect.ability;

import mon_calc.ds.ThisContext;
import mon_calc.ds.event.DamageCalcContext;
import mon_calc.aspect.core.AAspect;


class SuperLuck extends AAspect {
	public function new() {
		super([OnDamageCalc],[Self],[]);
	}

	override function onDamageCalc(oContext:ThisContext, oEvent:DamageCalcContext) {
		if( oEvent.crit_chance == null ) return;
		oEvent.crit_chance = 1/8;
	}
}