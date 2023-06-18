package mon_calc.effect.attack;

import mon_calc.battle_aspect.status.DeadlyPoisonStatus;
import mon_calc.battle_aspect.status.PoisonStatus;
import mon_calc.ds.ThisContext;
import mon_calc.ds.event.DamageCalcContext;
import mon_calc.aspect.core.AAspect;

class Venoshock extends AAspect {

	public function new() {
		super([OnDamageCalc],[],[]);
	}

	override function onDamageCalc(oContext:ThisContext, oEvent:DamageCalcContext) {
		if( 
			oEvent.def_mon.hasAspectByClass(PoisonStatus)
			|| oEvent.def_mon.hasAspectByClass(DeadlyPoisonStatus)
		) oEvent.power *= 2;
	}
}