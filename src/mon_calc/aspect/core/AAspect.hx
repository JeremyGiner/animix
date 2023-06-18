package mon_calc.aspect.core;

import mon_calc.ds.AspectExecuteContext;
import mon_calc.ds.MonDamageContext;
import mon_calc.ds.event.*;
import mon_calc.ds.MoveContext;
import mon_calc.ds.enumeration.EAspectFlag;
import mon_calc.ds.EPriority;
import mon_calc.aspect.terrain.ElectricTerrain;
import mon_calc.battle_aspect.weather.Rain;
import mon_calc.ds.ThisContext;
import mon_calc.battle_aspect.IAspect;
import mon_calc.ds.EEventFilter;
import mon_calc.ds.EEventType;

class AAspect implements IAspect {

	var _aEventType :Array<EEventType>;
	var _aFilter :Array<EEventFilter>;
	var _aFlag :Array<EAspectFlag>;
	var _iFade :Null<Int>;

	public function new( 
		aEvent :Array<EEventType>,
		aFilter :Array<EEventFilter>,
		aFlag :Array<EAspectFlag>,
		iFade :Null<Int> = null
	) {
		_aEventType = aEvent;
		_aFilter = aFilter;
		_aFlag = aFlag;
		_iFade = iFade;

		if( _iFade != null ) {
			_aEventType.push( OnTurnEnd );
		}
	}

	public function getLabel() { return Type.getClassName( Type.getClass( this ) ); }
	public function getEvent() { return _aEventType; }
	public function getFadeCount() { return _iFade; }
	public function hasFlag( e :EAspectFlag ) { return _aFlag.contains( e ); }
	public function getPriority() :String { return cast EPriority.Normal; }

	public function getMainClass() :Class<IAspect> {
		return cast Type.getClass( this );
	}

	public function validate( oContext :ThisContext ) {
		var oEvent = oContext.event;
		if( ! _aEventType.contains( oEvent.type ) ) return false;
		for( oFilter in _aFilter )
			switch( oFilter ) {
				case Ally:
					if( 
						oEvent.type == OnStatCalc
						&& oContext.side != untyped oContext.event.side
					) return false;
					if( 
						oEvent.type == OnSwitchIn
						&& oContext.side != untyped oContext.event.side
					) return false;
				case Foe:
					if( 
						oEvent.type == OnSwitchOut
						&& oContext.side == untyped oContext.event.side
					) return false;
				case Self:
					if( 
						oEvent.type == OnAttack
					) throw '!!!';
					if( 
						oEvent.type == OnStatCalc
						&& oContext.owner != untyped oContext.event.mon
					) return false;
					if( 
						oEvent.type == OnSwitchOut
						&& oContext.owner != untyped oContext.event.mon
					) return false;
					if( 
						[
							OnAspectEntryPre, OnAspectEntryPost,
							OnAspectExecutePre, OnAspectExecutePost,
							OnAffinityCalc,
						].contains( oEvent.type )
						&& oContext.owner != untyped oContext.target
					) return false;
				case Dealing:
					if( 
						[OnAttack,OnDamageCalc,OnDamagePre].contains( oEvent.type )
						&& oContext.mon != untyped oContext.event.mon_att
					) return false;
				case AllyReceiving:
					if( 
						oEvent.type == OnDamageCalc
						&& oContext.side != untyped oContext.event.def_side
					) return false;
				case Receiving:
					if( 
						oEvent.type == OnDamageCalc
						&& oContext.owner != Reflect.field( oContext.event, 'mon_def' )
					) return false;
					if( 
						oEvent.type == OnDamagePre
						&& oContext.owner != Reflect.field( oContext.event, 'target' )
					) return false;
				case TargetFoe: 
					if( Reflect.hasField( oContext, 'target' ) ) return false;
					if( oContext.side == untyped oContext.side ) 
						return false;
				case TargetOwner:
					if( Reflect.hasField( oContext, 'target' ) ) return false;
					if( oContext.mon != untyped oContext.target ) 
						return false;
				case WeatherRain:
					if( ! oContext.battle.hasAspectByClass(Rain) ) return false;
				case TerrainElectric:
					if( ! oContext.battle.hasAspectByClass(ElectricTerrain) ) return false;
				case DamageMag:
					if( ! [OnDamageCalc,OnDamagePost,OnDamagePre].contains( oEvent.type ) ) return false;
					throw 'not implemented';
				default:
					throw 'not implemented';
			}
		return true;
	}

	public function process( o :ThisContext ) {
		switch( o.event.type ) {
			case OnTurnStart: return onTurnStart( o );
			case OnTurnEnd: return onTurnEnd( o );
			case OnActionPrompt: return onAttack( o, cast o.event );
			case OnMoveCalc: return onMoveCalc( o, cast o.event );
			case OnAffinityCalc: return onAffinityCalc( o, cast o.event );
			case OnStatCalc: return onStatCalc( o, cast o.event );
			case OnAttack: return onAttack( o, cast o.event );
			case OnDamageCalc: return onDamageCalc( o, cast o.event );
			case OnDamagePre: return onDamagePre( o, cast o.event );
			case OnDamagePost: return onDamagePost( o, cast o.event );
			case OnAspectEntryPre: return onAspectEntryPre( o, cast o.event );
			case OnAspectEntryPost: return onAspectEntryPost( o, cast o.event );
			case OnAspectExecutePre: return onAspectExecutePre( o, cast o.event );
			case OnAspectExecutePost: return onAspectExecutePost( o, cast o.event );
			case OnSwitchIn: return onSwitchIn( o, cast o.event );
			case OnSwitchOut: return onSwitchOut( o, cast o.event );
			default: // TODO
		}
		throw '!!!';
	}

	public function onTurnStart( o :ThisContext ) {
		// STUB
		return null;
	}

	public function onTurnEnd( o :ThisContext ) {

		if( _iFade == null ) return null;

		// Remove when fading
		if( _iFade <= 0 )
			o.processor.removeAspect( o.owner, this, this );
		_iFade--;

		return null;
	}

	public function onStatCalc( oContext :ThisContext, oEvent :StatCalcContext ) {
		// STUB
		return null;
	}

	public function onAttack( oContext :ThisContext, oEvent :MoveContext ) {
		// STUB
		return null;
	}

	public function onMoveCalc( oContext :ThisContext, oEvent :MoveCalcContext ) {
		// STUB
		return null;
	}

	public function onAffinityCalc( oContext :ThisContext, oEvent :AffinityContext ) {
		// STUB
		return null;
	}

	public function onDamageCalc( oContext :ThisContext, oEvent :DamageCalcContext ) {
		// STUB
		return null;
	}

	public function onDamagePre( oContext :ThisContext, oEvent :MonDamageContext ) {
		// STUB
		return null;
	}
	public function onDamagePost( oContext :ThisContext, oEvent :MonDamageContext ) {
		// STUB
		return null;
	}

	public function onActionPrompt( oContext :ThisContext, oEvent :ActionPromptContext ) {
		// STUB
		return null;
	}

	public function onAspectEntryPre( oContext :ThisContext, oEvent :AspectEntryContext ) {
		// STUB
		return null;
	}

	public function onAspectEntryPost( oContext :ThisContext, oEvent :AspectEntryContext ) {
		// STUB
		return null;
	}

	public function onAspectExecutePre( oContext :ThisContext, oEvent :AspectExecuteContext ) {
		// STUB
		return null;
	}
	public function onAspectExecutePost( oContext :ThisContext, oEvent :AspectExecuteContext ) {
		// STUB
		return null;
	}

	public function onSwitchIn( oContext :ThisContext, oEvent :SwitchInContext ) {
		// STUB
		return null;
	}
	public function onSwitchOut( oContext :ThisContext, oEvent :SwitchOutContext ) {
		// STUB
		return null;
	}
}