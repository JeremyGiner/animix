package mon_calc.tool;

import haxe.Resource;
import mon_calc.entity.Ability;
import mon_calc.entity.Move;
import mon_calc.battle_aspect.IAspect;
import mon_calc.ability.FlagAbility;
import mon_calc.ability.AAbility;
import mon_calc.entity.EHitType;
import mon_calc.entity.MonType;
import haxe.ds.StringMap;
import haxe.Json;
using StringTools;

class MonTypeConfigLoader {

	var _mMove :StringMap<Move>;
	var _mAbility :StringMap<Ability>;

	var _mMonType :StringMap<MonType>;

	public function new( mMove :StringMap<Move>, mAbility :StringMap<Ability> ) {

		_mAbility = mAbility;
		_mMove = mMove;
	}

	public function load() {

		MonType.DEFAULT_MOVE = _mMove.get('STRUGGLE');
		if( MonType.DEFAULT_MOVE == null ) throw '!!!';

		var oMonConfig :Array<Dynamic> = Json.parse( 
			Resource.getString('config_mon')
		);
	
		var m = new StringMap<MonType>();
		for( oMonTypeConfig in oMonConfig ) {

			if( oMonTypeConfig.evolutions.length != 0 ) continue;
			//if( ! [3,6,9].contains( oMonTypeConfig.no ) ) continue;
			//if( oMonTypeConfig.no == 12 ) break;
//trace(oMonTypeConfig.name);
			m.set( StringTool.slugify( oMonTypeConfig.name ), new MonType(
				oMonTypeConfig.no,
				oMonTypeConfig.name,
				[
					Health => oMonTypeConfig.base_stats[0],
					Att => oMonTypeConfig.base_stats[1],
					Def => oMonTypeConfig.base_stats[2],
					Mag => oMonTypeConfig.base_stats[3],
					Res => oMonTypeConfig.base_stats[4],
					Speed => oMonTypeConfig.base_stats[5],
				],
				EnumTool.getHitTypeFromString( oMonTypeConfig.types[0] ),
				EnumTool.getHitTypeFromString( oMonTypeConfig.types[1] ),
				ArrayTool.unique( oMonTypeConfig.abilities ).map(function( item :String ) {
					return _resolveAbility( StringTool.slugify( item ) );
				}),
				ArrayTool.unique( 
					oMonTypeConfig.level_up_moves.map(function( item ) {
						return _resolveMove( item[1] );
					}).concat(oMonTypeConfig.egg_moves.map(function( item ) {
						return _resolveMove( item );
					})).concat(oMonTypeConfig.tms.map(function( item ) {
						return _resolveMove( item[1] );
					})).concat(oMonTypeConfig.trs.map(function( item ) {
						return _resolveMove( item[1] );
					})).filter(function(item :Dynamic ) {
						return item != null;
					})
				),
				oMonTypeConfig.evolutions.map(function( item ) {

					return StringTool.slugify( item.species.split('-')[0] );
				})
			) );
		}

		return m;
	}

	public function _resolveAbility( s :String ) {
		if( !_mAbility.exists(s) ) {
			return new Ability('NONE',[]);
			//throw 'Missing ablility "'+s+'"';
		}
		return _mAbility.get(s);
	}

	static var MOVE_IGNORE = [
		"WORRY_SEED","GROWL","ATTRACT","HELPING_HAND","FALSE_SWIPE","STOMPING_TANTRUM",
		"ENDURE", "GRASS_KNOT",
		"FLY", "DIG", "BEAT_UP", "FLING", "SKULL_BASH","DIVE",
		"HEAT_CRASH","BRINE","AVALANCHE","GYRO_BALL","BODY_PRESS",

		// TODO 
		"GUST","TWISTER","SKY UPPERCUT","BUG_BITE","ROAR","WHIRLWIND","RAGE_POWDER",
		"THIEF", "BATON_PASS","SKILL_SWAP","THROAT_CHOP","UPROAR","TAUNT",

		//TEAM
		"RETALIATE", "ROUND", "ASSIST", "HELPING_HAND", "RAGE_POWDER",

		// not competitive
		"POUND","SLAM","VISE_GRIP","HORN_ATTACK","MEGA_PUNCH","CUT","SCRATCH","TACKLE",
		"BITTER_MALICE","FAIRY_WIND","PECK","ROCK_THROW","STONE_AXE","TRIPLE_ARROWS",
		"WING_ATTACK","WATER_GUN","BRANCH_POKE","ROCK_THROW","VINE_WHIP",

		"CONFIDE","GROWL","LEER","TAIL_WHIP","FLASH","KINESIS","SAND_ATTACK","SMOKESCREEN","SWEET SCENT",
		"ABSORB","ACID","MUD-SLAP","METAL_CLAW",

		// maybe not competivite
		"PAYBACK","RAGE","ASSURANCE","FOCUS_ENERGY","REVENGE","REVERSAL",
	];


	public function _resolveMove( s :String ) {
		var sKey = StringTool.slugify( s );
		if( MOVE_IGNORE.contains(sKey)) return null;
		if( !_mMove.exists( sKey ) ) return null;
		//if( !_mMove.exists( sKey ) ) throw 'Missing "'+sKey+'"';
		return _mMove.get( sKey );
	}
}