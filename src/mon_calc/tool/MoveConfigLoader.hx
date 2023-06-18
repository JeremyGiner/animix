package mon_calc.tool;

import haxe.Resource;
import mon_calc.aspect.trap.Spike;
import mon_calc.aspect.trap.SpikePoison;
import mon_calc.battle_aspect.weather.SandStorm;
import mon_calc.battle_aspect.weather.Hail;
import mon_calc.effect.aspect_remover.AspectRemoverByFlag;
import mon_calc.battle_aspect.substatus.Confusion;
import mon_calc.effect.attack.Acrobatic;
import mon_calc.aspect.barrier.ReflectScreen;
import mon_calc.aspect.barrier.LightScreen;
import mon_calc.effect.AntiFreeze;
import mon_calc.aspect.endturn.Bind;
import mon_calc.effect.move_transform.SleepTalk;
import mon_calc.effect.attack.Earthquake;
import mon_calc.aspect.terrain.ElectricTerrain;
import mon_calc.aspect.terrain.GrassyTerrain;
import mon_calc.effect.attack.Round;
import mon_calc.effect.attack.Venoshock;
import mon_calc.effect.attack.MultiHit5;
import mon_calc.effect.move_transform.WeatherBall.WheaterBall;
import mon_calc.effect.move_transform.Facade;
import mon_calc.effect.aspect_applier.SimpleApplier;
import mon_calc.effect.heal.Rest;
import mon_calc.aspect.barrier.StatusBarrier;
import mon_calc.ds.enumeration.EAspectFlag;
import mon_calc.ds.ThisContext;
import mon_calc.validator.SelfSleepVali;
import mon_calc.effect.attack.Recoil;
import mon_calc.aspect.action.Recharge;
import mon_calc.battle_aspect.misc.Charge;
import mon_calc.effect.attack.Synthesis;
import mon_calc.battle_aspect.misc.Dance;
import mon_calc.aspect.stat.Tailwind;
import mon_calc.battle_aspect.substatus.LeechSeed;
import mon_calc.battle_aspect.status.Freeze;
import mon_calc.battle_aspect.substatus.Flinch;
import mon_calc.ds.MoveContext;
import mon_calc.battle_aspect.core.AspectApplier;
import mon_calc.effect.aspect_applier.SleepApplier;
import mon_calc.effect.aspect_applier.ParalyzeApplier;
import mon_calc.effect.aspect_applier.BurnApplier;
import mon_calc.effect.aspect_applier.PoisonApplier;
import mon_calc.effect.Chance;
import mon_calc.effect.attack.AlwaysCrit;
import mon_calc.effect.attack.EasyCrit;
import mon_calc.ds.EMovePriority;
import mon_calc.effect.aspect_applier.SubstituteApplier;
import mon_calc.battle_aspect.IAspect;
import mon_calc.battle_aspect.status.SleepStatus;
import mon_calc.battle_aspect.IMainStatus;
import mon_calc.effect.core.AspectConditional;
import mon_calc.effect.AccuracyCheck;
import mon_calc.effect.Damage;
import mon_calc.battle_aspect.weather.Rain;
import mon_calc.effect.StatChange;
import mon_calc.battle_aspect.weather.Sunny;
import mon_calc.entity.EStat;
import mon_calc.entity.EDamageCategory;
import mon_calc.entity.Move;
import mon_calc.entity.EHitType;
import haxe.ds.StringMap;
import haxe.Json;
import mon_calc.effect.Drain;
import mon_calc.effect.attack.TapOut;
using StringTools;

class MoveConfigLoader {

	public function new() {}

	public function load() {

		var aMoveConfig :Array<Dynamic> = cast Json.parse(
			Resource.getString('move')
		);
	
		var m = new StringMap<Move>();
		for( oMoveConfig in aMoveConfig ) {
			if( Reflect.hasField(oMoveConfig,'comment') ) continue;

			var key =  StringTool.slugify( oMoveConfig.name );
			try {
				m.set( key, build( oMoveConfig ) );
			} catch( e :Dynamic ) {
				//trace( oMoveConfig.name+ ' failed ' + e );
			}
		}
		return m;
	}

	public function build( oMoveConfig :Config_Move ) {
		var aEffect = Reflect.hasField(oMoveConfig,'Effect') ? 
			parseEffectAr( Reflect.field( oMoveConfig, 'Effect' ), cast oMoveConfig ) : [];
		var bHasAttack = false;
		for( oEffect in aEffect ) {
			if( Std.isOfType(oEffect,Damage)) {
				bHasAttack = true;
				break;
			}
		}
		if( oMoveConfig.power != null && !bHasAttack ) {
			var oCategory = EnumTool.getHitCategory( oMoveConfig.category );
			aEffect.push( new Damage( 
				oMoveConfig.power, 
				EnumTool.getHitTypeFromString( oMoveConfig.type ), 
				oCategory,
				[]
					.concat(oCategory == Physic ? [Contact] : [])
					.concat(
						Reflect.hasField(oMoveConfig,'flag') ? 
							[_getAspectFlag(untyped oMoveConfig.flag)] : []
					)
			) );
		}
		if( oMoveConfig.accuracy != null )
			aEffect.push( new AccuracyCheck(oMoveConfig.accuracy / 100) );
		return new Move( 
			StringTool.slugify( oMoveConfig.name ), oMoveConfig.name, 
			EnumTool.getHitTypeFromString( untyped oMoveConfig.type ), 
			oMoveConfig.pp, 
			Reflect.hasField(oMoveConfig,'target') ? 
				EnumTool.getTargetType( untyped oMoveConfig.target ) : SingleFoe,
			aEffect, 
			Reflect.hasField(oMoveConfig,'priority') ?
				_getMovePriority(oMoveConfig.priority) : Normal,
			Reflect.hasField(oMoveConfig,'Requirement') ?
				parseRequirement(untyped oMoveConfig.Requirement, oMoveConfig)  : null
		);
	}

	public function parseRequirement( s :String, oContext :Config_Move ) {
		switch( s ) {
			case 'SelfSleep': return new SelfSleepVali();
		}
		throw 'Invalid "'+s+'"';
	}

	public function parseEffectAr( o :Dynamic, oContext :Config_Move ) :Array<IAspect> {

		if( Std.isOfType( o, Array ) ) {
			return o.map(function( item ) { return parseEffect( item, oContext ); });
		}
		return [parseEffect( o, oContext )];
	}

	public function parseEffect( oEffectData :Dynamic, oRoot :Config_Move ) :IAspect {

		if( Reflect.hasField(oEffectData,'class') ) 
			return _parseAspectClass( oEffectData, oRoot );
		if( Reflect.hasField(oEffectData,'stat') ) 
			return _parseStatApplier( oEffectData );
		if( Reflect.hasField( oEffectData, 'status' ) ) 
			return _parseStatusApplier( oEffectData );
			
		throw 'cannot parse ' + Json.stringify( oEffectData );
	}

	private function _parseAspectClass( oEffectData :Dynamic, oRoot :Config_Move ) :IAspect {
		switch( Reflect.field( oEffectData, 'class') ) {
			case 'AspectConditional': return new AspectConditional(
				_getClass(cast Reflect.field( oEffectData, 'condition')),
				parseEffectAr( cast Reflect.field( oEffectData, 'if'), oRoot ),
				Reflect.hasField( oEffectData, 'else') ?
					parseEffectAr( cast Reflect.field( oEffectData, 'else'), oRoot ) : [],
				Normal,
				Reflect.hasField( oEffectData, 'target') ?
					EnumTool.getTargetType( cast Reflect.field( oEffectData, 'target') ) : SingleFoe
			);
			case 'TrapRemover': // TODO : remove on self too (eg leechseed)
				return new AspectRemoverByFlag(Trap,AllyTeam,BeforeDamage);
			case 'BrickBreak': return new AspectRemoverByFlag(Screen,OppoTeam,BeforeDamage);
			case 'AntiFreeze': return new AntiFreeze();
			case 'Synthesis': return new Synthesis();
			case 'RecoilHalf': return new Recoil( 1/2 );
			case 'RecoilThird': return new Recoil( 1/3 );
			case 'RecoilQuarter': return new Recoil( 1/4 );
			case 'SubstituteApplier': return new SubstituteApplier();
			case 'Rest': return new Rest();
			case 'Bind': return new AspectApplier(function( oContext :ThisContext, oEvent :MoveContext ) {
				return new Bind(oEvent.mon_att,oContext.processor.getChanceAr([4,5]));
			},AllyTeam);
			case 'TapOut': return new TapOut();
			case 'EasyCrit': return new EasyCrit();
			case 'AlwaysCrit': return new AlwaysCrit();
			case 'Earthquake': return new Earthquake();
			case 'SleepTalk': return new SleepTalk();
			case 'Acrobatic': return new Acrobatic();
			case 'GrassyTerrain': return new SimpleApplier(GrassyTerrain,Battle);
			case 'ElectricTerrain': return new SimpleApplier(ElectricTerrain,Battle);
			case 'Protect': return new SimpleApplier(mon_calc.aspect.barrier.Protect,Self);
			case 'Safeguard': return new AspectApplier(function( oContext :ThisContext, oEvent :MoveContext ) {
					return new StatusBarrier();
				},AllyTeam);
			case 'LightScreen': return new SimpleApplier(LightScreen,AllyTeam);
			case 'Reflect': return new SimpleApplier(ReflectScreen,AllyTeam);
			case 'Recharge': return new AspectApplier(function( oContext :ThisContext,oEvent :MoveContext ) {
					return new Recharge();
				},Self);
			case 'Charge': return new AspectApplier(function(oContext :ThisContext, oEvent :MoveContext ) {
					oContext.processor.log('Charging');
					return new Charge( new Move( 
						oEvent.move.getId(), oEvent.move.getLabel(), null, null, SingleFoe,
						parseEffectAr( Reflect.field(oContext,'child_ar'), oRoot ) 
					) );
				},Self);
			case 'Dance': return new AspectApplier(function(oContext :ThisContext, oEvent :MoveContext ) {
					var iMove = oEvent.mon_att.getMoveIndex( oEvent.move );
					if( iMove == null ) throw '!!!';
					return new Dance( oContext.processor.getChanceAr([2,3]), iMove );
				},Self,AfterDamage);
			case 'Tailwind': return new AspectApplier(function( oContext :ThisContext, oEvent :MoveContext ) {
					return new Tailwind();
				},AllyTeam);
			case 'LeechSeed': return new AspectApplier(function( oContext :ThisContext, oEvent :MoveContext ) {
					var oMon = oEvent.mon_def;
					if ( oMon.hasHitType(Grass)) {
						oContext.processor.log('No effect on Grass');
						return null;
					}
					return new LeechSeed( 0 /* TODO : get target battleslot index */);
				},
				SingleFoe, Damage, null
			);
			case 'Drain': return new Drain();
			case 'Venoshock': return new Venoshock();
			case 'Round': return new Round();
			case 'Facade': return new Facade();
			case 'WeatherApplier': return new SimpleApplier( _getClass( oEffectData.weather ), AllyTeam);
			case 'WheaterBall': return new WheaterBall();
			case 'MultiHit5': return new MultiHit5( new Damage( 
				untyped oEffectData.power,
				EnumTool.getHitTypeFromString( untyped oEffectData.type ),
				EnumTool.getHitCategory( untyped oEffectData.category )
			));
			case 'Spike': return new SimpleApplier(Spike,OppoTeam);
			case 'SpikePoison': return new SimpleApplier(SpikePoison,OppoTeam);
				
		}
		throw 'Unknown class "'+Reflect.field( oEffectData, 'class')+'"';
	}

	private function _parseStatApplier( o :Dynamic ) :IAspect {
		var m = new Map<EStat,Int>();
		for( sStat in cast(o.stat,Array<Dynamic>) )
			m.set( _getStatFromString( sStat ), cast(o.stage,Int) );
		var oEffect = new StatChange(
			m,
			Reflect.hasField( o, 'target' ) ? 
				EnumTool.getTargetType( untyped o.target ) : Self,
			Reflect.hasField( o, 'filter' ) ? 
				[EnumTool.getEventFilter( untyped o.filter )] : []
		);
		
		if( !Reflect.hasField( o, 'chance' ) ) return oEffect;
		return new Chance( untyped o.chance / 100, [oEffect], [], Normal );
	}

	private function _parseStatusApplier( o :Dynamic ) :IAspect {
		switch( Reflect.field( o, 'status') ) {
			case 'Confuse': return new AspectApplier(function( oContext :ThisContext, oEvent :MoveContext ) {
					return new Confusion( oContext.processor.getChanceAr([2,3,4,5]) );
				},SingleFoe,AfterDamage,Reflect.hasField(o,'chance') ? untyped o.chance /100 : null);
			case 'Poison': return new PoisonApplier( false );
			case 'DeadlyPoison': return return new PoisonApplier( true );
			case 'Burn': return new BurnApplier();
			case 'Paralyze': return new ParalyzeApplier();
			case 'Sleep': return new SleepApplier();
			case 'Freeze': return new AspectApplier(function( oContext :ThisContext, oEvent :MoveContext ) {
				return new Freeze();
			},SingleFoe,AfterDamage,Reflect.hasField(o,'chance') ? untyped o.chance /100 : null);
			case 'Flinch': return new AspectApplier(function( oContext :ThisContext, oEvent :MoveContext ) {
				return new Flinch();
			},SingleFoe,AfterDamage,Reflect.hasField(o,'chance') ? untyped o.chance /100 : null);
		}
		throw 'Unknown class "'+Reflect.field( o, 'status')+'"';
	}


	public function slugify( s :String ) {
		return s.toUpperCase().replace(' ','_');
	}

	public function _getStatFromString( s :String ) {
		switch( s ) {
			case 'Att': return EStat.Att;
			case 'Def': return EStat.Def;
			case 'Mag': return EStat.Mag;
			case 'Res': return EStat.Res;
			case 'Speed': return EStat.Speed;
			case 'Accuracy': return EStat.Accuracy;
			case 'Evasion': return EStat.Evasion;
		}
		throw '!!!';
	}

	public function _getClass( s :String ) :Class<IAspect> {
		switch( s ) {
			case 'IMainStatus': return IMainStatus;
			case 'Sleep': return SleepStatus;

			case 'Sunny': return Sunny;
			case 'Rain': return Rain;
			case 'Hail': return Hail;
			case 'Sandstorm': return SandStorm;

		}
		throw '!!!';
	}

	public function _getAspectFlag( s :String ) :EAspectFlag {
		switch( s ) {
			case 'soundbased': return SoundBase;
		}
		throw '!!!';
	}

	public function _getMovePriority( s :Int ) :EMovePriority {
		switch( s ) {
			case 5: return HelpingHand;
			case 4: return Protect;
			case 3: return FakeOut;
			case 2: return AllySwitch;
			case 1: return QuickAttack;
			case -1: return VitalThrow;
			case -2: return FocusPunch;
			case -4: return Revenge;
			case -5: return Counter;
			case -6: return Teleport;
			case -7: return TrickRoom;
		}
		throw 'unknown "'+s+'"';
	}

}

typedef Config_Move = {

	var name :String;
	var type :String;
	var category :String;
	var power :Null<Int>;
	var accuracy :Null<Int>;
	var pp :Int;
	var ?Effect :Array<Dynamic>;
	var ?priority :Int;
}

typedef MoveData = {
	var type :EHitType;
	var category :EDamageCategory;
	var power :Null<Int>;
	var accuracy :Null<Float>;
}