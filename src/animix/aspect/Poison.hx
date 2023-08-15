package animix.aspect;

import animix.event.TurnContext;
import animix.core.effect.OnTurnEnd;
import mon_calc.core.aspect.AAspect;
import animix.ds.Context;


class Poison extends AAspect implements OnTurnEnd {

	var _iPower :Int;
	var _iFade :Int;

	public function new(
		iPower :Int
	) {
		_iPower = iPower;
		_iFade = 1;
		super([]);
	}

	public function notify( oContext :Context, oEvent :TurnContext ) {

		throw 'TODO';
	}
}
