package mon_calc.entity;

import mon_calc.battle_aspect.StatModifier;
import mon_calc.core.entity.ABattleSlot;

class BattleSlot extends ABattleSlot<Mon> {

//_____________________________________________________________________________
// Constructor

	public function new( bSide :Bool, oMon :Mon ) {
		super(bSide, oMon);
	}

//_____________________________________________________________________________
// Accessor

	public function getMon() { return _oBattler; }
	
}