package mon_calc.effect.aspect_remover;

import mon_calc.ds.ETargetType;
import mon_calc.ds.enumeration.EPriorityAttack;
import mon_calc.ds.ThisContext;
import mon_calc.ds.MoveContext;
import mon_calc.ds.enumeration.EAspectFlag;
import mon_calc.aspect.core.AAspect;

class AspectRemoverByFlag extends AAspect {

	var _eTarget :ETargetType;
	var _ePriority :EPriorityAttack;
	var _eFlag :EAspectFlag;

	public function new( eFlag :EAspectFlag, eTarget :ETargetType, ePriority :EPriorityAttack ) {
		super([OnAttack],[],[]);
	}

	override function onAttack(oContext:ThisContext, oEvent:MoveContext) {
		var oTarget = _getTarget( oContext, oEvent );
		for( oAspect in oTarget.getAspectAr() ) {
			if( ! oAspect.hasFlag( _eFlag ) ) continue;
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