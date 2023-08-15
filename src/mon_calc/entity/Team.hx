package mon_calc.entity;

import haxe.Serializer;
import haxe.Unserializer;
import mon_calc.ds.event.EventContext;
import mon_calc.aspect.core.AAspectBearer;
import mon_calc.battle_aspect.IAspect;

class Team extends AAspectBearer {

	var _sLabel :String;
	var _aMon :Array<Mon>;

	public function new( sLabel :String, aMon :Array<Mon> ) {
		super();
		if( aMon.length == 0 ) throw '!!!';
		_aMon = aMon;
		_sLabel = sLabel;
	}

	public function copy() {
		var oTeam = new Team( _sLabel, _aMon.map((oMon :Mon ) -> {
			return oMon.copy();
		}));
		oTeam._aAspect = Unserializer.run( Serializer.run( _aAspect ) );
		return oTeam;
	}

	public function getLabel() { return _sLabel; }
	public function getMonAr() :Array<Mon> { return _aMon; }
	public function getMon( i :Int ) :Mon { 
		if( i >= _aMon.length ) return null;
		return _aMon[ i ]; 
	}

	public function getMonIndex( oMon :Mon ) :Null<Int> {
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