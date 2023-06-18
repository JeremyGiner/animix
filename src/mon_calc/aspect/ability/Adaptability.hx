package mon_calc.aspect.ability;

import mon_calc.ds.ThisContext;
import mon_calc.ds.event.DamageCalcContext;
import mon_calc.aspect.core.AAspect;


class Adaptability extends AAspect {
	public function new() {
		super([OnDamageCalc],[Self],[]);
	}
	override function onDamageCalc(oContext:ThisContext, oEvent:DamageCalcContext) {
		if( !oContext.mon.hasHitType( oEvent.damage.getHitType() ) ) return;
		oEvent.factor *= 4/3;
	}
}