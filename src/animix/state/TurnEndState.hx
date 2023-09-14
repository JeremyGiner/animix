package animix.state;

import animix.core.aspect.OnTurnEnd;
import animix.entity.Battle;

class TurnEndState extends BaseState {

	public function new( oBattle :Battle ) {
		super( oBattle );
	}

	override public function process() {
		trigger(OnTurnEnd, {});
		
		return new AniActionState(_oBattle);
	}


}