package mon_calc.battle_aspect.status;

import mon_calc.ds.ThisContext;
import mon_calc.effect.Damage;
import mon_calc.ds.MonDamageContext;
import mon_calc.tool.IntTool;
import mon_calc.entity.EStat;
import mon_calc.ds.MoveContext;

class Freeze extends AMainStatus {

	public function new() {
		super([OnAttack,OnDamagePost],[],[]);
	}
	override function onAttack( oContext:ThisContext, oEvent :MoveContext ) {

		// Check if still present (Fix AntiFreeze removal)
		if( !oContext.owner.getAspectAr().contains( this ) ) return;

		// On owner making a move
		if( oContext.owner != oEvent.mon_att ) return;

		// Case: 80% unlucky turnover
		if( ! oContext.processor.getChance( 0.20 ) ) {
			// Turnover
			oEvent.turnover = true;
			oContext.processor.log('TODO is frozen');
			return;
		}

		// Recover
		oContext.processor.removeAspect( oContext.owner, this, this );
	}

	override function onDamagePost(oContext:ThisContext, oEvent:MonDamageContext) {

		if( !Std.isOfType( oEvent.source, Damage ) ) return;
		var oDamage :Damage = cast oEvent.source;
		if( oDamage.getHitType() == Fire ) {
			oContext.processor.removeAspect( oContext.owner, this, this );
		}
	}

}