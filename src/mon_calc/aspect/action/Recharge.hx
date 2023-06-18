package mon_calc.aspect.action;

import mon_calc.ds.ThisContext;
import mon_calc.ds.event.ActionPromptContext;
import mon_calc.aspect.core.AAspect;
import mon_calc.entity.Move;
import mon_calc.action.MonForcedAction;

class Recharge extends AAspect {
	public function new() {
		super([OnActionPrompt],[],[]);
	}

	override function onActionPrompt(oContext:ThisContext, oEvent:ActionPromptContext) {
		oContext.processor.removeAspect( oContext.owner, this, this );
		oEvent.action = [new MonForcedAction(oEvent.side, 
			new Move('RECHARGE','Recharge',null,null,Self,[]))];
	}
}