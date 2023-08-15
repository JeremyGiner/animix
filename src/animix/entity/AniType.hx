package animix.entity;

import mon_calc.core.aspect.IAspect;
import mon_calc.core.aspect.AAspectBearer;
import animix.ds.EDamageElement;
import animix.ds.EStat;

class AniType extends AAspectBearer {

	var _iId :Int;  
	var _sLabel :String;  
	var _aStat :Map<EStat,Int>;
	var _eType1 :EDamageElement;
	var _eType2 :EDamageElement;
	var _aAbility :Array<IAspect>;
	var _aMoveSet :Array<Move>;
	var _aEvolution :Array<String>;

	public static var DEFAULT_MOVE :Move = null;


	public function new( 
		iId :Int,
		sLabel :String,  
		aStat :Map<EStat,Int>,
		eType1 :EDamageElement,
		eType2 :EDamageElement,
		aAbility :Array<IAspect>,
		aMoveSet :Array<Move>,
		aEvolution :Array<String>
	) {
		_iId = iId;
		_sLabel = sLabel;
		_aStat = aStat;
		_eType1 = eType1;
		_eType2 = eType2;
		_aAbility = aAbility;
		_aMoveSet = aMoveSet;
		_aEvolution = aEvolution;
		super([]);
	}

	public function getStat( eStat :EStat) {
		return _aStat.get( eStat );
	}

	public function getId() { return _iId; }
	public function getLabel() { return _sLabel; }
	public function geElement0() { return _eType1; }
	public function getElement1() { return _eType2; }
	public function getAbilityAr() { return _aAbility; }
	public function getMoveSet() { return _aMoveSet; }
	public function getEvolutionAr() { return _aEvolution; }
	public function getDefaultMove() { return DEFAULT_MOVE; }
	public function getPassiveAr() { return getAspectAr(); }
}