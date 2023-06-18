package mon_calc.tool;

import mon_calc.battle_aspect.IMainStatus;
import mon_calc.entity.Mon;

class MonTool {

	static public function isUnderground( oMon :Mon ) {
		return false;
// TODO Dig
	}
	
	static public function isGrounded( oMon :Mon ) {
		
		if( oMon.hasHitType( Flying ) )
			return false;
// TODO : Telekinesis, Ingrain, Iron Ball, Magnet Rise, Gravity, Levitate, Air Balloon
		return true;
	}
	static public function isPoisonable( oMon :Mon ) {
		if( 
			oMon.hasHitType( Poison ) 
			|| oMon.hasHitType( Steel ) 
		) return false;

		// TODO : aspect prevent

		return true;
	}

	static public function isBurnable( oMon :Mon ) {
		if( oMon.hasHitType( Fire ) ) return false;

		// TODO : aspect prevent

		return true;
	}

	static public function isParalyzable( oMon :Mon ) {
		if( oMon.hasHitType( Electric ) ) return false; // Generation VI

		// TODO : aspect prevent

		return true;
	}

	static public function isSleepable( oMon :Mon ) {

		// TODO : aspect prevent

		return true;
	}
}