class PreventCrit implements IOnAttack {
	public function getPriority() :String { 
		return cast(EPriority.precalc,String) + '0'; // After calc but before execution
	}
	public function onAttack( oContext :MoveContext ) {
		oContext.crit_chance = 0;
	}
}