package animix.entity;

import mon_calc.core.aspect.IAspect;
import mon_calc.core.aspect.AAspectBearer;
import mon_calc.tool.IntTool;
import animix.ds.EStat;
import animix.ds.EDamageElement;


class Ani extends AAspectBearer {
	
	var _sLabel :String;
	var _iHealth :Int;
	var _iEnergy :Int;
	var _iLevel :Int;
	var _oType :AniType;

	var _aType :Array<EDamageElement>;
	var _aMove :Array<Move>;

	//_________________________________
	// Calculable

	var _mStatEffectiveCache :Map<EStat,Int>;

//_____________________________________________________________________________
// Constructor

	public function new( 
		sLabel :String,
		oType :AniType, 
		iAbilityIndex :Int,
		aMove :Array<Move>
	) {
		super();
		_sLabel = sLabel;
		_oType = oType;
		
		_aType = [oType.geElement0(),oType.getElement1()];
		_iLevel = 50;

		_updateEffective();

		_iHealth = getStatEffective( Health );
		_iEnergy = getStatEffective( Energy );
	}

//_____________________________________________________________________________
// Accessor

	public function getHealth() { return _iHealth; }
	public function getEnergy() { return _iEnergy; }
	public function getType() { return _oType; }
	public function getLabel() { return _sLabel; }
	public function getLevel() { return _iLevel; }
	public function getMoveAr() { return _aMove; }
	public function getMove( i :Int ) { return _aMove[i]; }
	public function geElement0() { return _aType[0]; }
	public function getElement1() { return _aType[1]; }
	public function hasElement(  eType :EDamageElement ) { 
		return _aType[0] == eType 
			||  _aType[1] == eType; 
	}

	public function getStatEffective( eStat :EStat) {
		return _mStatEffectiveCache.get( eStat );
	}

	public function getStatEffectiveMap() {
		return _mStatEffectiveCache.copy();
	}

	public function getMaxHealth() { return getStatEffective(Health); }

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
			.concat( _oType.getPassiveAr() )
		;
	}

//_____________________________________________________________________________
// Modifier

	public function reset() {
		// Reset all aspect but status
		aspectPurge(function( o ) {
			// TODO : do not reset aspect with "persist" flag
			return true;
		});
		
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
			Health => _calcStatEffective( Health ),
			Energy => _calcStatEffective( Energy ),
			
			Percing => _calcStatEffective( Percing ),
			Defence => _calcStatEffective( Defence ),

			Magic => _calcStatEffective( Magic ),
			Resist => _calcStatEffective( Resist ),

			Blunt => _calcStatEffective( Blunt ),
			BluntDef => _calcStatEffective( BluntDef ),

			Speed => _calcStatEffective( Speed ),
		];
	}

	public function _calcStatEffective( eStat :EStat ) :Int {

		var fStat = _oType.getStat( eStat ) * 2;

		if( eStat == EStat.Health ) {
			return Math.floor((fStat * _iLevel / 100) + _iLevel + 10);
		}
		
		return Math.floor((fStat * _iLevel / 100) + 5);
	}
}