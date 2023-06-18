package mon_calc.effect.core;

import mon_calc.ds.ThisContext;
import mon_calc.ds.ETargetType;
import mon_calc.battle_aspect.IAspect;
import mon_calc.ds.MoveContext;
import mon_calc.ds.EPriority;

class AspectConditional extends AConditional {
	
	var _eTarget :ETargetType;
	var _oAspect :Class<IAspect>;
	
	public function new( 
		oAspect :Class<IAspect>,
		aChild :Array<IAspect>, 
		aChildElse :Array<IAspect>, 
		ePriority :EPriority = Normal,
		eTarget :ETargetType = SingleFoe
	) {
		super( aChild, aChildElse, ePriority );
		_oAspect = oAspect;
		_eTarget = eTarget;
	}

	override public function validateCondition( oContext :ThisContext, oEvent :MoveContext ) {

		switch( _eTarget ) {
			case Self: return oEvent.mon_att.hasAspectByClass( _oAspect );
			case SingleFoe: return oEvent.mon_def.hasAspectByClass( _oAspect );
			case Battle: return oContext.battle.hasAspectByClass( _oAspect );
			default: throw '!!!';
		}
	}
}