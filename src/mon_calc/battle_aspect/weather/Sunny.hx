package mon_calc.battle_aspect.weather;

import mon_calc.ds.event.DamageCalcContext;
import mon_calc.ds.ThisContext;

class Sunny extends AWeather {

	public function new() {
		super([OnDamageCalc],[],[],5);
	}

	override function onDamageCalc( oContext :ThisContext, oEvent :DamageCalcContext ) {
		var oDamage = oEvent.damage;
		if( oDamage.getHitType() == Fire ) 
			oEvent.factor *= 1.5;
		if( oDamage.getHitType() == Water  ) 
			oEvent.factor *= 0.5;
	}
}