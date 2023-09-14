package animix.entity;

import mon_calc.core.aspect.AAspectBearer;


class Team extends AAspectBearer {
	
	var _sLabel :String;
	var _aMon :Array<Ani>;

	public function new( sLabel :String, aMon :Array<Ani> ) {
		super();
		if( aMon.length == 0 ) throw '!!!';
		_aMon = aMon;
		_sLabel = sLabel;
	}

	public function getLabel() { return _sLabel; }
	public function getMonAr() :Array<Ani> { return _aMon; }
	public function getMon( i :Int ) :Ani { 
		if( i >= _aMon.length ) return null;
		return _aMon[ i ]; 
	}
	public function getFighter( i :Int ) :Ani { 
		if( i >= _aMon.length ) return null;
		return _aMon[ i ]; 
	}

	public function getMonIndex( oMon :Ani ) :Null<Int> {
		for( i in 0..._aMon.length )
			if( _aMon[ i ] == oMon )
				return i;
		return null;
	}

	public function hasValidMon() :Bool {
		for( oMon in _aMon ) {
			if( oMon.getHealth() > 0 )
				return true;
		}
		return false;
	}

	public function switchMon( i :Int ) {
		var oMon = _aMon[0];

		if( i >= _aMon.length ) throw '!!!';

		_aMon[0] = _aMon[ i ];
		_aMon[ i ] = oMon;

		return this;
	}
}