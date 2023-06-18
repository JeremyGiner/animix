package mon_calc.aspect.move_changer;

import mon_calc.ds.EPriority;
import mon_calc.battle_aspect.IOnMoveEffective;

class HiddenPower implements IOnMoveEffective {
	public function getPriority() { return cast EPriority.Normal; /**TODO : lower than Electrify, higher than any other **/ }
	public function onMoveEffective( oBattle :Battle, oMon :Mon, oMove :Move ) {
		// TODO 
	}
}