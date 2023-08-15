package animix.state;

import mon_calc.core.aspect.IAspect;
import animix.core.aspect.OnSwitchOut;
import animix.core.effect.OnSwitchIn;
import animix.core.aspect.OnMoveCalc;
import animix.core.aspect.OnMove;
import animix.ds.Context;
import mon_calc.core.effect.IEffect;
import mon_calc.core.IState;

class BaseState implements IState {

	var _oContext :Context;

	private function new( oContext :Context ) {
		_oContext = oContext;
	}

	public function process() {
		throw '!!';
	}
	
	public function trigger<C>( oInterface :Class<IEffect<C>>, oEvent :C )  {
		var a :Array<IEffect<C>> = cast []
			.concat(_oContext.battle.getAspectByClass(oInterface))
			.concat(_oContext.battle.getTeamRed().getAspectByClass(oInterface))
			.concat(_oContext.battle.getTeamBlue().getAspectByClass(oInterface))
			.concat(_oContext.battle.get().getAspectByClass(oInterface))
		;

		for ( o in a ) {
			o.notify( _oContext, oEvent );
		}
		return oEvent;
	}

	public function getChance( f :Float ) {
		if( f >= 1.0 ) {
			//log('Guarantee chance '+(fChance*100));
			return true;
		}
		return Math.random() < f;
	}

	public function addAspect( oTarget :Ani, oAspect :IAspect ) {
		throw 'TODO';
	}
}