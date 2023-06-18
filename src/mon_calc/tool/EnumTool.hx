package mon_calc.tool;

import mon_calc.ds.EEventFilter;
import mon_calc.ds.ETargetType;
import mon_calc.entity.EDamageCategory;
import mon_calc.entity.EHitType;

class EnumTool {
	static public function getHitTypeFromString( s :String ) :Null<EHitType> {
		if( s == null ) return null;
		switch( s ) {
			case 'Normal': return EHitType.Normal;
			case 'Fire': return EHitType.Fire;
			case 'Water': return EHitType.Water;
			case 'Grass': return EHitType.Grass;
			case 'Electric': return EHitType.Electric;
			case 'Ice': return EHitType.Ice;
			case 'Fighting': return EHitType.Fighting;
			case 'Poison': return EHitType.Poison;
			case 'Ground': return EHitType.Ground;
			case 'Flying': return EHitType.Flying;
			case 'Psychic': return EHitType.Psychic;
			case 'Bug': return EHitType.Bug;
			case 'Rock': return EHitType.Rock;
			case 'Ghost': return EHitType.Ghost;
			case 'Dark': return EHitType.Dark;
			case 'Dragon': return EHitType.Dragon;
			case 'Steel': return EHitType.Steel;
			case 'Fairy': return EHitType.Fairy;
		}
		throw 'unknown "'+s+'"';
	}

	static public function getHitCategory( s :String ) {
		switch( s ) {
			case 'Physical': return EDamageCategory.Physic;
			case 'Special': return EDamageCategory.Magic;
		}
		throw 'unknown "'+s+'"';
	}

	static public function getTargetType( s :String ) :ETargetType {
		switch( s.toLowerCase() ) {
			case 'self','team': // TODO : team
				return ETargetType.Self;
			case 'single','adjacent','adjacent_all','single_foe_ally','single_foe_random': 
				return ETargetType.SingleFoe;
		}
		throw 'unknown "'+s+'"';
	}

	static public function getEventFilter( s :String ) :EEventFilter {
		switch( s.toLowerCase() ) {
			case 'sunny': return WeatherSunny;
		}
		throw 'unknown "'+s+'"';
	}

	
}