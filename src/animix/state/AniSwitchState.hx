package animix.state;

import animix.action.IAction;
import animix.entity.Battle;
import animix.core.aspect.OnSwitchOut;
import animix.core.aspect.OnSwitchIn;
import animix.entity.Ani;
import animix.action.AniSwitchAction;
import animix.ds.Context;
import mon_calc.core.IState;

class AniSwitchState extends BaseState {

	var _oActionRed :IAction;
	var _oActionBlue :IAction;

	public function new( 
		oBattle :Battle,  
		oActionRed : IAction, 
		oActionBlue :IAction
	) {
		super(oBattle);
		_oActionRed = oActionRed;
		_oActionBlue = oActionBlue;
	}

	override public function process() {
		if( Std.isOfType( _oActionRed, AniSwitchAction ) ) {
			var oSwtichAction = cast( _oActionRed, AniSwitchAction);
			switchAni(false, oSwtichAction.getMonIndex());
		}
		if( Std.isOfType( _oActionBlue, AniSwitchAction ) ) {
			var oSwtichAction = cast(_oActionBlue, AniSwitchAction);
			switchAni(true, oSwtichAction.getMonIndex());
		}

		return new AniMoveState( _oBattle, _oActionRed, _oActionBlue );
	}


	private function switchAni( bSide :Bool, iAniIndex :Int ) {
		
		trigger(OnSwitchOut,{
			side: bSide, 
			subject: _oBattle.getCurrentMon( bSide ),
		});

		var oTeam = _oBattle.getTeam( bSide );
		var oAni = oTeam.getMon( iAniIndex );

		_oBattle.getBattleSlot( bSide ).switchMon( oAni );

		trigger(OnSwitchIn,{
			side: bSide, 
			subject: oAni,
		});
	}
}