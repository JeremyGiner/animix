package mon_calc.effect.heal;

import mon_calc.battle_aspect.status.AMainStatus;
import mon_calc.battle_aspect.status.SleepStatus;
import mon_calc.ds.ThisContext;
import mon_calc.ds.MoveContext;
import mon_calc.aspect.core.AAspect;

class Rest extends AAspect {
	public function new() {
		super([OnAttack],[Dealing],[]);
	}

	override function onAttack( oContext :ThisContext, oEvent :MoveContext ) {
		var oMon = oEvent.mon_att;

		var oPrev = oMon.getAspectOneByClass(AMainStatus);
		if( oPrev != null ) 
			oContext.processor.removeAspect( oMon, oPrev, this );

		var oSleep = new SleepStatus(2);
		oContext.processor.addAspect( oMon, oSleep, oMon, this );

		// Case : fail
		if( ! oMon.hasAspect( oSleep ) ) {
			oMon.addAspect( oPrev ); // Rollback
			oContext.processor.log('Rest failed');
			return;
		}

		oContext.processor.heal2( // Heal self 100%
			oMon, 
			oMon.getMaxHealth() - oMon.getHealth(),
			oMon,
			this,
			oEvent
		);
		
	}
}