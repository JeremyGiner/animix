package animix.entity;

import mon_calc.core.aspect.AAspectBearer;


class Battle extends AAspectBearer {
	
	var _oTeamRed :Team;
	var _oTeamBlue :Team;

	var _aBattleSlotRed :Array<BattleSlot>;
	var _aBattleSlotBlue :Array<BattleSlot>;

//_____________________________________________________________________________
// Constructor

	public function new(  
		oTeamRed :Team, oTeamBlue :Team
	) {
		super();
		_oTeamRed = oTeamRed;
		_oTeamBlue = oTeamBlue;

		_aBattleSlotRed = [new BattleSlot( false, _oTeamRed.getMon(0) )];
		_aBattleSlotBlue = [new BattleSlot( true, _oTeamBlue.getMon(0) )];
	}

//_____________________________________________________________________________
// Accessor

	public function getTeamRed() { return _oTeamRed; }
	public function getTeamBlue() { return _oTeamBlue; }
	public function getTeam( bSide :Bool ) { 
		return bSide ? _oTeamBlue : _oTeamRed; 
	}
	public function getCurrentMon( bSide :Bool ) { 
		return getBattleSlot( bSide ).getBattler(); 
	}

	public function getBattleSlot( bSide :Bool ) { 
		return bSide ? _aBattleSlotBlue[0] : _aBattleSlotRed[0]; 
	}

	public function isDone() {
		if( 
			_oTeamRed.hasValidMon() 
			|| _oTeamBlue.hasValidMon() 
		) return false;
		return true;
	}

	public function getSideFromAni( oAni :Ani ) {
		if( _oTeamRed.getMonAr().contains(oAni) ) return false;
		if( _oTeamBlue.getMonAr().contains(oAni) ) return true;
		throw '!!!';
	}
}