package mon_calc.aspect;

import mon_calc.effect.Drain;
import mon_calc.ds.ThisContext;
import mon_calc.ds.AspectExecuteContext;
import mon_calc.aspect.core.AAspect;


class LiquidOoze extends AAspect {
	public function new() {
		super([OnAspectExecutePre],[],[]);
	}
	override function onAspectExecutePre( oContext:ThisContext, oEvent:AspectExecuteContext ) {
		if( 
			oEvent.event.type == OnDamagePost 
			&& Std.isOfType( oEvent.aspect, Drain )
		) {
			oEvent.prevent_default = true;
			oEvent.battle.damage( oContext.target, oContext.value, this );
		}
	}
}