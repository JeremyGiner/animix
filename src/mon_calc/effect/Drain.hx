package mon_calc.effect;

import mon_calc.ds.ThisContext;
import mon_calc.ds.MonDamageContext;
import mon_calc.aspect.core.AAspect;
import mon_calc.tool.IntTool;

class Drain extends AAspect {

	public function new() {
		super([OnDamagePost],[Dealing],[]);
	}
	
	override function onDamagePost(oContext :ThisContext, oEvent :MonDamageContext) {
		oContext.processor.heal({
			type: OnHealPre,
			attack_context: oEvent.attack_context,
			mon_att: oEvent.mon_att,
			target: oEvent.mon_att,
			source: this,
			damage: IntTool.max( 1, IntTool.div( oEvent.damage, 2 ) ),
			prevent_default: true,
		});
	}
}