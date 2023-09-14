package animix.state;

import animix.core.aspect.OnTurnStart;
import animix.ds.Context;
import mon_calc.action.IAction;
import animix.entity.Battle;
import mon_calc.core.IState;

class BattleBeginState extends BaseState {

	public function new(oBattle :Battle) {
		super(oBattle);
	}

	override public function process() :IState {
		return new AniActionState(_oBattle);
	}
}