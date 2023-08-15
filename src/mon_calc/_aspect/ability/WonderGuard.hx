package mon_calc.aspect.ability;

import mon_calc.ds.ThisContext;
import mon_calc.ds.event.AffinityContext;
import mon_calc.aspect.core.AAspect;


class WonderGuard extends AAspect {
	public function new() {
		super([OnAffinityCalc],[Self],[]);
	}
	override function onAffinityCalc( oContext:ThisContext, oEvent:AffinityContext ) {
		// Only supereffective moves will hit
		if( oEvent.factor >= 2 ) return;
		oEvent.factor = 0;
	}
}