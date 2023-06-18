package mon_calc.effect;

import mon_calc.ds.ThisContext;
import mon_calc.battle_aspect.IAspect;
import mon_calc.ds.EPriority;
import mon_calc.ds.MoveContext;

class Chance extends AConditional {
	
	var _fChance :Float;
	
	public function new( 
		fChance :Float,
		aChild :Array<IAspect>, 
		aChildElse :Array<IAspect>, 
		ePriority :EPriority
	) {
		super( aChild, aChildElse, ePriority );
		_fChance = fChance;
	}

	public function getChance() { return _fChance; }
	public function setChance( f :Float ) { _fChance = f; }

	override public function validateCondition( oContext:ThisContext, oEvent :MoveContext ) {
		return oContext.processor.getChance( _fChance );
	}
}