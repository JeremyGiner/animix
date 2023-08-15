package mon_calc.aspect.barrier;

import mon_calc.ds.event.AspectEntryContext;
import mon_calc.battle_aspect.core.AspectApplier;
import mon_calc.ds.AspectExecuteContext;
import mon_calc.ds.PairAspectContext;
import mon_calc.battle_aspect.status.AMainStatus;
import mon_calc.ds.ThisContext;
import mon_calc.aspect.core.AAspect;

class StatusBarrier extends AAspect {

	public function new() {
		// TODO : is it ally or Self ?
		super([OnAspectEntryPre],[Ally],[Barrier],5);
	}

	override function onAspectEntryPre(oContext:ThisContext, oEvent:AspectEntryContext) {
		if( ! Std.isOfType(oEvent.aspect,AMainStatus) ) return;

		// Does not prevent from ally source
		if( 
			oEvent.source_mon != null
			&& oContext.processor.getMonSide( oEvent.source_mon ) == oContext.side
		) return;

		oEvent.prevent_default = true;
	}

}