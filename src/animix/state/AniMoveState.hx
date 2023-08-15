package animix.state;

import animix.core.aspect.OnMove;
import mon_calc.ds.event.MoveCalcContext;
import animix.state.TurnEndState;
import animix.entity.Ani;
import animix.action.AniSwitchAction;
import animix.ds.Context;
import mon_calc.action.IAction;
import mon_calc.core.IState;

class AniMoveState extends BaseState {

	var _oActionRed :IAction;
	var _oActionBlue :IAction;

	public function new( 
		oContext :Context,  
		oActionRed : IAction, 
		oActionBlue :IAction
	) {
		super(oContext);
		_oActionRed = oActionRed;
		_oActionBlue = oActionBlue;
	}

	public function process() {

		var oBattle = _oContext.battle;
		var aEvent :Array<MoveCalcContext> = [];
		if( Std.isOfType( _oActionRed, AniMoveAction ) ) {
			var oMove = _oActionRed.getMove(_oContext.battle);
			aEvent.push({
				type: OnMoveCalc,
				side: false,
				mon: oBattle.getCurrentMon(false),
				move_origin: oMove,
				move: oMove,
			} );
		}
		if( Std.isOfType( _oActionBlue, AniMoveAction ) ) {
			var oMove = _oActionBlue.getMove(_oContext.battle);
			aEvent.push({
				type: OnMoveCalc,
				side: true,
				mon: oBattle.getCurrentMon(true),
				move_origin: oMove,
				move: oMove,
			} );
		}


		// Transform moves
		for( oEvent in aEvent ) {
			trigger( OnMove, oEvent );
		}

		// _oContext.state = new TriggerState(
		// 	_oContext,
		// 	OnQuickAttack,
		// 	new TriggerState(
		// 		_oContext,
		// 		OnAttack,
		// 		new TriggerState(
		// 			_oContext,
		// 			OnAttackSlow,
		// 			new TriggerState(
		// 				_oContext,
		// 				OnTurnEnd,
		// 				new AniActionState(_oContext)
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
					getCurrentMonStat( _oBattle.getCurrentMon( a.getSide() ) ).get(Speed),
					getCurrentMonStat( _oBattle.getCurrentMon( b.getSide() ) ).get(Speed)
				);
			return i;
		});

		// Process move
		for( oEvent in aEvent ) {
			doMove( oEvent.move );
		}
		

		// TODO : pay cost

		_oContext.process = new TurnEndState( _oContext );
		// new TriggerState(
		// 	_oContext,
		// 	OnTurnEnd,
		// 	new AniActionState(_oContext)
		// )
	}

	private function doMove( oEvent :MoveCalcContext ) {

		var bSide = oEvent.side;
		var oMonAtt = oEvent.mon;
		var oMove = oEvent.move;

		// TODO : pay cost

		// Case : move fail to transform
		if( oMove == null ) {
			log(oMoveCalcContex.move_origin.getLabel() + ' has failed.');
			return;
		}

		// Process attack
		var oMonTarget :Mon = null;
		switch( oMove.getTarget() ) {
			case Self: oMonTarget = oMonAtt;
			case SingleFoe: oMonTarget = _oBattle.getCurrentMon( !bSide );
			default:
				throw '!!!';
		}

		
		log( oMonAtt.getLabel() + ' use ' + oMove.getLabel() );

		var oContext :MoveContext = {
			type: OnAttack,
			side_att: bSide,
			mon_att: oMonAtt,
			stat_att: getCurrentMonStat( oMonAtt ),
			mon_def: oMonTarget,
			stat_def: getCurrentMonStat( oMonTarget ),
			move: oMove,
			turnover: false,
		};
		trigger( 
			oContext,
			oMoveCalcContex.move.getAspectByEvent(  {
				processor: this, battle: _oBattle, 
				side: bSide, mon: oMonAtt, event: oContext, 
				owner: oMoveCalcContex.move,
			} ) 
		);

		
	}

}