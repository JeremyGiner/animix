package mon_calc.entity;

import haxe.Unserializer;
import haxe.Serializer;
import mon_calc.battle_aspect.status.AMainStatus;
import mon_calc.aspect.core.AAspectBearer;
import mon_calc.ds.Nature;
import mon_calc.tool.IntTool;
import mon_calc.battle_aspect.IAspect;

class Mon extends AAspectBearer {

	var _sLabel :String;
	var _iHealth :Int;
	var _iLevel :Int;
	var _oType :MonType;

	var _mStatTraining :Map<EStat,Int>;
	var _mStatIndiv :Map<EStat,Int>;

	var _aType :Array<EHitType>;
	var _aMove :Array<Move>;
	var _oAbility :Ability;
	var _oItem :Item;

	var _aPP :Array<Int>;
	var _eNature :Nature;

	//_________________________________
	// Calculable

	var _mStatEffectiveCache :Map<EStat,Int>;

//_____________________________________________________________________________
// Constructor

	public function new( 
		sLabel :String,
		oType :MonType, 
		aStatTraining :Map<EStat,Int>,
		iAbilityIndex :Int,
		eNature :Nature,
		aMove :Array<Move>,
		oItem :Item
	) {
		super();
		_sLabel = sLabel;
		_oType = oType;
		_oAbility = oType.getAbilityAr()[ iAbilityIndex ];
		
		_aType = [oType.getHitType1(),oType.getHitType2()];
		_mStatTraining = aStatTraining;
		_mStatIndiv = [
			Health => 31,
			Att => 31, Def => 31,
			Mag => 31, Res => 31,
			Speed => 31,
		];
		_iLevel = 50;
		_aMove = aMove;
		// var a :Array<Int> = aMove.map(function( oMove :Move ) {
		// 	return cast(oMove.getPointMax(),Int);
		// });
		_aPP = aMove.map(function( oMove :Move ) {
			return cast(oMove.getPointMax(),Int);
		});
		_eNature = eNature;
		_oItem = oItem;

		_updateEffective();

		_iHealth = getStatEffective( Health );
	}

	public function copy() {
		var oMon = new Mon( _sLabel, _oType, _mStatTraining, 0, _eNature, _aMove, _oItem );
		oMon._oAbility = _oAbility;
		oMon._aType = _aType.copy();
		oMon._aPP = _aPP.copy();
		oMon._iHealth = _iHealth;
		oMon._aAspect = Unserializer.run( Serializer.run( _aAspect ) );
		return oMon;
	}

//_____________________________________________________________________________
// Accessor

	public function getHealth() { return _iHealth; }
	public function getType() { return _oType; }
	public function getLabel() { return _sLabel; }
	public function getLevel() { return _iLevel; }
	public function getMoveAr() { return _aMove; }
	public function getMove( i :Int ) { return _aMove[i]; }
	public function getMana( i :Int ) { return _aPP[i]; }
	public function getAbility() { return _oAbility; }
	public function getItem() { return _oItem; }
	public function getNature() { return _eNature; }
	public function getHitType0() { return _aType[0]; }
	public function getHitType1() { return _aType[1]; }

	public function getStatTrain( eStat :EStat ) {
		if( ! _mStatTraining.exists( eStat ))
			return 0;
		return _mStatTraining.get( eStat );
	}

	public function getStatIndiv( eStat :EStat ) {
		return _mStatIndiv.get( eStat );
	}

	public function getStatEffective( eStat :EStat) {
		return _mStatEffectiveCache.get( eStat );
	}

	public function getStatEffectiveMap() {
		return _mStatEffectiveCache.copy();
	}

	public function getMaxHealth() { return getStatEffective(Health); }

	public function hasHitType(  eType :EHitType ) { 
		return _aType[0] == eType 
			||  _aType[1] == eType; 
	}

	public function isInPinch() {
		return _iHealth <= Math.floor( getMaxHealth() / 3 );
	}

	public function getMoveIndex( oMove :Move ) :Null<Int> {
		for( i in 0..._aMove.length )
			if( _aMove[ i ] == oMove )
				return i;
		return null;
	}

	override function getAspectAr():Array<IAspect> {
		return super.getAspectAr()
			.concat( _oAbility.getAspectAr() )
			.concat( _oItem == null ? [] : _oItem.getAspectAr() )
		;
	}

//_____________________________________________________________________________
// Modifier

	public function decreasePP( oMove :Move, i :Int ) {
		var index = _aMove.indexOf( oMove );
		if( index == -1 ) return this;
		_aPP[ index ] -= i;
		return this;
	}

	public function reset() {
		// Reset all aspect but status
		aspectPurge(function( o ) {
			return Std.isOfType( o, AMainStatus );
		});
		// TODO : reset type
	}

	public function aspectPurge( fn :IAspect->Bool ) {
		_aAspect = _aAspect.filter( fn );
	}

	public function damage( i :Int ) {
		_iHealth = IntTool.clamp( _iHealth - i, 0, getMaxHealth());
		return this;
	}

	public function heal( i :Int ) {
		_iHealth = IntTool.clamp( _iHealth + i, 0, getMaxHealth());
		return this;
	}

	public function damagePercent( f :Float ) {
		this.damage( Math.floor( _calcStatEffective( Health ) * f ) );
		return this;
	}
	public function healPercent( f :Float ) {
		this.heal( Math.floor( _calcStatEffective( Health ) * f ) );
		return this;
	}

//_____________________________________________________________________________
// Sub-routine

	public function _updateEffective() {
		_mStatEffectiveCache = [
			Health => _calcStatEffective( EStat.Health ),
			Att => _calcStatEffective( EStat.Att ),
			Def => _calcStatEffective( EStat.Def ),
			Mag => _calcStatEffective( EStat.Mag ),
			Res => _calcStatEffective( EStat.Res ),
			Speed => _calcStatEffective( EStat.Speed ),
		];
	}

	public function _calcStatEffective( eStat :EStat ) :Int {

		var fStat = _oType.getStat( eStat ) * 2 
			+ getStatIndiv( eStat )
			+ (getStatTrain( eStat ) / 4)
		;

		if( eStat == EStat.Health ) {
			return Math.floor((fStat * _iLevel / 100) + _iLevel + 10);
		}

		var fNature :Float = 1;

		if( _eNature != null ) {
			if( _eNature.getMalus() == _eNature.getBonus() ) {
				fNature = 1;
			} else if( _eNature.getMalus() == eStat ) {
				fNature = 0.9;
			} else if( _eNature.getBonus() == eStat ) {
				fNature = 1.1;
			}
		}
		
		return Math.floor(
			((fStat * _iLevel / 100) + 5) * fNature );
	}
}