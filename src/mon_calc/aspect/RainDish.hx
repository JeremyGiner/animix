package mon_calc.aspect;

import mon_calc.battle_aspect.weather.Rain;
import mon_calc.ds.ThisContext;
import mon_calc.aspect.core.AAspect;


class RainDish extends AAspect {
	public function new() {
		super([OnTurnEnd],[],[]);
	}
	override function onTurnEnd( oContext :ThisContext ) {

		if( ! oContext.battle.hasAspectByClass(Rain) ) return;
		if( oContext.mon == null ) throw '!!!';
		var oMon = oContext.mon;

		oContext.processor.heal2( oMon, Math.floor( oMon.getMaxHealth() / 16 ), oMon, this );
	}
}