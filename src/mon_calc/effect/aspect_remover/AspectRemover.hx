package mon_calc.effect.aspect_remover;

import mon_calc.battle_aspect.IAspect;
import mon_calc.ds.enumeration.EPriorityAttack;
import mon_calc.ds.ETargetType;
import mon_calc.ds.ThisContext;
import mon_calc.ds.MoveContext;
import mon_calc.aspect.core.AAspect;

class AspectRemover extends AAspect {
	
	var _eTarget :ETargetType;
	var _ePriority :EPriorityAttack;
	var _aClass :Array<Class<IAspect>>;

	public function new( aClass :Array<Class<IAspect>>, eTarget :ETargetType, ePriority :EPriorityAttack ) {
		super([OnAttack],[],[]);
		_aClass = aClass;
		eTarget = _eTarget;
		ePriority = _ePriority;
	}

	override function getPriority():String {
		return String.fromCharCode( cast _ePriority );
	}
	
	override function onAttack( oContext :ThisContext, oEvent :MoveContext ) {
		var oTarget = _getTarget( oContext, oEvent );
		for( oClass in _aClass ) {
			var oAspect = oTarget.getAspectOneByClass( oClass );
			if( oAspect == null ) continue;
			oContext.processor.removeAspect( oTarget, oAspect, this );
		}
	}

	private function _getTarget( oContext :ThisContext, oEvent :MoveContext ) {
		switch( _eTarget ) {
			case Self: return oContext.owner;
			case AllyTeam: return oContext.battle.getTeam( oContext.side );
			case Battle: return oContext.battle;
			case OppoTeam: return oContext.battle.getTeam( !oContext.side );
			default: throw '!!!';
		}
		throw '!!!';
	}
}