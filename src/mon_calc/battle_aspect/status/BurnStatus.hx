package mon_calc.battle_aspect.status;

import mon_calc.ds.event.DamageCalcContext;
import mon_calc.ds.ThisContext;
import mon_calc.ds.event.StatCalcContext;
import mon_calc.aspect.core.AAspect;
import mon_calc.entity.Battle;
import mon_calc.effect.Damage;
import mon_calc.ds.MonDamageContext;
import mon_calc.ds.MoveContext;
import mon_calc.entity.Mon;

class BurnStatus extends AMainStatus {

	public function new() {
		super([OnDamageCalc,OnTurnEnd],[Self],[]);
	}

	override function onDamageCalc( oContext :ThisContext, oEvent :DamageCalcContext ) {
		if( oEvent.damage.getCategory() == Physic ) {
			oEvent.factor *= 0.5;
		}
	}

	override function onTurnEnd( o :ThisContext ) {
		if( ! Std.isOfType(o.owner,Mon) ) throw '!!!';
		var oMon :Mon = cast o.owner;

		oMon.damagePercent( 1/8 ); // 1/16 gen 7

		// Turnover
		o.processor.log(oMon.getLabel() + ' suffer from burn');
	}

}