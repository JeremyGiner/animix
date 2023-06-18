package mon_calc.aspect.trap;

import mon_calc.aspect.core.IAspectBearer;
import mon_calc.core.BattleProcessor;
import mon_calc.ds.event.SwitchInContext;
import mon_calc.ds.ThisContext;
import mon_calc.aspect.core.AAspect;
import mon_calc.entity.Mon;
import mon_calc.entity.Battle;
import mon_calc.tool.MonTool;

class Spike extends AAspect implements IStackable {

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
		
		oContext.processor.damage2(
			oMon,
			Math.floor( oMon.getMaxHealth() * _getPercent() ),
			null, this, null 
		);
	}

	private function _getPercent() {
		switch( _iLayer ) {
			case 1: return 1/8;
			case 2: return 1/6;
		} 
		return 1/4;
	}
}