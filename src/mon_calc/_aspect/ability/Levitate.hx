package mon_calc.aspect.ability;

import mon_calc.ds.ThisContext;
import mon_calc.ds.event.AffinityContext;
import mon_calc.aspect.core.AAspect;


class Levitate extends AAspect {
	public function new() {
		super([OnAffinityCalc],[Self],[]);
	}
	override function onAffinityCalc(oContext:ThisContext, oEvent:AffinityContext) {
		if( oEvent.att_type != Ground ) return;
		oEvent.factor = 0;
	}
}