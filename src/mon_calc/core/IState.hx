package mon_calc.core;

import mon_calc.core.aspect.IAspect;
import animix.entity.Ani;
import mon_calc.core.effect.IEffect;

interface IState {
	public function process() :IState;
	public function trigger<C>( oInterface :Class<IEffect<C>>, oEvent :C ) :C;

	public function getChance( f :Float ) :Bool;
	public function addAspect( oTarget :Ani, oAspect :IAspect ) :Void;
}

