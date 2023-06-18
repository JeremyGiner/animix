package mon_calc.effect.aspect_applier;

import mon_calc.ds.ETargetType;
import mon_calc.aspect.core.IAspectBearer;
import mon_calc.battle_aspect.IAspect;
import mon_calc.ds.MoveContext;
import mon_calc.ds.ThisContext;
import mon_calc.aspect.core.AAspect;

class SimpleApplier extends AAspect {

	var _oClass :Class<IAspect>;
	var _eTarget :ETargetType;

	public function new( oClass :Class<IAspect>, eTarget :ETargetType ) { 
		super([OnAttack],[Dealing],[]);
		_oClass = oClass;
		_eTarget = eTarget;
	}

	override function onAttack( oContext :ThisContext, oEvent :MoveContext ) {
		var oAspect = Type.createInstance( _oClass, [] );
		if( oAspect == null ) return;
		
		oContext.processor.addAspect(
			_getTarget(oContext, oEvent), 
			oAspect, oEvent.mon_att, this
		);
	}

	private function _getTarget( oContext :ThisContext, oEvent :MoveContext ) :IAspectBearer {
		switch( _eTarget ) {
			case Battle: return oContext.battle;
			case Self: return oEvent.mon_att;
			case SingleFoe: return oEvent.mon_def;
			case AllyTeam: return oContext.battle.getTeam( oEvent.side_att );
			default: throw 'Unsupported target "'+_eTarget+'"';
		}
	}
}