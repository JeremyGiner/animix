package mon_calc.battle_aspect.status;

import mon_calc.ds.ThisContext;
import mon_calc.entity.Mon;

class DeadlyPoisonStatus extends PoisonStatus {

	var _iStack :Int;

	public function new() {
		super();
		_iStack = 1;
	}

	override function onTurnEnd( oContext :ThisContext ) {
		var oMon :Mon = cast oContext.owner;
		oMon.damagePercent( _iStack/16 );
		_iStack++;

		// Turnover
		oContext.processor.log('TOTO suffer from deadly poison');
	}

}