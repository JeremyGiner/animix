package mon_calc.entity;

import mon_calc.battle_aspect.StatModifier;

class BattleSlot {
	
	var _bSide :Bool;
	var _oMon :Mon;

//_____________________________________________________________________________
// Constructor

	public function new( bSide :Bool, oMon :Mon ) {
		_bSide = bSide;
		_oMon = oMon;
	}

//_____________________________________________________________________________
// Accessor

	public function getMon() { return _oMon; }
	
//_____________________________________________________________________________
// Modifier

	public function switchMon( oMon :Mon ) {
		_oMon = oMon;
	}
}