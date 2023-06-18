package mon_calc.ds;

import mon_calc.entity.EStat;

class Nature {
	var _iId :Int;
	var _sLabel :String;
	var _eBonus :EStat;
	var _eMalus :EStat;
	public function new( iId :Int, sLabel :String, eBonus :EStat, eMalus :EStat ) {
		_sLabel = sLabel;
		_eBonus = eBonus;
		_eMalus = eMalus;
	}
	public function getId() { return _iId; }
	public function getLabel() { return _sLabel; }
	public function getBonus() { return _eBonus; }
	public function getMalus() { return _eMalus; }


	static var NATURE = [
		new Nature(0,'Whatever',Att,Att),
		new Nature(1,'Adamant',Att,Mag),
		new Nature(2,'Modest',Mag,Att),
		new Nature(3,'Modest',Speed,Att),
		new Nature(4,'Modest',Speed,Mag),
	];

	static public function get( i :Null<Int> ) {
		if( i == null ) return null;
		return NATURE[i];
	}
}