package mon_calc.aspect;

import mon_calc.ds.ThisContext;
import mon_calc.ds.event.StatCalcContext;
import mon_calc.battle_aspect.IAspect;
import mon_calc.aspect.core.AAspect;


class WeatherSpeed extends AAspect {
	var _oAspectClass :Class<IAspect>;
	public function new( oAspectClass :Class<IAspect> ) {
		super([OnStatCalc],[Self],[]);
		_oAspectClass = oAspectClass;
	}
	
	override function onStatCalc(oContext:ThisContext, oEvent:StatCalcContext) {
		if( oContext.battle.hasAspectByClass(_oAspectClass) ) {
			oEvent.stat.set(Speed,oEvent.stat.get(Speed) * 2);
		}
	}
}