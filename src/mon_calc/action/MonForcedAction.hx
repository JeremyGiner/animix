package mon_calc.action;

import mon_calc.entity.Move;
import mon_calc.entity.Battle;

class MonForcedAction extends MonMoveAction {

	var _oMove :Move;

	public function new( bSide :Bool, oMove :Move ) {
		if( oMove == null ) throw '!!!';
		_oMove = oMove;
		super(_bSide,0);
	}

	override public function getMove( oBattle :Battle ) {
		return _oMove;
	}

	override public function validate( oBattle :Battle ) :Bool {
		// TODO : check if current mon has dance aspect

		return true;
	}

	
}