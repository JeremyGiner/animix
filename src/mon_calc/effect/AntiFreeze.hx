package mon_calc.effect;

import mon_calc.ds.MoveContext;
import mon_calc.battle_aspect.status.Freeze;
import mon_calc.ds.ThisContext;
import mon_calc.ds.MonDamageContext;
import mon_calc.aspect.core.AAspect;
import mon_calc.tool.IntTool;

class AntiFreeze extends AAspect {

	public function new() {
		super([OnDamagePost,OnAttack],[],[]);
	}
	
	override function onAttack( oContext:ThisContext, oEvent:MoveContext ) {
		
		// When attacking with antifreeze
		if( oContext.owner != oEvent.mon_att ) return;

		// Only if self is Frozen
		var oFreeze = oContext.owner.getAspectByClass(Freeze);
		if( oFreeze == null ) return;
		
		oContext.processor.removeAspect( oContext.owner, oFreeze, this );
	}

	override function onDamagePost(oContext :ThisContext, oEvent :MonDamageContext) {

		// When dealing damage
		if( oContext.owner != oEvent.mon_att ) return;

		// Only if target is Frozen
		var oFreeze = oEvent.target.getAspectByClass(Freeze);
		if( oFreeze == null ) return;


		oContext.processor.removeAspect( oEvent.target, oFreeze, this );
	}
}