package mon_calc.aspect.terrain;

import mon_calc.ds.PairAspectContext;
import mon_calc.ds.AspectExecuteContext;
import mon_calc.ds.event.DamageCalcContext;
import mon_calc.tool.MonTool;
import mon_calc.entity.Mon;
import mon_calc.battle_aspect.status.SleepStatus;
import mon_calc.ds.ThisContext;
import mon_calc.ds.event.AspectEntryContext;

class ElectricTerrain extends ATerrain {
	
	public function new() {
		super([OnDamageCalc,OnTurnStart],[/*TODO:Grounded*/],[],5);
	}

	override function onDamageCalc(oContext:ThisContext, oEvent:DamageCalcContext) {
		
		if( oEvent.damage.getHitType() == Electric ) {
			oEvent.factor *= 1.5;
		}
	}

	override function onTurnStart( oContext :ThisContext ) {

		// Remove sleep from grounded mon
		var aMon = [
			oContext.battle.getCurrentMon(true),
			oContext.battle.getCurrentMon(false),
		];
		for( oMon in aMon ) {
			// Filter not grounded
			if( 
				! MonTool.isGrounded( oMon ) 
				|| MonTool.isUnderground( oMon )
			) continue;

			var oSleep = oMon.getAspectByClass(SleepStatus);
			if( oSleep == null ) continue;
			oContext.processor.removeAspect(oMon,oSleep,this);
		}
		
	}

	override function onAspectEntryPre(
		oContext:ThisContext,
		oEvent:AspectEntryContext
	) {
		// Filter : Sleep
		if( !Std.isOfType( oEvent.aspect, SleepStatus ) ) return;

		// Prevent sleep for grounded Mon
		if( !Std.isOfType( oEvent.aspect, SleepStatus ) ) return;
		if( !Std.isOfType( oEvent.target, Mon ) ) return;
		var oTarget = cast(oEvent.target,Mon);
		if( 
			! MonTool.isGrounded( oTarget ) 
			|| MonTool.isUnderground( oTarget )
		) return;
		
		// Prevent process
		oEvent.prevent_default = true;
		// oContext.battle.filterProcess((oPair :PairAspectContext) -> {
		// 	return oProcess != oPair.aspect;
		// });
	}
	
}