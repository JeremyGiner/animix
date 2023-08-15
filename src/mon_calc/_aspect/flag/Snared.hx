package mon_calc.aspect.flag;

import mon_calc.action.MonSwitch;
import mon_calc.ds.ThisContext;
import mon_calc.ds.event.ActionPromptContext;
import mon_calc.aspect.core.AAspect;

/**
 * Prevent switch from owner
 */
class Snared extends AAspect {

	public function new() {
		super([OnActionPrompt],[Self],[]);
	}
	
	override function onActionPrompt(oContext:ThisContext, oEvent:ActionPromptContext) {
		oEvent.action = oEvent.action.filter(function( oAction ) {
			return !Std.isOfType(oAction,MonSwitch);
		});
	}
}