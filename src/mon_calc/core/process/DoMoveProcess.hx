package mon_calc.core.process;

import mon_calc.action.MonMoveAction;
import mon_calc.ds.ThisContext;

class DoMoveProcess implements IProcess {
	
	var _oAction :MonMoveAction;

	public function new( oAction :MonMoveAction ) {
		_oAction = oAction;
	}

	public function getLabel() :String {return 'DoMoveProcess';}
	public function process( oContext :ThisContext ) :IProcessResult {
		var bSide = _oAction.getSide();
		var oMonAtt = oContext.battle.getCurrentMon( bSide );
		var oMove = _oAction.getMove( _oBattle );

		// Decrease PP
		oMonAtt.decreasePP( oMove, 1 );

		// Get effective move
		var oMoveCalcContex :MoveCalcContext = {
			type: OnMoveCalc,
			side: bSide,
			mon: oMonAtt,
			move_origin: oMove,
			move: oMove,
		};
		oContext.processor.trigger(
			oMoveCalcContex, 
			oMove.getAspectByEvent(  {
				processor: this, 
				battle: _oBattle, 
				side: bSide, mon: oMonAtt, event: oMoveCalcContex, 
				owner: oMove,
			} ) 
		);
		oMove = oMoveCalcContex.move;

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

		var oContextEvent :MoveContext = {
			type: OnAttack,
			side_att: bSide,
			mon_att: oMonAtt,
			stat_att: getCurrentMonStat( oMonAtt ),
			mon_def: oMonTarget,
			stat_def: getCurrentMonStat( oMonTarget ),
			move: oMove,
			turnover: false,
		};
		oContext.processor.trigger( 
			oContextEvent,
			oMoveCalcContex.move.getAspectByEvent(  {
				processor: this, 
				battle: _oBattle, 
				side: bSide, mon: oMonAtt, 
				event: oContextEvent, 
				owner: oMoveCalcContex.move,
			} ) 
		);
		return null;
	}
}