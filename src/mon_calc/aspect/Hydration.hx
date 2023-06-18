package mon_calc.aspect;

import mon_calc.battle_aspect.status.AMainStatus;
import mon_calc.ds.ThisContext;
import mon_calc.aspect.core.AAspect;


class Hydration extends AAspect {

	public function new() {
		super([OnTurnEnd],[WeatherRain],[]); 
		// TODO : before yamn apply sleep, before burn/poison damage
	}
	
	override function onTurnEnd( oContext :ThisContext ) {

		var oStatus = oContext.owner.getAspectByClass(AMainStatus);
		if( oStatus == null ) return; 

		oContext.processor.removeAspect(
			oContext.owner,
			oStatus,
			this
		);
	}
}