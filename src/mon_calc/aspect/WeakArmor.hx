package mon_calc.aspect;

import mon_calc.effect.Damage;
import mon_calc.ds.ThisContext;
import mon_calc.ds.MonDamageContext;
import mon_calc.aspect.core.AAspect;
import mon_calc.battle_aspect.StatModifier;


class WeakArmor extends AAspect {
	public function new() {
		super([OnDamagePost],[Receiving],[]);
	}

	override function onDamagePost( oContext:ThisContext, oEvent:MonDamageContext ) {
		// TODO : how does it handle multihit ?
		if( !Std.isOfType( oEvent.source, Damage ) ) return;
		var oDamage = cast( oEvent.source, Damage );
		if( oDamage.getCategory() != Physic ) return;
		
		oContext.processor.addAspect( oContext.owner, new StatModifier([
			Def => -1,
			Speed => 1,
		]), oContext.mon, this);
	}
}