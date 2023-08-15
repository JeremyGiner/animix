package animix.state;

import animix.ds.Context;
import mon_calc.core.effect.IEffect;
import mon_calc.core.IState;


class TriggerState implements IState {

	var _oContext :Context;
	var _oClass :Class<IEffect<>>;
	var _oNext :IState;

	public function new(
		oContext :Context,
		oClass :Class<IEffect>,
		oNext :IState
	) {
		_oContext = oContext;
		_oClass = oClass;
		_oNext = oNext;
	}

	public function process() {
		trigger(_oClass,{});

		_oContext.state = _oNext;
	}


}