package mon_calc.aspect.barrier;

import mon_calc.ds.ThisContext;
import mon_calc.ds.MoveContext;
import mon_calc.aspect.core.AAspect;

class Protect extends AAspect {
	public function new() {
		super([OnAttack],[Receiving],[Barrier,Guard],0);
	}

	override function onAttack( oContext :ThisContext, oEvent :MoveContext ) {
		// TODO : ignore targeting self ?
		//Todo: before substitute
		oEvent.turnover = true;
	}

	override function onTurnEnd(oContext:ThisContext) {
		super.onTurnEnd( oContext );
		if( getFadeCount() == 0 ) {
			oContext.processor.addAspect( 
				oContext.owner,
				new ProtectSideEffect(),
				oContext.mon,
				this
			);
		}
	}
}