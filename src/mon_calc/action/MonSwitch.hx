package mon_calc.action;

import mon_calc.entity.Battle;

class MonSwitch implements IAction {

	var _bSide :Bool;
	var _iMonIndex :Int;

	public function new( bSide :Bool, iMonIndex :Int ) {
		_bSide = bSide;
		_iMonIndex = iMonIndex;
	}

	public function getSide() { return _bSide; }
	public function getMonIndex() { return _iMonIndex; }

	public function validate( oBattle :Battle ) {
		var oTeam = oBattle.getTeam( _bSide );
		var oMon = oTeam.getMon( _iMonIndex );
		if( oMon == null || oMon.getHealth() <= 0 ) return false;
		return true;
	}

	public function process( oBattle :Battle ) {
		throw '!!!'; 
	} 


}