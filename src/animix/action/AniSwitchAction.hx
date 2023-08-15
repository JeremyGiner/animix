package animix.action;

import mon_calc.action.IAction;
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

	public function validate( oContext :Context ) {
		var oAni = oContext.battle.getTeam( _bSide ).getBattler( _iBattlerIndex );
		if( oAni == null || oAni.getHealth() <= 0 ) return false;
		return true;
	}

	public function process( oContext :Context ) {
		throw '!!!'; 
	} 


}