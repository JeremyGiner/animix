package mon_calc.battle_aspect.weather;

import mon_calc.ds.ThisContext;

class Hail extends AWeather {

	public function new() {
		super([OnTurnEnd],[],[],5);
	}

	override function onTurnEnd( oContext :ThisContext ) {
		super.onTurnEnd( oContext );

		for( oMon in [
			oContext.battle.getCurrentMon( false ),
			oContext.battle.getCurrentMon( true ),
		]) {
			if( oMon.hasHitType( Ice ) ) continue;

			oContext.processor.damage2( 
				oMon, 
				Math.floor( oMon.getMaxHealth() / 16 ),
				null, this
			);
		}
	}
}