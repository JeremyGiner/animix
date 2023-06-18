package mon_calc.system;

import mon_calc.entity.EHitType;
import mon_calc.entity.EStat;
import mon_calc.entity.Mon;
import mon_calc.entity.Move;

class BattleProcess {

	static var HITTYPE_MAP = [
		EHitType.Normal + ';' + EHitType.Rock => 0.5, 
		EHitType.Normal + ';' + EHitType.Ghost => 0, 
		EHitType.Normal + ';' + EHitType.Steel => 0.5, 
		EHitType.Fire + ';' + EHitType.Fire => 0.5, 
		EHitType.Fire + ';' + EHitType.Water => 0.5, 
		EHitType.Fire + ';' + EHitType.Grass => 2, 
		EHitType.Fire + ';' + EHitType.Ice => 2, 
		EHitType.Fire + ';' + EHitType.Bug => 2, 
		EHitType.Fire + ';' + EHitType.Rock => 0.5, 
		EHitType.Fire + ';' + EHitType.Dragon => 0.5,
		EHitType.Fire + ';' + EHitType.Steel => 2,
		EHitType.Water + ';' + EHitType.Fire => 2, 
		EHitType.Water + ';' + EHitType.Water => 0.5, 
		EHitType.Water + ';' + EHitType.Grass => 0.5, 
		EHitType.Water + ';' + EHitType.Ground => 2, 
		EHitType.Water + ';' + EHitType.Rock => 2, 
		EHitType.Water + ';' + EHitType.Dragon => 0.5, 
		EHitType.Electric + ';' + EHitType.Water => 2, 
		EHitType.Electric + ';' + EHitType.Electric => 0.5, 
		EHitType.Electric + ';' + EHitType.Grass => 0.5, 
		EHitType.Electric + ';' + EHitType.Ground => 0, 
		EHitType.Electric + ';' + EHitType.Flying => 2, 
		EHitType.Electric + ';' + EHitType.Dragon => 0.5, 
		EHitType.Grass + ';' + EHitType.Fire => 0.5, 
		EHitType.Grass + ';' + EHitType.Water => 2, 
		EHitType.Grass + ';' + EHitType.Grass => 0.5, 
		EHitType.Grass + ';' + EHitType.Poison => 0.5, 
		EHitType.Grass + ';' + EHitType.Ground => 2, 
		EHitType.Grass + ';' + EHitType.Flying => 0.5, 
		EHitType.Grass + ';' + EHitType.Bug => 0.5, 
		EHitType.Grass + ';' + EHitType.Rock => 2, 
		EHitType.Grass + ';' + EHitType.Dragon => 0.5, 
		EHitType.Grass + ';' + EHitType.Steel => 0.5, 
		EHitType.Ice + ';' + EHitType.Fire => 0.5, 
		EHitType.Ice + ';' + EHitType.Water => 0.5, 
		EHitType.Ice + ';' + EHitType.Grass => 2, 
		EHitType.Ice + ';' + EHitType.Ice => 0.5, 
		EHitType.Ice + ';' + EHitType.Ground => 2, 
		EHitType.Ice + ';' + EHitType.Flying => 2, 
		EHitType.Ice + ';' + EHitType.Dragon => 2, 
		EHitType.Ice + ';' + EHitType.Steel => 0.5, 
		EHitType.Fighting + ';' + EHitType.Normal => 2, 
		EHitType.Fighting + ';' + EHitType.Ice => 2, 
		EHitType.Fighting + ';' + EHitType.Poison => 0.5, 
		EHitType.Fighting + ';' + EHitType.Flying => 0.5, 
		EHitType.Fighting + ';' + EHitType.Psychic => 0.5, 
		EHitType.Fighting + ';' + EHitType.Bug => 0.5, 
		EHitType.Fighting + ';' + EHitType.Rock => 2, 
		EHitType.Fighting + ';' + EHitType.Ghost => 0, 
		EHitType.Fighting + ';' + EHitType.Dark => 2, 
		EHitType.Fighting + ';' + EHitType.Steel => 2, 
		EHitType.Fighting + ';' + EHitType.Fairy => 0.5,  
		EHitType.Poison + ';' + EHitType.Grass => 2, 
		EHitType.Poison + ';' + EHitType.Poison => 0.5, 
		EHitType.Poison + ';' + EHitType.Ground => 0.5, 
		EHitType.Poison + ';' + EHitType.Rock => 0.5, 
		EHitType.Poison + ';' + EHitType.Ghost => 0.5, 
		EHitType.Poison + ';' + EHitType.Steel => 0, 
		EHitType.Poison + ';' + EHitType.Fairy => 2, 
		EHitType.Ground + ';' + EHitType.Fire => 2, 
		EHitType.Ground + ';' + EHitType.Electric => 2, 
		EHitType.Ground + ';' + EHitType.Grass => 0.5, 
		EHitType.Ground + ';' + EHitType.Poison => 2, 
		EHitType.Ground + ';' + EHitType.Flying => 0, 
		EHitType.Ground + ';' + EHitType.Bug => 0.5, 
		EHitType.Ground + ';' + EHitType.Rock => 2, 
		EHitType.Ground + ';' + EHitType.Steel => 2, 
		EHitType.Flying + ';' + EHitType.Electric => 0.5, 
		EHitType.Flying + ';' + EHitType.Grass => 2, 
		EHitType.Flying + ';' + EHitType.Fighting => 2, 
		EHitType.Flying + ';' + EHitType.Bug => 2, 
		EHitType.Flying + ';' + EHitType.Rock => 0.5, 
		EHitType.Flying + ';' + EHitType.Steel => 0.5, 
		EHitType.Psychic + ';' + EHitType.Fighting => 2, 
		EHitType.Psychic + ';' + EHitType.Poison => 2, 
		EHitType.Psychic + ';' + EHitType.Psychic => 0.5, 
		EHitType.Psychic + ';' + EHitType.Dark => 0, 
		EHitType.Psychic + ';' + EHitType.Steel => 0.5, 
		EHitType.Bug + ';' + EHitType.Fire => 0.5,		
		EHitType.Bug + ';' + EHitType.Grass => 2, 
		EHitType.Bug + ';' + EHitType.Fighting => 0.5, 
		EHitType.Bug + ';' + EHitType.Poison => 0.5, 
		EHitType.Bug + ';' + EHitType.Flying => 0.5, 
		EHitType.Bug + ';' + EHitType.Psychic => 2, 
		EHitType.Bug + ';' + EHitType.Ghost => 0.5, 
		EHitType.Bug + ';' + EHitType.Dark => 2, 
		EHitType.Bug + ';' + EHitType.Steel => 0.5, 
		EHitType.Rock + ';' + EHitType.Fire => 2, 
		EHitType.Rock + ';' + EHitType.Ice => 2, 
		EHitType.Rock + ';' + EHitType.Fighting => 0.5, 
		EHitType.Rock + ';' + EHitType.Ground => 0.5, 
		EHitType.Rock + ';' + EHitType.Flying => 2, 
		EHitType.Rock + ';' + EHitType.Bug => 2, 
		EHitType.Rock + ';' + EHitType.Steel => 0.5, 
		EHitType.Ghost + ';' + EHitType.Normal => 0, 
		EHitType.Ghost + ';' + EHitType.Psychic => 2, 
		EHitType.Ghost + ';' + EHitType.Ghost => 2, 
		EHitType.Ghost + ';' + EHitType.Dark => 0.5, 
		EHitType.Dragon + ';' + EHitType.Dragon => 2, 
		EHitType.Dragon + ';' + EHitType.Steel => 0.5, 
		EHitType.Dragon + ';' + EHitType.Fairy => 0, 
		EHitType.Dark + ';' + EHitType.Fighting => 0.5, 
		EHitType.Dark + ';' + EHitType.Psychic => 2, 
		EHitType.Dark + ';' + EHitType.Ghost => 2, 
		EHitType.Dark + ';' + EHitType.Dark => 0.5, 
		EHitType.Dark + ';' + EHitType.Fairy => 0.5, 
		EHitType.Steel + ';' + EHitType.Fire => 0.5, 
		EHitType.Steel + ';' + EHitType.Water => 0.5, 
		EHitType.Steel + ';' + EHitType.Electric => 0.5, 
		EHitType.Steel + ';' + EHitType.Ice => 2, 
		EHitType.Steel + ';' + EHitType.Rock => 2, 
		EHitType.Steel + ';' + EHitType.Steel => 0.5, 
		EHitType.Steel + ';' + EHitType.Fairy => 2, 
		EHitType.Fairy + ';' + EHitType.Fire => 0.5, 
		EHitType.Fairy + ';' + EHitType.Fighting => 2, 
		EHitType.Fairy + ';' + EHitType.Poison => 0.5, 
		EHitType.Fairy + ';' + EHitType.Dragon => 2, 
		EHitType.Fairy + ';' + EHitType.Dark => 2, 
		EHitType.Fairy + ';' + EHitType.Steel => 0.5, 
	];

	static public function getHitTypeFactor( 
		oAtt :EHitType, 
		oDef1 :EHitType, 
		oDef2 :Null<EHitType>
	) {
		var f = _getHitTypeFactor( oAtt, oDef1 );

		// Case : apply secondary hit type
		if( oDef2 != null && oDef1 != oDef2 ) 
			f *= _getHitTypeFactor( oAtt, oDef2 );
		
		return f;
	}

	static private function _getHitTypeFactor( 
		oAtt :EHitType, 
		oDef :EHitType
	) :Float {

		var k = oAtt + ';' + oDef;
		if( !HITTYPE_MAP.exists( k ) ) return 1;
		return HITTYPE_MAP.get(k);
	}
}