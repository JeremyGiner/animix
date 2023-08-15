package mon_calc.aspect.terrain;

import mon_calc.tool.MonTool;
import mon_calc.ds.ThisContext;
import mon_calc.ds.event.DamageCalcContext;
import mon_calc.aspect.core.AAspect;

class GrassyTerrain extends AAspect {
	public function new() {
		super([OnDamageCalc,OnTurnEnd],[],[],5);
	}
// TODO : replace other terrain
// TODO : priority
	
	override function onDamageCalc(oContext:ThisContext, oEvent:DamageCalcContext) {
		if( oEvent.damage.getHitType() != Grass ) return;
		oEvent.factor *= 1.5;
	}

	override function onTurnEnd( oContext :ThisContext ) {
		super.onTurnEnd( oContext );

		for( oMon in [
			oContext.battle.getCurrentMon(false),
			oContext.battle.getCurrentMon(true), 
		] ) {
			if( ! MonTool.isGrounded( oMon ) ) return;
			if( MonTool.isUnderground( oMon ) ) return;
	
			oContext.processor.heal2( 
				oMon, 
				Math.floor(oMon.getMaxHealth()/16),
				null, this
			);
		}
		
	}
}