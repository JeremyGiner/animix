package mon_calc.action;

import mon_calc.action.IAction;
import mon_calc.entity.Battle;

class AniMoveAction implements IAction {

	var _bSide :Bool;
	var _iMoveId :Int;

	public function new( bSide :Bool, iMoveId :Int ) {
		_bSide = bSide;
		_iMoveId = iMoveId;
	}

	public function getSide() { return _bSide; }

	public function getMove( oBattle :Battle ) {
		return oBattle.getCurrentMon( _bSide ).getMove( _iMoveId );
	}

	public function validate( oBattle :Battle ) :Bool {

		// TODO : check if current mon has move

		return true;
	}

	public function process( oGame :Battle ) {
		// Do nothing action is processed by Battle
	}

	
}