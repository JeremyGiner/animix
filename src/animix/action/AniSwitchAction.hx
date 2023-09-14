package animix.action;

import animix.entity.Battle;
import animix.ds.Context;

class AniSwitchAction implements IAction {

	var _bSide :Bool;
	var _iBattlerIndex :Int;

	public function new( bSide :Bool, iMonIndex :Int ) {
		_bSide = bSide;
		_iBattlerIndex = iMonIndex;
	}

	public function getSide() { return _bSide; }
	public function getMonIndex() { return _iBattlerIndex; }
	public function getAni( oBattle :Battle ) { 
		return oBattle
			.getTeam( _bSide )
			.getFighter( _iBattlerIndex );
	}

	public function validate( oBattle :Battle ) {
		var oAni = getAni( oBattle );
		if( oAni == null || oAni.getHealth() <= 0 ) return false;
		return true;
	}

	public function process( oBattle :Battle ) {
		throw '!!!'; 
	} 


}