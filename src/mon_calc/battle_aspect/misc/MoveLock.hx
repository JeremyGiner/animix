package mon_calc.battle_aspect.misc;

class MoveLock implements IOnAttack {

	public function getPriority() {
		return '0';// before everything 
	}

	public function onAttack( oContext :MoveContext ) :Bool;
}