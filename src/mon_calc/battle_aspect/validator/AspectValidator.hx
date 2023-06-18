package mon_calc.battle_aspect.validator;

import mon_calc.ds.MoveContext;
import mon_calc.ds.EPriority;
import mon_calc.effect.IEffect;
import mon_calc.ds.ETargetType;



class AspectValidator implements IValidator<Dynamic>{
	
	var _eTarget :ETargetType;
	var _oAspect :Class<IAspect>;
	
	public function new( 
		oAspect :Class<IAspect>,
		ePriority :EPriority = Normal,
		eTarget :ETargetType = SingleFoe
	) {
		_oAspect = oAspect;
		_eTarget = eTarget;
	}

	public function apply( oContext :MoveContext ) :Bool {

		switch( _eTarget ) {
			case Self: return oContext.mon_att.hasAspect( _oAspect );
			case SingleFoe: return oContext.mon_def.hasAspect( _oAspect );
			case Battle: return oContext.battle.hasAspect( _oAspect );
			default: throw '!!!';
		}
	}
}