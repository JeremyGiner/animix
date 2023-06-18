package mon_calc.effect.attack;

import mon_calc.ds.MoveContext;

class MultiHit2
implements IEffect {

	var _oDamage :Damage;

	public function new( oDamage :Damage ) {
		_oDamage = oDamage;
	}

	public function onAttack( oContext :MoveContext ) {
		for( i in 0...3 ) {
			_oDamage.onAttack( oContext );
		}
	}
}