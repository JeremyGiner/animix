package mon_calc.aspect.barrier;

import mon_calc.ds.PairAspectContext;
import mon_calc.aspect.core.IAspectBearer;
import mon_calc.core.BattleProcessor;
import mon_calc.ds.ThisContext;
import mon_calc.ds.event.AspectEntryContext;
import mon_calc.aspect.core.AAspect;

/**
 * May prevent consecutive uses of Protect and alike
 */
class ProtectSideEffect extends AAspect implements IStackable {

	var _iStack :Int;

	public function new() {
		super([OnAspectEntryPre],[Self],[],0);
		_iStack = 1;
	}

	override function onAspectEntryPre( 
		oContext :ThisContext, 
		oEvent :AspectEntryContext
	) {
		// TODO: Detect, Endure, WIde guard, quick guard, Spiky shield, Kings shield, Baneful Bunker, Obscrtuct

		if( ! oContext.processor.getChance( Math.max( 1/729, 1/(_iStack * 3) ) )) {
			return;
		}
		if(!oEvent.aspect.hasFlag(Guard) ) return;
		oEvent.prevent_default = true;
	}


	public function addStack( 
		oProcessor :BattleProcessor, 
		oTarget :IAspectBearer,  
		oAspect :IStackable  
	) {
		_iFade++;
	}
}