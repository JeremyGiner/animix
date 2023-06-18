package mon_calc.effect;

import mon_calc.battle_aspect.IAspect;
import mon_calc.ds.ThisContext;
import mon_calc.aspect.core.AAspect;
import mon_calc.ds.MoveContext;
import mon_calc.ds.EPriority;

class AConditional extends AAspect {
	
	var _aChild :Array<IAspect>;
	var _aChildElse :Array<IAspect>;
	var _ePriority :EPriority;
	
	public function new( 
		aChild :Array<IAspect>, 
		aChildElse :Array<IAspect> = null,
		ePriority :EPriority = Normal
	) {
		super([OnAttack],[Dealing],[]);
		_aChild = aChild;
		_aChildElse = aChildElse == null ? [] : aChildElse;
		_ePriority = ePriority;
	}
	
	override public function getPriority() :String { return cast _ePriority; }
	
	override function onAttack(oContext:ThisContext, oEvent:MoveContext) {

		var a = validateCondition( oContext, oEvent ) ? 
			_aChild : _aChildElse;
		
		for( o in a )
			o.process( oContext );
	}
	
	public function validateCondition( oContext:ThisContext, oEvent:MoveContext ) :Bool {
		throw 'override me';
	}
}