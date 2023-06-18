package mon_calc.effect.status;

import mon_calc.ds.MoveContext;
import mon_calc.ds.EPriority;

class FreezeApplier implements IEffect {
	
	public function new() {
		
	}

	public function getPriority() { return cast EPriority.Normal; }

	public function onAttack( oContext :MoveContext ) {
		// Ice can't freeze
		if( oContext.mon_def.hasHitType( Ice ) ) return;
	}
}