package mon_calc.aspect.endturn;

import mon_calc.action.MonSwitch;
import mon_calc.ds.event.ActionPromptContext;
import mon_calc.ds.event.SwitchOutContext;
import mon_calc.entity.Mon;
import mon_calc.ds.ThisContext;
import mon_calc.aspect.core.AAspect;

class Bind extends AAspect {

	var oEmiter :Mon;

	public function new( oEmiter :Mon, iTurn :Int ) {
		super([OnActionPrompt,OnTurnEnd,OnSwitchOut],[],[Trap], iTurn);
	}

	override function onActionPrompt(oContext:ThisContext, oEvent:ActionPromptContext) {
		oEvent.action = oEvent.action.filter(function( oAction ) {
			return !Std.isOfType(oAction,MonSwitch);
		});
	}
	override function onTurnEnd( oContext :ThisContext ) {
		super.onTurnEnd(oContext);
		var oMon = oContext.mon;
		oContext.processor.damage2( oMon, Math.floor( oMon.getMaxHealth() / 16 ), null, this );
	}
	override function onSwitchOut(oContext:ThisContext, oEvent:SwitchOutContext) {
		if( oEvent.mon == oEmiter ) {
			oContext.processor.removeAspect( oContext.owner, this, this );
		}
	}
}