package mon_calc.battle_aspect.weather;

import mon_calc.ds.ThisContext;
import mon_calc.ds.event.StatCalcContext;

class SandStorm extends AWeather {

	public function new() {
		super([OnStatCalc,OnTurnEnd],[],[],5);
	}

	override function onStatCalc(oContext:ThisContext, oEvent:StatCalcContext) {
		if( oEvent.mon.hasHitType( Rock ) )
			oEvent.stat.set( Res, Math.floor( oEvent.stat.get(Res) * 1.5 ) );
	}

	override function onTurnEnd( oContext :ThisContext ) {
		super.onTurnEnd( oContext );

		for( oMon in [
			oContext.battle.getCurrentMon( false ),
			oContext.battle.getCurrentMon( true ),
		]) {
			if( 
				oMon.hasHitType( Rock ) 
				|| oMon.hasHitType( Steel )
				|| oMon.hasHitType( Ground )
			) continue;

			oContext.processor.damage2( 
				oMon, 
				Math.floor( oMon.getMaxHealth() / 16 ),
				null, this
			);
		}
	}
}