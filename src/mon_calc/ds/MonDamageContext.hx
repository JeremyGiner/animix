package mon_calc.ds;

import mon_calc.ds.MoveContext;
import mon_calc.battle_aspect.IAspect;
import mon_calc.entity.Battle;
import mon_calc.entity.Mon;

typedef MonDamageContext = {
	var type :EEventType; // OnHealPre / OnHealPost / OnDamagePre / OnDamagePost
	var ?attack_context :MoveContext;
	
	var mon_att :Mon;
	var target :Mon;
	var source :IAspect;
	var damage :Int;
	var prevent_default :Bool;
}