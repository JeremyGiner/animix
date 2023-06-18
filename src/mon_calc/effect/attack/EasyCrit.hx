package mon_calc.effect.attack;

import mon_calc.ds.ThisContext;
import mon_calc.ds.event.DamageCalcContext;
import mon_calc.aspect.core.AAspect;
import mon_calc.ds.EPriority;

class EasyCrit extends AAspect {
	public function new() {
		super([OnDamageCalc],[Dealing],[]);
	}

	override function onDamageCalc(oContext:ThisContext, oEvent:DamageCalcContext) {
		// Case : cannot crit (e.g. Confusion)
		if( oEvent.crit_chance == null ) return;
		oEvent.crit_chance = 1/8;
	}
}