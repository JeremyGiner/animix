package mon_calc.effect.attack;

import mon_calc.action.MonSwitch;
import mon_calc.ds.enumeration.EPriorityAttack;
import mon_calc.ds.ThisContext;
import mon_calc.aspect.core.AAspect;
import mon_calc.ds.MoveContext;

class TapOut extends AAspect {
	
	public function new() {
		super([OnAttack],[],[]);
	}
	override function getPriority() :String {
		return String.fromCharCode( cast EPriorityAttack.AfterDamage );
	}
	override function onAttack( oContext :ThisContext, oEvent :MoveContext ) {
		var oAction = oContext.processor.promptAction( 
			oEvent.side_att,
			oContext.processor.generatePlayerSwitchAction( oEvent.side_att ) 
		);
		if( oAction == null ) throw '!!!';

		oContext.processor.switchMon( 
			oEvent.side_att, 
			cast(oAction,MonSwitch).getMonIndex() 
		);
	}
}