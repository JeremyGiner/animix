package mon_calc.effect.attack;

import mon_calc.ds.ThisContext;
import mon_calc.aspect.core.AAspect;
import mon_calc.ds.MoveContext;

class MultiHit5 extends AAspect {

	var _oDamage :Damage;

	public function new( oDamage :Damage ) {
		super([OnAttack],[],[]);
		_oDamage = oDamage;
	}

	override function onAttack(oContext:ThisContext, oEvent:MoveContext) {
		var bSkillLink = false; // TODO :oContext.mon_att.hasFlag(SkillLink);
		
		var iHitCount = bSkillLink ? 5 : oContext.processor.getChanceAr([2,3,4,5]);

		for( i in 0...(iHitCount+1) ) {
			_oDamage.onAttack( oContext, oEvent );
		}
	}
}