package mon_calc.core.entity;

import mon_calc.core.aspect.AAspectBearer;


class ABattleSlot<CBattler> extends AAspectBearer {
	
	var _bSide :Bool;
	var _oBattler :CBattler;

//_____________________________________________________________________________
// Constructor

	private function new( bSide :Bool, oBattler :CBattler ) {
		_bSide = bSide;
		_oBattler = oBattler;
		super([]);
	}

//_____________________________________________________________________________
// Accessor

	public function getBattler() { return _oBattler; }
	
//_____________________________________________________________________________
// Modifier

	public function switchMon( oBattler :CBattler ) {
		_oBattler = oBattler;
	}
}