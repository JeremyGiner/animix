package mon_calc.aspect.ability;

import mon_calc.aspect.core.IAspectBearer;
import mon_calc.ds.ETargetType;
import mon_calc.battle_aspect.IAspect;
import mon_calc.ds.ThisContext;
import mon_calc.ds.event.SwitchInContext;
import mon_calc.aspect.core.AAspect;

class SwitchInApplier extends AAspect {
	
	var _oClass :Class<IAspect>;
	var _eTarget :ETargetType;

	public function new( oClass :Class<IAspect>, eTarget :ETargetType ) { 
		super([OnSwitchIn],[Self],[]);
		_oClass = oClass;
		_eTarget = eTarget;
	}
	
	override function onSwitchIn( oContext:ThisContext, oEvent:SwitchInContext ) {
		var oAspect = Type.createInstance( _oClass, [] );
		if( oAspect == null ) return;
		
		oContext.processor.addAspect(
			_getTarget(oContext, oEvent), 
			oAspect, oEvent.mon, this
		);
	}

	private function _getTarget( 
		oContext :ThisContext, 
		oEvent :SwitchInContext 
	) :IAspectBearer {
		switch( _eTarget ) {
			case Battle: return oContext.battle;
			case Self: return oEvent.mon;
			case AllyTeam: return oContext.battle.getTeam( oEvent.side );
			default: throw 'Unsupported target "'+_eTarget+'"';
		}
	}
}