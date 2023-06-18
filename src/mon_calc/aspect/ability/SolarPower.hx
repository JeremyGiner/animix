package mon_calc.aspect.ability;

import mon_calc.ds.ThisContext;
import mon_calc.ds.event.StatCalcContext;
import mon_calc.aspect.core.AAspect;

class SolarPower extends AAspect {
	public function new() {
		super([OnStatCalc,OnTurnEnd],[Self,WeatherSunny],[]);
	}

	override function onStatCalc( oContext :ThisContext, oEvent :StatCalcContext ) {
		// mag x1.5
		oEvent.stat.set( Mag, Math.floor( oEvent.stat.get(Mag) * 1.5 ) );
	}

	override function onTurnEnd( oContext :ThisContext) {
		var oMon = oContext.mon;
		if( oMon == null ) throw '!!!';
		oContext.processor.damage2(
			oMon, 
			Math.floor( oMon.getMaxHealth() * 1/8 ),
			null,
			this
		);
	}
}