package mon_calc.battle_aspect.misc;

import mon_calc.ds.ThisContext;
import mon_calc.ds.event.ActionPromptContext;
import mon_calc.aspect.core.AAspect;
import mon_calc.action.MonForcedAction;
import mon_calc.entity.Move;

class Charge extends AAspect {

	var _oBaseMove :Move;

	public function new( oBaseMove :Move ) {
		_oBaseMove = oBaseMove;
		super([OnActionPrompt],[],[],1);// TODO : check behavior with turnover aspect
	}

	override function onActionPrompt( oContext:ThisContext, oEvent :ActionPromptContext ) {
		if( getFadeCount() <= 0 )
			oEvent.action = [new MonForcedAction( oEvent.side, _oBaseMove )];
	}
}