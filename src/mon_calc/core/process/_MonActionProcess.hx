package mon_calc.core.process;

import mon_calc.ds.event.ActionPromptContext;
import mon_calc.entity.Battle;
import mon_calc.action.MonForcedAction;
import mon_calc.action.MonSwitch;
import mon_calc.action.MonMoveAction;
import mon_calc.action.IAction;
import mon_calc.ds.ThisContext;

class MonActionProcess implements IProcess {

	var _oBattle :Battle;

	var _aRedActionAr :Array<IAction> = null;
	var _aBlueActionAr :Array<IAction> = null;
	var _iRedActionPick :Null<Int> = null;
	var _iBlueActionPick :Null<Int> = null;


	public function new( oBattle :Battle ) {
		_oBattle = oBattle;

		_aRedActionAr = null;
		_aBlueActionAr = null;
		_iRedActionPick = null;
		_iBlueActionPick = null;

		// Init red choices
		_aRedActionAr = generatePlayerAction(false);
		_aBlueActionAr = generatePlayerAction(true);
	}

	public function setRedAction( i :Int ) {
		_iRedActionPick = i;
	}
	public function setBlueAction( i :Int ) {
		_iRedActionPick = i;
	}

	public function getRedActionAr() { return _aRedActionAr; }
	public function getBlueActionAr() { return _aBlueActionAr; }

	public function process( oContext :ThisContext ):IProcessResult {

		if( 
			(
				_iRedActionPick == null 
				&& _aRedActionAr.length > 1
			) || (
				_iBlueActionPick == null
				&& _aBlueActionAr.length > 1
			)
		) {
			throw '!!!';
		}

		var oCurrentActionRed = _aRedActionAr[ _iRedActionPick ];
		var oCurrentActionBlue = _aBlueActionAr[ _iBlueActionPick ];

		oContext.battle.stackProcess( 
			new TriggerProcess({type: OnTurnStart}) 
		);

		if( Std.isOfType( oCurrentActionRed, MonSwitch ) ) {
			var oSwtichAction = cast( oCurrentActionRed, MonSwitch);
			oContext.battle.stackProcess( new SwitchMonProcess(
				false, oSwtichAction.getMonIndex()
			));
		}
		if( Std.isOfType( oCurrentActionBlue, MonSwitch ) ) {
			var oSwtichAction = cast( oCurrentActionBlue, MonSwitch);
			oContext.battle.stackProcess( new SwitchMonProcess(
				true, oSwtichAction.getMonIndex()
			));
		}

		// TODO :sort Switch action
		var aMoveAction = new Array<MonMoveAction>();
		if( Std.isOfType( _oCurrentActionRed, MonMoveAction ) ) {
			aMoveAction.push( cast _oCurrentActionRed );
		}
		if( Std.isOfType( _oCurrentActionBlue, MonMoveAction ) ) {
			aMoveAction.push( cast _oCurrentActionBlue );
		}

		// Sort by priority
		// TODO : trigger move priority
		aMoveAction.sort(function(a :MonMoveAction, b :MonMoveAction) {
			var i = Reflect.compare( 
				b.getMove(_oBattle).getPriority(),
				a.getMove(_oBattle).getPriority() 
			);
			if( i == 0 )
				return -Reflect.compare( 
					getCurrentMonStat( 
						_oBattle.getCurrentMon( a.getSide() ) 
					).get(Speed),
					getCurrentMonStat( 
						_oBattle.getCurrentMon( b.getSide() ) 
					).get(Speed)
				);
			return i;
		});

		for( oAction in aMoveAction ) {
			oContext.battle.stackProcess( new DoMoveProcess(oAction) );
		}
		
		oContext.battle.stackProcess(
			new TriggerProcess({type: OnTurnEnd})
		);
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