package mon_calc.aspect.ability;

import mon_calc.ds.event.AspectEntryContext;
import mon_calc.ds.PairAspectContext;
import mon_calc.ds.AspectExecuteContext;
import mon_calc.battle_aspect.StatModifier;
import mon_calc.battle_aspect.substatus.Flinch;
import mon_calc.ds.ThisContext;
import mon_calc.aspect.core.AAspect;


class Steadfast extends AAspect {
	public function new() {
		super([OnAspectEntryPost],[Self],[]);
	}

	override function onAspectEntryPost(
		oContext :ThisContext, 
		oEvent :AspectEntryContext
	) {
		if( ! Std.isOfType(oEvent.aspect,Flinch) ) return;

		// Boost speed on flinch
		oContext.processor.addAspect( 
			oContext.owner, 
			new StatModifier([Speed => 1]), 
			oContext.mon, 
			this 
		);
	}
}