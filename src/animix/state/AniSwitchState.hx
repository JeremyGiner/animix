package animix.state;

import animix.core.effect.OnSwitchOut;
import animix.core.effect.OnSwitchIn;
import animix.entity.Ani;
import animix.action.AniSwitchAction;
import animix.ds.Context;
import mon_calc.action.IAction;
import mon_calc.core.IState;

class AniSwitchState extends BaseState {

	var _oContext :Context;
	var _oActionRed :IAction;
	var _oActionBlue :IAction;

	public function new( 
		oContext :Context,  
		oActionRed : IAction, 
		oActionBlue :IAction
	) {
		_oContext = oContext;
		_oActionRed = oActionRed;
		_oActionBlue = oActionBlue;
	}

	public function process() {
		if( Std.isOfType( _oActionRed, AniSwitchAction ) ) {
			var oSwtichAction = cast( _oActionRed, AniSwitchAction);
			switchAni(false, oSwtichAction.getMonIndex());
		}
		if( Std.isOfType( _oActionBlue, AniSwitchAction ) ) {
			var oSwtichAction = cast(_oActionBlue, AniSwitchAction);
			switchAni(true, oSwtichAction.getMonIndex());
		}

		_oContext.state = new AniMoveState( _oContext );
	}


	private function switchAni( bSide :Bool, iAniIndex :Int ) {
		
		trigger(OnSwitchOut,{
			type: OnSwitchOut,
			side: bSide, 
			mon: _oContext.battle.getCurrentMon( bSide ),
		});

		var oTeam = _oContext.battle.getTeam( bSide );
		var oAni = oTeam.getMon( iAniIndex );

		_oContext.battle.getBattleSlot( bSide ).switchMon( oAni );

		trigger(OnSwitchIn,{
			type: ,
			side: bSide, 
			mon: oAni,
		});
	}
}