package mon_calc;

import mon_calc.tool.BattleTool;
import mon_calc.entity.EHitType;
import mon_calc.system.BattleProcess;
import mon_calc.action.IAction;
import mon_calc.entity.Battle;
import mon_calc.entity.Ability;
import mon_calc.entity.MonType;
import mon_calc.battle_aspect.IAspect;
import mon_calc.entity.Item;
import haxe.ds.StringMap;
import mon_calc.entity.Team;
import mon_calc.core.BattleProcessor;
import mon_calc.loader.ItemConfigLoader;
import mon_calc.loader.AbilityConfigLoader;
import mon_calc.entity.Move;
import mon_calc.tool.MonTypeConfigLoader;
import mon_calc.entity.Mon;
import mon_calc.tool.MoveConfigLoader;
import mon_calc.tool.MonTypeConfigLoader;
import mon_calc.ds.Nature;



/**
 * ...
 * @author 
 */
class Main {
	
	var _mItem :StringMap<Item>;
	var _mAbility :StringMap<Ability>;
	var _mMove :StringMap<Move>;
	var _mMonType :StringMap<MonType>;

	static var _oInstance :Main;
	
//_____________________________________________________________________________
// Boot

	static public function main() {
		_oInstance = new Main();

		// TODO : add list of contact moves
	}
	
//_____________________________________________________________________________
// Constructor

	public function new() {
		_mItem = new ItemConfigLoader().load();
		_mAbility = new AbilityConfigLoader().load();
		_mMove = new MoveConfigLoader().load();
		_mMonType = (new MonTypeConfigLoader(_mMove, _mAbility)).load();


		combat();
		trace('END');
		//genMon();
		


		

		// new Battle();

		// var oBattle = new Battle(
		// 	new Team('Red',[
		// 		new Mon(
		// 			mMonType.get('VENUSAUR'),[],null,null,Nature(Att,Mag),[
		// 				mMove.get('ABSORB'),
		// 				mMove.get('GROWTH'),
		// 				mMove.get('PETAL_BLIZZARD'),
		// 				mMove.get('PETAL_DANCE'),
		// 			]
		// 		),
		// 	]),
		// 	new Team('Blue',[
		// 		new Mon(
		// 			mMonType.get('VENUSAUR'),[],null,null,Nature(Mag,Att),[
		// 				mMove.get('ABSORB'),
		// 				mMove.get('GROWTH'),
		// 				mMove.get('PETAL_BLIZZARD'),
		// 				mMove.get('PETAL_DANCE'),
		// 			]
		// 		),
		// 	]),
		// 	function processInput( oBattle :Battle, fChance :Float ) {
		// 		return Math.random() > fChance;
		// 	}
		// );
	}
	
//_____________________________________________________________________________
// Singleton
	
	static public function get() { return _oInstance; }

//_____________________________________________________________________________
// Accessor

	
//_____________________________________________________________________________
// Process

	public function nemesys() {

		// Group by type
		var mMonTypeByHitType = new StringMap<Array<MonType>>();
		for( oMonType in _mMonType ) {
			// TODO : skip pre-evol
			// TODO : regroup by stat, count type
			var key = cast(oMonType.getHitType1(),Int) 
				+ ':' + cast(oMonType.getHitType2(),Int);
			if( ! mMonTypeByHitType.exists(key))
				mMonTypeByHitType.set( key, [oMonType] );
			else 
				mMonTypeByHitType.get( key ).push( oMonType );
		}


		for( k => aMonType in mMonTypeByHitType ) {
			trace(  k + ' : ' + aMonType.length );
		}

	}

	public function combat() {
		
		var lStack = new List<BattleProcessor>();

		// Need :
		// Duplicate state on action prompt
		// BProc must advance state until next prompt

		var oBattle = new Battle(
			new Team('RED',[
				new Mon('Red CHARIZARD',_mMonType.get('CHARIZARD'),[Mag=>250],0,Nature.get( 1 ),[
					_mMove.get('AIR_SLASH'),
					_mMove.get('SWORDS_DANCE'),
					_mMove.get('EARTHQUAKE'),
					_mMove.get('OUTRAGE'),
				],null),
				// new Mon('Red VENUSAUR',_mMonType.get('VENUSAUR'),[],0,Nature.get( 2 ),[
				// 	_mMove.get('LEECH_SEED'),
				// 	_mMove.get('SLEEP_POWDER'),
				// 	_mMove.get('SYNTHESIS'),
				// 	_mMove.get('SUBSTITUTE'),
				// ],null),
				// new Mon('Red BLASTOISE',_mMonType.get('BLASTOISE'),[],0,Nature.get( 2 ),[
				// 	_mMove.get('RAPID_SPIN'),
				// 	_mMove.get('PROTECT'),
				// 	_mMove.get('HYDRO_PUMP'),
				// 	_mMove.get('ICE_BEAM'),
				// ],null),
			]), 
			new Team('BLUE',[
				new Mon('Blue CHARIZARD',_mMonType.get('CHARIZARD'),[Att=>250],0,Nature.get( 1 ),[
					_mMove.get('AIR_SLASH'),
					_mMove.get('SWORDS_DANCE'),
					_mMove.get('EARTHQUAKE'),
					_mMove.get('OUTRAGE'),
				],null),
				// new Mon('Blue VENUSAUR',_mMonType.get('VENUSAUR'),[],0,Nature.get( 2 ),[
				// 	_mMove.get('LEECH_SEED'),
				// 	_mMove.get('SLEEP_POWDER'),
				// 	_mMove.get('SYNTHESIS'),
				// 	_mMove.get('SUBSTITUTE'),
				// ],null),
				// new Mon('Blue BLASTOISE',_mMonType.get('BLASTOISE'),[],0,Nature.get( 2 ),[
				// 	_mMove.get('RAPID_SPIN'),
				// 	_mMove.get('PROTECT'),
				// 	_mMove.get('HYDRO_PUMP'),
				// 	_mMove.get('ICE_BEAM'),
				// ],null),
				// new Mon('Blue CHARIZARD',_mMonType.get('CHARIZARD'),[Att=>250],0,Nature.get( 1 ),[
				// 	_mMove.get('AIR_SLASH'),
				// 	_mMove.get('SWORDS_DANCE'),
				// 	_mMove.get('EARTHQUAKE'),
				// 	_mMove.get('OUTRAGE'),
				// ],null),
			])
		);

		// var o = new CmdClient( oBattle );
		// o.process();
		// return;
		BattleTool.getVictoryRate( oBattle );
		return;

		// TODO : generate Mon nemesys :
		// - stats : min / avr (TODO : check speed curve) / max; sweeper (att/mag/speed), staller (hp/def/res)
		// - type: def type adv / atta type adv

		var oProcessor = new BattleProcessor( 
			oBattle,
			(processor, f) -> {
				return Math.random() < f;
			},
			(aAction :Array<IAction>) -> {
				return Math.floor( Math.random() * aAction.length );
			},
			(aAction :Array<IAction>) -> {
				return Math.floor( Math.random() * aAction.length );
			}
		);
		oProcessor.process();
		trace( oProcessor.getLog().join("\r\n") );
	}

	public function genMon() {
		var i = 0;
		var a = [0, 126, 252, 6];

		//var orm = new Orm(new Db('mysql://website:pass@localhost/mon_battle'));

		trace('Generating...');

		for ( oMonType in _mMonType ) {
			if( ! [3,6,9].contains( oMonType.getId() ) ) continue;
			if( oMonType.getEvolutionAr().length != 0 ) continue;
		
		
			for (iNature in 0...3) 
			for (iAbility in 0...oMonType.getAbilityAr().length) 
			for (aMoveSet in genMoveSet( oMonType.getMoveSet() )) 
			for (oItem in _mItem) 
			for (hp in a)
			for (att in a)
			for (def in a)
			for (mag in a)
			for (res in a)
			for (spe in a) 
			{

				var total = hp + att + def + mag + res + spe;
				if (total != 510)
					continue;
				if( att != 0 && mag != 0 ) continue;
				i++;

				var o = new Mon(
					'TEST',
					oMonType,
					[Health=>hp,Att=>att,Def=>def,Mag=>mag,Res=>res,Speed=>spe],
					iAbility,
					Nature.get( iNature ),
					aMoveSet,
					oItem
				);

				//var oModelMon = orm.modelMon.getByMon( o );

			}

			trace( oMonType.getLabel() );
			trace( i );
		}
		trace( i );
	}

	public function genMoveSet( aMoveSet :Array<Move> ) {
		var aPerm = new Array<Array<Move>>();
		for( i in 0...aMoveSet.length )
		for( j in 0...aMoveSet.length ) 
		for( k in 0...aMoveSet.length ) 
		for( l in 0...aMoveSet.length ) 
		{
			if( i >= j || j >= k || k >= l ) continue;
			//trace([aMoveSet[i].getLabel(),aMoveSet[j].getLabel(),aMoveSet[k].getLabel(),aMoveSet[l].getLabel()]);
			aPerm.push([
				aMoveSet[i],
				aMoveSet[j],
				aMoveSet[k],
				aMoveSet[l],
			]);
		}
		return aPerm;
	}

	public static function cloneDeep( o :Dynamic ) {
		
	}

	// static public function generateRandAction( oForm :RandForm ) :Array<Node> {
	// 	var aAction = [];
	// 	for( i in 0...oForm.length )
	// 		aAction.push( new RandAction( i ) );
		
	// 	return aAction;
	// }

}

		
// class BattleProcessor {


// 	public function process( oBattle :Battle ) {
		
// 		var oRoot = new ActionNode( null, oBattle );
		
		
// 		var lNodeStack = new List<ActionNode>();
// 		lNodeStack.push( oRoot );
// 		var bSide = false;
// 		while( !lNodeStack.isEmpty() ) {
// 			var oNode = lNodeStack.pop();
// 			var oBattle = oNode.getBattle();
			
// 			if( oBattle.isDone() ) continue;
			
// 			if( oBattle.getNextActionType() == 'PLAYER' ) {
// 				aAction = generatePlayerAction( oBattle, bSide );
// 				bSide = !bSide;
// 			}
			
// 			if( Std.is( oBattle.getNextActionType(), RandForm ) ) {
			
// 				// TODO : get odds
// 				aAction = generateRandAction( oBattle.getNextActionType() );
// 			}
			
// 			for( oAction in aAction ) {
// 				var oBattleChild = oBattle.clone();
// 				oAction.process( oBattleChild );
// 				var oChildNode = new ActionNode( oAction, oBattleChild );
// 				oNode.addChild( oChildNode );
// 				lNodeStack.add( oChildNode );
// 			}
			
// 			oNode.clearBattle(); // Memory optim
// 		}
		
// 		return oRoot;
// 	}
	
// 	// static public function generatePlayerAction( 
// 	// 	oBattle :Battle, bSide :Bool 
// 	// ) :Array<Node> {
// 	// 	var aAction = [];
// 	// 	for( i in 0...4 )
// 	// 		aAction.push( new MonDoMove( bSide, i ) );
// 	// 	for( i in 1...3 )
// 	// 		aAction.push( new MonSwitch( bSide, i ) );
			
// 	// 	return aAction.filter(function( oAction ) {
// 	// 		return oAction.validate( oBattle );
// 	// 	});
// 	// }
	
	
// }

// class ActionNode {

// 	var _oAction :IAction;
// 	var _oBattle :Battle; // Resulting battle
	
// 	var _aChild :Array<ActionNode>;

// 	public function new( oAction :IAction, oBattle :Battle ) {
// 		_oAction = oAction;
// 		_oBattle = oBattle;
		
// 		_aChild = [];
// 	}
	
// 	public function getBattle() { return _oBattle; }
	
// 	public function getVictoryRatio() :Null<Array<Float>> { 
// 		return _oBattle.getVictoryRatio(); 
// 	}
	
// 	public function clearBattle() { 
// 		_oBattle = null;
// 		return this; 
// 	}
// 	public function addChild( oNode :ActionNode ) {
// 		_aChild.push( oNode );
// 		return this;
// 	}
	
// 	public function __toString() {
// 		if( _oBattle != null && _oBattle.isDone() ) 
// 			return '"' + _oAction.__toString() + '" : "'
// 				+(_oBattle.getVictory() ? 'B' : 'R' )+'"';
// 		return '"' + _oAction.__toString() + '" : {' + _aChild.map() + '}';
// 	}
// }




/**


Generate Mon combination
ev-128*4+4,pvp-item,nature,type with no evolution
-filter light clay if no clay move
-filter repeated move if no skill link
-filter poison orb todo check ability synergy


Generate Team combination
1-2-3 same as 1-3-2 bu different from 2-1-3

Explore Battle action combination
- limit switch action twice in a row

? eliminate team with garanted lose

**/