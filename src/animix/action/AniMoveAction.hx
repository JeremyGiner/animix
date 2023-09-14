package animix.action;

import animix.entity.Battle;

class AniMoveAction implements IAction {

	var _bSide :Bool;
	var _iMoveId :Null<Int>;

	public function new( bSide :Bool, iMoveId :Null<Int> ) {
		_bSide = bSide;
		_iMoveId = iMoveId;
	}

	public function getSide() { return _bSide; }

	public function getMove( oBattle :Battle ) {
		var oAni = oBattle.getCurrentMon( _bSide );
		if( _iMoveId == null ) {
			return oAni.getType().getDefaultMove();
		}
		return oAni.getMove( _iMoveId );
	}

	public function validate( oBattle :Battle ) :Bool {

		// TODO : check if current mon has move

		return true;
	}

	public function process( oGame :Battle ) {
		// Do nothing action is processed by Battle
	}

	
}