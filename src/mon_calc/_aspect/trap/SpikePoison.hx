package mon_calc.aspect.trap;

import mon_calc.aspect.core.IAspectBearer;
import mon_calc.core.BattleProcessor;
import mon_calc.ds.ThisContext;
import mon_calc.ds.event.SwitchInContext;
import mon_calc.aspect.core.AAspect;
import mon_calc.battle_aspect.status.DeadlyPoisonStatus;
import mon_calc.battle_aspect.status.PoisonStatus;
import mon_calc.tool.MonTool;

class SpikePoison extends AAspect implements IStackable {

	var _iLayer :Int;

	public function new() {
		super([OnSwitchIn],[Ally/*Trap in on team side*/],[Trap]);
		_iLayer = 1;
	}

	public function getStack() :Int { return _iLayer; }

	public function addStack( 
		oProcessor :BattleProcessor, 
		oTarget :IAspectBearer,  
		oAspect :IStackable 
	) {
		_iLayer ++; 
	}

	override function onSwitchIn(oContext:ThisContext, oEvent:SwitchInContext) {
		var oMon = oEvent.mon;
		if( ! MonTool.isGrounded( oMon ) ) return;
		if( ! MonTool.isPoisonable( oMon ) ) return;
		// Apply poison
		oContext.processor.addAspect( oMon, _getAspect(), null, this );
	}

	private function _getAspect() {
		if(_iLayer == 1 ) return new PoisonStatus();
		return new DeadlyPoisonStatus();
	}
}