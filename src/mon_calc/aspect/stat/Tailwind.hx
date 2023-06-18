package mon_calc.aspect.stat;

import mon_calc.ds.ThisContext;
import mon_calc.ds.event.StatCalcContext;
import mon_calc.aspect.core.AAspect;
import mon_calc.entity.EStat;
import mon_calc.ds.EPriority;

class Tailwind extends AAspect {
	public function new() {
		super([OnStatCalc],[Ally],[],5);
	}

	override function onStatCalc( oContext :ThisContext, oEvent :StatCalcContext ) {
		oEvent.stat.set( Speed, oEvent.stat.get(Speed) * 2  );
	}

}