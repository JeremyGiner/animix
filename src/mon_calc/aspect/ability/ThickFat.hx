package mon_calc.aspect.ability;

import mon_calc.ds.ThisContext;
import mon_calc.ds.event.DamageCalcContext;
import mon_calc.aspect.core.AAspect;
import mon_calc.entity.EHitType;

class ThickFat extends AAspect {
	
	public function new() {
		super([OnDamageCalc],[Receiving],[]);
	}

	override function onDamageCalc(oContext:ThisContext, oEvent:DamageCalcContext) {
		if( [Ice,Fire].contains( oEvent.damage.getHitType() ) ) return;

		oEvent.factor *= 0.5;
		oContext.processor.log('ThickFat protect');
	}
}