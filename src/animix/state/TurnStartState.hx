package animix.state;

import animix.ds.Context;
import mon_calc.action.IAction;
import animix.entity.Battle;
import mon_calc.core.IState;

class TurnStartState implements IState {

	var _oContext :Context;

	var _aAction :Array<IAction>;

	public function new( oContext :Context, aAction :Array<IAction> ) {
		_oContext = oContext;
		_aAction = aAction;
	}

	public function process() {

		
		stackProcess( 
			new TriggerProcess({type: OnTurnStart}) 
		);

		if( )

		_oContext.state = new 
		return null;
	}


	public function getActionAr( bSide :Bool, aAction :Array<IAction> = null ) :IAction {

		aAction = aAction != null ? 
			aAction : generatePlayerAction( bSide );

		if( aAction.length == 0 ) throw '!!!'; 
		if( aAction.length == 1 ) 
			return aAction[0]; 

		var oAction = ( bSide ?
			aAction[ _oBlueTeamCallback( aAction ) ]:
			aAction[ _oRedTeamCallback( aAction ) ]
		);
		if( oAction == null ) throw '!!!';
		return oAction;
	}

	var _oGeneratePlayerActionTrigger :TriggerProcess = null;
	public function generatePlayerAction( bSide :Bool ) :Array<IAction> {

		if( _oGeneratePlayerActionTrigger == null ) {
			var oMon = _oBattle.getCurrentMon( bSide );

			var aAction = new Array<IAction>();
			for( i in 0...4 ) // TODO : support mon with less available move
				aAction.push( new MonMoveAction( bSide, i ) );
			aAction = aAction.filter(function( oAction ) {
				return oAction.validate( _oBattle );
			});
			
			// Case : struggle
			if( aAction.length == 0 )
				aAction.push( new MonForcedAction( bSide, oMon.getType().getDefaultMove() ) );
	
			aAction.concat( generatePlayerSwitchAction( bSide ) );
	
			var oActionPromptContext :ActionPromptContext = {
				type: OnActionPrompt,
				action: aAction,
				side: bSide,
			};
			_oGeneratePlayerActionTrigger = new TriggerProcess(oActionPromptContext);
		}
		return _oGeneratePlayerActionTrigger;
	}

	public function generatePlayerSwitchAction( bSide :Bool ) :Array<IAction> {

		var oCurrent = _oBattle.getCurrentMon( bSide );
		var oTeam = _oBattle.getTeam( bSide );
		var aAction = new Array<IAction>();
		for( i in 0...oTeam.getMonAr().length )
			if( oCurrent != oTeam.getMon( i ) )
				aAction.push( new MonSwitch( bSide, i ) );
		return aAction.filter(function( oAction ) {
			return oAction.validate( _oBattle );
		});
	}
}