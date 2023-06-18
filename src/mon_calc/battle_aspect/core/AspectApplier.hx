package mon_calc.battle_aspect.core;

import mon_calc.aspect.core.IAspectBearer;
import mon_calc.ds.enumeration.EPriorityAttack;
import mon_calc.ds.ThisContext;
import mon_calc.aspect.core.AAspect;
import mon_calc.ds.MoveContext;
import mon_calc.ds.EPriority;
import mon_calc.ds.ETargetType;
import mon_calc.entity.Battle;


class AspectApplier extends AAspect {
	
	var _fnCallback :ThisContext->MoveContext->Dynamic;
	var _eTarget :ETargetType;
	var _ePriority :EPriorityAttack;
	var _fChance :Null<Float>;
	
	public function new( 
		fnCallback :ThisContext->MoveContext->IAspect, 
		eTarget :ETargetType, 
		ePriority :EPriorityAttack = Damage,
		fChance :Null<Float> = null
	) {
		super([OnAttack],[],[]);
		_fnCallback = fnCallback;
		_eTarget = eTarget;
		_ePriority = ePriority;
		_fChance = fChance;
	}
	
	override public function getPriority() :String { return String.fromCharCode( cast _ePriority ); }

	override function onAttack(oContext:ThisContext, oEvent :MoveContext ) {
	
		// Case : miss
		if( _fChance != null && !oContext.processor.getChance(_fChance) ) {
			oContext.processor.log('miss');
			return;
		}
			
	
		var oAspect = _fnCallback( oContext, oEvent );
		if( oAspect == null ) return;
		
		oContext.processor.addAspect(
			_getTarget(oContext, oEvent), 
			oAspect, oEvent.mon_att, this 
		);
	}

	private function _getTarget( oContext :ThisContext, oEvent :MoveContext ) :IAspectBearer {
		switch( _eTarget ) {
			case Self: return oEvent.mon_att;
			case SingleFoe: return oEvent.mon_def;
			case AllyTeam: return oContext.battle.getTeam( oEvent.side_att );
			default: throw 'Unsupported target "'+_eTarget+'"';
		}
	}
}
