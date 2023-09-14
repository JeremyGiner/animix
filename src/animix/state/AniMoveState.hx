package animix.state;

import animix.core.aspect.OnMoveCalc;
import animix.event.MoveCalcContext;
import animix.action.AniMoveAction;
import animix.action.IAction;
import animix.entity.Battle;
import animix.core.aspect.OnMove;
import animix.state.TurnEndState;
import animix.entity.Ani;
import animix.action.AniSwitchAction;
import animix.ds.Context;
import mon_calc.core.IState;

class AniMoveState extends BaseState {

	var _oActionRed :IAction;
	var _oActionBlue :IAction;

	public function new( 
		oBattle :Battle,  
		oActionRed: IAction, 
		oActionBlue :IAction
	) {
		super(oBattle);
		_oActionRed = oActionRed;
		_oActionBlue = oActionBlue;
	}

	override public function process() {

		var oBattle = _oBattle;
		var aEvent :Array<MoveCalcContext> = [];
		if( Std.isOfType( _oActionRed, AniMoveAction ) ) {
			var oMove = cast(_oActionRed, AniMoveAction).getMove(_oBattle);
			aEvent.push({
				side: false,
				mon: oBattle.getCurrentMon(false),
				move_origin: oMove,
				move: oMove,
			} );
		}
		if( Std.isOfType( _oActionBlue, AniMoveAction ) ) {
			var oMove = cast(_oActionBlue, AniMoveAction).getMove(_oBattle);
			aEvent.push({
				side: true,
				mon: oBattle.getCurrentMon(true),
				move_origin: oMove,
				move: oMove,
			} );
		}


		// Transform moves
		for( oEvent in aEvent ) {
			trigger( OnMoveCalc, oEvent );
		}

		// _oBattle.state = new TriggerState(
		// 	_oBattle,
		// 	OnQuickAttack,
		// 	new TriggerState(
		// 		_oBattle,
		// 		OnAttack,
		// 		new TriggerState(
		// 			_oBattle,
		// 			OnAttackSlow,
		// 			new TriggerState(
		// 				_oBattle,
		// 				OnTurnEnd,
		// 				new AniActionState(_oBattle)
		// 			)
		// 		)
		// 	)
		// );

		// Sort by priority
		// TODO : trigger move priority
		aEvent.sort(function( a :MoveCalcContext, b :MoveCalcContext ) {
			var i = Reflect.compare(
				b.move.getPriority(),
				a.move.getPriority() 
			);
			if( i == 0 )
				return -Reflect.compare(
					getCurrentStat( 
						_oBattle.getCurrentMon( a.side ),
						Speed
					),
					getCurrentStat( 
						_oBattle.getCurrentMon( b.side ),
						Speed
					)
				);
			return i;
		});

		// Process move
		for( oEvent in aEvent ) {
			doMove( oEvent );
		}
		

		// TODO : pay cost

		return new TurnEndState( _oBattle );
		// new TriggerState(
		// 	_oBattle,
		// 	OnTurnEnd,
		// 	new AniActionState(_oBattle)
		// )
	}

	private function doMove( oEvent :MoveCalcContext ) {

		var bSide = oEvent.side;
		var oMonAtt = oEvent.mon;
		var oMove = oEvent.move;

		// TODO : pay cost

		// Case : move fail to transform
		if( oMove == null ) {
			//log(oMoveCalcContex.move_origin.getLabel() + ' has failed.');
			return;
		}

		// Process attack
		var oMonTarget :Ani = null;
		switch( oMove.getTarget() ) {
			case Self: oMonTarget = oMonAtt;
			case SingleFoe: oMonTarget = _oBattle.getCurrentMon( !bSide );
			default:
				throw '!!!';
		}

		
		//log( oMonAtt.getLabel() + ' use ' + oMove.getLabel() );

		trigger( OnMove, {
			side_att: bSide,
			turnover: false,
			move: oMove,
			defender: oMonTarget,
			attacker: oMonAtt,
		});

		
	}

}