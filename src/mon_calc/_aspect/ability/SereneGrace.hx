package mon_calc.aspect.ability;

import mon_calc.ds.AspectExecuteContext;
import mon_calc.effect.Chance;
import mon_calc.ds.ThisContext;
import mon_calc.aspect.core.AAspect;


class SereneGrace extends AAspect {
	// TODO : Move liguidation half hp boost
	public function new() {
		super([OnAspectExecutePre],[],[]);
	}

	override function onAspectExecutePre( 
		oContext :ThisContext,
		oEvent :AspectExecuteContext 
	) {
		if( oEvent.event.type != OnAttack ) return;
		if( ! Std.isOfType(oEvent.aspect,Chance) ) return;

		var oChance = cast(oEvent.aspect,Chance);
		oChance.setChance( oChance.getChance() * 2 );
	}

}