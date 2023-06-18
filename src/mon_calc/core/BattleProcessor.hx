package mon_calc.core;


// import mon_calc.core.process.TriggerProcess;
// import mon_calc.core.process.MonActionProcess;
// import mon_calc.core.process.SwitchMonProcess;
// import mon_calc.core.process.DoMoveProcess;
import mon_calc.action.MonForcedAction;
import mon_calc.exception.VictoryException;
import stdlib.Unserializer;
import haxe.Serializer;
import mon_calc.ds.event.SwitchOutContext;
import mon_calc.ds.event.SwitchInContext;
import mon_calc.ds.event.AffinityContext;
import mon_calc.ds.event.MoveCalcContext;
import mon_calc.system.BattleProcess;
import mon_calc.aspect.IStackable;
import mon_calc.entity.EHitType;
import mon_calc.ds.event.StatCalcContext;
import mon_calc.ds.event.DamageCalcContext;
import mon_calc.ds.event.ActionPromptContext;
import mon_calc.ds.event.AspectEntryContext;
import mon_calc.entity.Move;
import mon_calc.entity.Mon;
import mon_calc.entity.EStat;
import mon_calc.entity.Team;
import mon_calc.entity.Battle;
import mon_calc.aspect.core.IAspectBearer;
import mon_calc.ds.event.EventContext;
import mon_calc.ds.PairAspectContext;
import mon_calc.ds.ThisContext;
import mon_calc.ds.AspectExecuteContext;
import mon_calc.ds.MonDamageContext;
import mon_calc.action.MonMoveAction;
import mon_calc.action.MonSwitch;
import mon_calc.action.IAction;
import mon_calc.battle_aspect.IAspect;
import mon_calc.ds.MoveContext;

class BattleProcessor {

	var _oBattle :Battle;

	var _oRandCallback :BattleProcessor->Float->Bool;
	var _oRedTeamCallback :Array<IAction>->Int;
	var _oBlueTeamCallback :Array<IAction>->Int;

	var _aLog :Array<String>;
	var _oCurrentActionRed :IAction;
	var _oCurrentActionBlue :IAction;


//_____________________________________________________________________________
// Constructor

	public function new( 
		oBattle :Battle,
		oRandCallback :BattleProcessor->Float->Bool,
		oRedTeamCallback :Array<IAction>->Int,
		oBlueTeamCallback :Array<IAction>->Int
	) {
		_oBattle = oBattle;

		_oRandCallback = oRandCallback;
		_oRedTeamCallback = oRedTeamCallback;
		_oBlueTeamCallback = oBlueTeamCallback;

		_aLog = [];

		_oCurrentActionRed = null;
		_oCurrentActionBlue = null;

		
	}

//_____________________________________________________________________________
// Accessor

	public function getLog() {
		return _aLog;
	}

	public function getMonSide( oMon :Mon ) {
		if( _oBattle.getCurrentMon( true ) == oMon ) return true;
		if( _oBattle.getCurrentMon( false ) == oMon ) return false;
		throw '!!';
	}

	public function getCurrentMonStat( oMon :Mon ) :Map<EStat,Int> {

		var oEventContext :StatCalcContext = {
			type: OnStatCalc,
			side: getMonSide( oMon ),
			mon: oMon,
			stat: oMon.getStatEffectiveMap(),
		};

		_trigger(oEventContext);

		return oEventContext.stat;
	}

	public function getChance( fChance :Float ) {
		if( fChance >= 1.0 ) {
			log('Guarantee chance '+(fChance*100));
			return true;
		}
		return _oRandCallback( this, fChance );
	}
	public function getChanceAr<C>( aChance :Array<C> ) :C {
		var a = aChance.copy();
		while( a.length != 1 ) {
			if( getChance( 1 / a.length ) ) 
				return a[0];
			a.shift();
		}
		return a[0];
	}

	public function generatePlayerAction( bSide :Bool ) :Array<IAction> {

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
		_trigger(oActionPromptContext);
			
		return oActionPromptContext.action;
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

	public function isDone() {
		return getVictor() != null;
	}

	public function getVictor() :Null<Bool> {
		var bRed = _oBattle.getTeamRed().hasValidMon();
		var bBlue = _oBattle.getTeamBlue().hasValidMon();
		if( ! bRed && ! bBlue ) throw 'Draw, shoult not happen';
		if( ! bRed  ) return true; // Blue win
		if( ! bBlue ) return false; // Red win
		// Case : Nobody won yet
		return null;
	}

//_____________________________________________________________________________
// Modifier

	public function log( s :String ) {
		//trace( s );
		_aLog.push( s );
		return this;
	}

//_____________________________________________________________________________
// Process

	public function removeAspect( oOwner :IAspectBearer, oAspect :IAspect, oSoure :IAspect ) {
		oOwner.removeAspect( oAspect );
		this.log( 'removing ' + Type.getClassName(Type.getClass( oAspect )) );
	}

	public function addAspect( oTarget :IAspectBearer, oAspect :IAspect, oSourceMon :Mon, oSource :IAspect) {
		
		var bIsStackacle = Std.isOfType( oAspect, IStackable );
		var oPrev = oTarget.getAspectByClass( oAspect.getMainClass() );

		// Case : 2 aspect unstackable
		if( !bIsStackacle && oPrev != null ) return;

		var oContext :AspectEntryContext = {
			type: OnAspectEntryPre,
			source_mon: oSourceMon,
			source: oSource,
			target: oTarget,
			aspect: oAspect,
			prevent_default: false,
		};
		_trigger(oContext);

		if( oContext.prevent_default ) return;

		if( bIsStackacle && oPrev != null )
			cast( oPrev, IStackable ).addStack( this, oTarget, cast oAspect );
		else
			oTarget.addAspect( oAspect );

		this.log( 'adding ' + Type.getClassName(Type.getClass( oAspect )) );

		oContext.type = OnAspectEntryPost;
		_trigger(oContext);
	}

	// public function process2( ) {

	// 	var oActionProcess :MonActionProcess;
	// 	return oActionProcess.process({
	// 		processor: this, 
	// 		battle: _oBattle, 
	// 		side: null, 
	// 		mon: null, 
	// 		event: null, 
	// 		owner: _oBattle,
	// 		input: null
	// 	});





	// 	var oPair = _oBattle.popProcess();

	// 	var oAspect = oPair.aspect;
	// 	var oThisContext = oPair.context;

	// 	// TODO : preprocess ?

	// 	var oContext :AspectExecuteContext = {
	// 		type: OnAspectExecutePre,
	// 		owner_side: oThisContext.side,
	// 		owner: oThisContext.mon,
	// 		aspect: oAspect,
	// 		event: oThisContext.event,
	// 	};
	// 	trigger(oContext);
	
	// 	log( oAspect.getLabel() + ' execute' );
	// 	var res = oAspect.process( oThisContext );

	// 	// Repile process if input needed
	// 	if( res != null )
	// 		_oBattle.stackProcess( oPair );

	// 	return res;
		

	// 	// TODO : copy battle msut copy process stack

	// 	// TODO : check victory
	// }


	public function process() {

		while( ! isDone() ) {
			log('Turn start');
			_oCurrentActionRed = promptAction( false );
			_oCurrentActionBlue = promptAction( true );
			try{
				processTurn();
			} catch( e :VictoryException ) {
				break;
			}
			if( isDone() ) throw '!!!';
			
		}
		var b = getVictor();
		if( b == null ) throw '!!!';
	}

	public function promptAction( bSide :Bool, aAction :Array<IAction> = null ) :IAction {

		aAction = aAction != null ? 
			aAction : generatePlayerAction( bSide );

		if( aAction.length == 0 ) throw '!!!'; 
		if( aAction.length == 1 ) return aAction[0]; 

		var oAction = ( bSide ?
			aAction[ _oBlueTeamCallback( aAction ) ]:
			aAction[ _oRedTeamCallback( aAction ) ]
		);
		if( oAction == null ) throw '!!!';
		return oAction;
	}

	private function processTurn() {

		if( _oCurrentActionRed == null ) throw '!!!';
		if( _oCurrentActionBlue == null ) throw '!!!';

		_trigger({type: OnTurnStart});


		if( Std.isOfType( _oCurrentActionRed, MonSwitch ) ) {
			var oSwtichAction = cast( _oCurrentActionRed, MonSwitch);
			switchMon( false, oSwtichAction.getMonIndex() );
		}
		if( Std.isOfType( _oCurrentActionBlue, MonSwitch ) ) {
			var oSwtichAction = cast( _oCurrentActionBlue, MonSwitch);
			switchMon( false, oSwtichAction.getMonIndex() );
		}

		
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
					getCurrentMonStat( _oBattle.getCurrentMon( a.getSide() ) ).get(Speed),
					getCurrentMonStat( _oBattle.getCurrentMon( b.getSide() ) ).get(Speed)
				);
			return i;
		});

		// Process move
		for( oAction in aMoveAction ) {
			doMove( oAction );
		}

		_trigger({type: OnTurnEnd});

		_oCurrentActionBlue = null;
		_oCurrentActionRed = null;
		log('Turn end');
	}

	public function doMove( oAction :MonMoveAction ) {

		var bSide = oAction.getSide();
		var oMonAtt = _oBattle.getCurrentMon( bSide );
		var oMove = oAction.getMove( _oBattle );

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
		_trigger(
			oMoveCalcContex, 
			oMove.getAspectByEvent(  {
				processor: this, battle: _oBattle, 
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
		log( oMonAtt.getLabel() + ' use ' + oMove.getLabel() );


		_trigger( 
			oContext,
			oMoveCalcContex.move.getAspectByEvent(  {
				processor: this, battle: _oBattle, 
				side: bSide, mon: oMonAtt, event: oContext, 
				owner: oMoveCalcContex.move,
			} ) 
		);

		
	}

	public function calcDamage( oContext :DamageCalcContext ) {
		_trigger(oContext);
		return oContext;
	}

	public function getAffinityFactor( oMon :Mon, eType :EHitType ) :Float {

		var oContext :AffinityContext = {
			target: oMon,
			type: OnAffinityCalc,
			att_type: eType,
			def_type_ar: [oMon.getHitType0(),oMon.getHitType1()],
			factor: BattleProcess.getHitTypeFactor( 
				eType, 
				oMon.getHitType0(), 
				oMon.getHitType1()
			)
		};
		_trigger( oContext );

		return oContext.factor;
	}

	public function damage2( 
		oTarget :Mon,
		iDamage :Int,
		oSourceMon :Mon, 
		oSource :IAspect, 
		oParentContext :MoveContext = null 
	) {
		damage({
			type: OnDamagePre,
			attack_context: oParentContext,
			mon_att: oSourceMon,
			source: oSource,
			target: oTarget,
			damage: iDamage,
			prevent_default: false,
		});
	}
	public function damage( oContext :MonDamageContext ) {

		_trigger( oContext );

		if( oContext.damage == 0 ) {
			log('attack has no effect');
			return;
		}
		if( oContext.prevent_default ) {
			log('attack miss');
			return;
		}

		oContext.target.damage( oContext.damage );

		log( ' damaging ' + oContext.target.getLabel() + ' ' 
			+ oContext.target.getHealth() 
			+ ' (-' + oContext.damage + ')' 
		);

		if( isDone() ) {
			log('TODO : END' + (getVictor() ? 'Blue' : 'Red') + ' WIN' );
			throw new VictoryException();
		}

		// Case : Faint
		if( oContext.target.getHealth() <= 0 ) {
			log( oContext.target.getLabel() + ' is dead' );
			var bSide = getMonSide( oContext.target );
			var oAction :MonSwitch = cast promptAction(
				bSide, 
				generatePlayerSwitchAction( bSide )
			);
			switchMon( bSide, oAction.getMonIndex() );
		}
	}

	public function heal( oContext :MonDamageContext ) {
		_trigger(oContext);

		if( oContext.prevent_default ) return;
		oContext.target.heal( oContext.damage );
		log( ' healing ' + oContext.target.getLabel() + ' for ' + oContext.damage );

		oContext.type = OnHealPost;
		_trigger(oContext);
	}

	public function heal2( 
		oTarget :Mon,
		iHeal :Int,
		oSourceMon :Mon, 
		oSource :IAspect, 
		oParentContext :MoveContext = null 
	) {
		damage({
			type: OnHealPre,
			attack_context: oParentContext,
			mon_att: oSourceMon,
			source: oSource,
			target: oTarget,
			damage: iHeal,
			prevent_default: false,
		});
	}

	// public function trigger( 
	// 	oContext :EventContext, 
	// 	aAdditional :Array<PairAspectContext> = null
	// ) :EventContext {
	// 	log('Event - '+oContext.type);
	// 	var aPairAspect = getAllAspectByEvent(oContext)
	// 		.concat( aAdditional != null ? aAdditional : [] );
	// 	aPairAspect.sort(function( a :PairAspectContext, b :PairAspectContext ) {
	// 		return Reflect.compare( b.aspect.getPriority() , a.aspect.getPriority() );
	// 	});
	// 	for( pair in aPairAspect )
	// 		_oBattle.stackProcess( pair );
	// 	return oContext;
	// }

	public function _trigger( 
		oContext :EventContext, 
		aAdditional :Array<PairAspectContext> = null
	) :EventContext {
		log('Event - '+oContext.type);
		var aPairAspect = getAllAspectByEvent(oContext)
			.concat( aAdditional != null ? aAdditional : [] );
		aPairAspect.sort(function( a :PairAspectContext, b :PairAspectContext ) {
			return Reflect.compare( untyped a.aspect.getPriority() , untyped b.aspect.getPriority() );
		});

		var bHasTurnOver = Reflect.hasField(oContext,'turnover');

		while( aPairAspect.length != 0 ) {
			var oPair = aPairAspect.shift();

			var oAspect = oPair.aspect;
			var oThisContext = oPair.context;

			var oContext :AspectExecuteContext = {
				type: OnAspectExecutePre,
				owner_side: oThisContext.side,
				owner: oThisContext.mon,
				aspect: oAspect,
				event: oThisContext.event,
				prevent_default: false,
			};
	
			_trigger(oContext);
	
			if( oContext.prevent_default ) continue;
	
			// DO ACTION
			log( oAspect.getLabel() + ' execute' );
			oAspect.process( oThisContext );
			
			oContext.type = OnAspectExecutePost;
			_trigger(oContext);

			if( bHasTurnOver && untyped oContext.turnover == true ) 
				return oContext;
		}
		return oContext;
	}

	// public function trigger( 
	// 	oContext :EventContext, 
	// 	aAdditional :Array<PairAspectContext> = null,
	// 	b :Bool =true
	// ) :EventContext {
	// 	log('Event - '+oContext.type);
	// 	var aPairAspect = getAllAspectByEvent(oContext)
	// 		.concat( aAdditional != null ? aAdditional : [] );
	// 	aPairAspect.sort(function( a :PairAspectContext, b :PairAspectContext ) {
	// 		return Reflect.compare( untyped a.aspect.getPriority() , untyped b.aspect.getPriority() );
	// 	});

	// 	var bHasTurnOver = Reflect.hasField(oContext,'turnover');

	// 	while( aPairAspect.length != 0 ) {
	// 		var oPair = aPairAspect.shift();

	// 		var oAspect = oPair.aspect;
	// 		var oThisContext = oPair.context;

	// 		var oContext :AspectExecuteContext = {
	// 			type: OnAspectExecutePre,
	// 			owner_side: oThisContext.side,
	// 			owner: oThisContext.mon,
	// 			aspect: oAspect,
	// 			event: oThisContext.event,
	// 			prevent_default: false,
	// 		};
	
	// 		trigger(oContext,null,false);
	
	// 		if( oContext.prevent_default ) continue;
	
	// 		// DO ACTION
	// 		log( oAspect.getLabel() + ' execute' );
	// 		oAspect.process( oThisContext );
			
	// 		oContext.type = OnAspectExecutePost;
	// 		trigger(oContext,null,false);

	// 		if( bHasTurnOver && untyped oContext.turnover == true ) 
	// 			return oContext;
	// 	}
	// 	return oContext;
	// }

	// public function getTriggerList( oContext :EventContext ) {
	// 	log('Event - '+oContext.type);
	// 	var aPairAspect = getAllAspectByEvent(oContext);
	// 	aPairAspect.sort(function( a :PairAspectContext, b :PairAspectContext ) {
	// 		return Reflect.compare( untyped a.aspect.getPriority() , untyped b.aspect.getPriority() );
	// 	});

	// 	return new TriggerProcess( aPairAspect );
	// }

	public function getAllAspectByEvent( oContext :EventContext ) :Array<PairAspectContext> {
		
		var oMonRed = _oBattle.getCurrentMon(false);
		var oMonBlue = _oBattle.getCurrentMon(true);
		return _oBattle.getAspectByEvent( {
				processor: this, battle: _oBattle, 
				side: null, mon: null, event: oContext, 
				owner: _oBattle,
			} )
			.concat(_oBattle.getTeam(true).getAspectByEvent( {
				processor: this, battle: _oBattle,
				side: true, mon: null, event: oContext, 
				owner: _oBattle.getTeam(true),
			} ) )
			.concat(_oBattle.getTeam(false).getAspectByEvent( {
				processor: this, battle: _oBattle,
				side: false, mon: null, event: oContext, 
				owner: _oBattle.getTeam(false),
			} ) )
			.concat(oMonRed.getAspectByEvent( {
				processor: this, battle: _oBattle,
				side: false, mon: oMonRed, event: oContext,
				owner: oMonRed, 
			} ) )
			.concat(oMonBlue.getAspectByEvent( {
				processor: this, battle: _oBattle, 
				side: true, mon: oMonBlue, event: oContext, 
				owner: oMonBlue,
			} ) )
		;
	}

	public function switchMon( bSide :Bool, iIndex :Int ) {
		var oBattle = _oBattle;
		var oTeam = oBattle.getTeam( bSide );
		var oCurrentMon = oBattle.getCurrentMon( bSide );
		var oNextMon = oTeam.getMon( iIndex );

		var oEvent :SwitchInContext = {
			type: OnSwitchIn,
			side: bSide, mon: oNextMon,
		}
		_trigger(oEvent);

		oCurrentMon.reset();
		_oBattle.getBattleSlot(bSide).switchMon( oNextMon );
		log( 
			oTeam.getLabel() 
			+ ' change to ' + oNextMon.getLabel() 
			+ ' ('+ oNextMon.getHealth()+')' );

		var oEvent :SwitchOutContext = {
			type: OnSwitchIn,
			side: bSide, mon: oNextMon,
		}
		_trigger(oEvent);
	}


}