package animix.state;

import animix.ds.EStat;
import mon_calc.ds.Pair;
import mon_calc.core.aspect.IAspectBearer;
import animix.entity.Battle;
import animix.entity.Ani;
import mon_calc.core.aspect.IAspect;
import animix.core.aspect.OnSwitchOut;
import animix.core.aspect.OnSwitchIn;
import animix.core.aspect.OnMoveCalc;
import animix.core.aspect.OnMove;
import animix.core.aspect.OnStatCalc;
import animix.ds.Context;
import mon_calc.core.effect.IEffect;
import mon_calc.core.IState;

typedef PairEffect = Pair<Context,IEffect<Dynamic>>;

class BaseState implements IState {

	var _oBattle :Battle;

	private function new( oBattle :Battle ) {
		_oBattle = oBattle;
	}

	public function process() :IState{
		throw '!!';
	}
	
	public function trigger<C>( oInterface :Class<IEffect<C>>, oEvent :C )  {
		var a :Array<PairEffect> = cast []
			.concat(getAspectContextPair(oInterface, _oBattle))
			.concat(getAspectContextPair(oInterface, _oBattle.getTeamRed()))
			.concat(getAspectContextPair(oInterface, _oBattle.getTeamBlue()))
			.concat(getAspectContextPair(oInterface, _oBattle.getCurrentMon(false)))
			.concat(getAspectContextPair(oInterface, _oBattle.getCurrentMon(true)))
		;

		for ( pair in a ) {
			pair.B.notify( pair.A, oEvent );
		}
		return oEvent;
	}

	private function getAspectContextPair( 
		oInterface :Class<IEffect<Dynamic>>, 
		oBearer :IAspectBearer
	) :Array<PairEffect> {
		return oBearer
			.getAspectByClass(oInterface)
			.map((aspect :IEffect<Dynamic>) -> {
				return {
					A: {
						battle: _oBattle,
						process: cast this,
						aspect: cast aspect,
						bearer: oBearer,
					},
					B: aspect,
				};
			});
	}

	public function getChance( f :Float ) {
		if( f >= 1.0 ) {
			//log('Guarantee chance '+(fChance*100));
			return true;
		}
		return Math.random() < f;
	}

// TODO : put inside StateModifier

	public function addAspect( oTarget :Ani, oAspect :IAspect ) {
		// TODO  : reset OnStatCalc cache
		// TODO  : trigger OnAspectApply
		oTarget.addAspect( oAspect );
	}

	public function getCurrentStat( oAni :Ani, eStat :EStat ) :Int {

		// TODO : cache

		var oContext = {
			side: _oBattle.getSideFromAni( oAni ),
			subject: oAni,
			type: eStat,
			value: oAni.getStatEffective(eStat),
		};

		trigger(OnStatCalc, oContext);

		return oContext.value;
	}
	
}