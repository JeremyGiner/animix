package mon_calc.battle_aspect.status;

import mon_calc.ds.ThisContext;
import mon_calc.aspect.core.AAspect;
import mon_calc.ds.MoveContext;
import mon_calc.entity.Battle;
import mon_calc.entity.Mon;

class PoisonStatus extends AMainStatus {

	public function new() {
		super([OnTurnEnd],[],[]);
	}

	override function onTurnEnd( oContext :ThisContext) {
		var oMon :Mon = cast oContext.owner;
		oMon.damagePercent( 1/8 );

		// Turnover
		oContext.processor.log('TOTO suffer from poison');
	}

}