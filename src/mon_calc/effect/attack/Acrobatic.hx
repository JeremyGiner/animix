package mon_calc.effect.attack;

import mon_calc.ds.ThisContext;
import mon_calc.ds.event.DamageCalcContext;
import mon_calc.aspect.core.AAspect;

class Acrobatic extends AAspect {
	
	public function new() {
		super([OnDamageCalc],[],[]);
	}

	//TODO: priority : after gem
	override function onDamageCalc(oContext:ThisContext, oEvent:DamageCalcContext) {
		if( oEvent.att_mon.getItem() == null )
			oEvent.power *= 2;
	}
}