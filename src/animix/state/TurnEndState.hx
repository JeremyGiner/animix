package animix.state;

import animix.ds.Context;
import mon_calc.action.IAction;
import animix.entity.Battle;
import mon_calc.core.IState;

class TurnEndState implements IState {

	var _oContext :Context;

	var _aAction :Array<IAction>;

	public function new( oContext :Context, aAction :Array<IAction> ) {
		_oContext = oContext;
		_aAction = aAction;
	}

	public function process() {

		
		stackProcess( 
			new TriggerProcess({type: OnTurnStart}) 
		);


		_oContext.state = new AniActionState();
		return null;
	}


}