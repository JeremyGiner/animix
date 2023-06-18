package mon_calc.effect;

import mon_calc.ds.enumeration.EPriorityAttack;
import mon_calc.aspect.core.AAspect;
import mon_calc.ds.ThisContext;
import mon_calc.battle_aspect.IAspect;
import mon_calc.ds.EPriority;
import mon_calc.ds.MoveContext;

class AccuracyCheck extends AAspect {

	var _fMoveAccuracy :Float;

	public function new( fMoveAccuracy :Float ) {
		_fMoveAccuracy = fMoveAccuracy;
		super([OnAttack],[],[]);
	}

	override public function getPriority() {
		return String.fromCharCode( cast EPriorityAttack.AccuracyCheck );
	}

	override function onAttack(oContext:ThisContext, oEvent:MoveContext) {
		// [0;1]
		if( oContext.processor.getChance(
			_fMoveAccuracy
			* _getMultiplier( coal( oEvent.stat_att.get( Accuracy ) ) )
			* _getMultiplier( -coal(oEvent.stat_def.get( Evasion ) ) )
		) ) return;
		oEvent.turnover = true;
		oContext.processor.log( 'miss' );
	}

	// TODO : make it a feature of stat map
	private function coal( x :Null<Int> ) {
		if( x == null ) return 0;
		return x;
	}


	private function _getMultiplier( i :Int ) :Float {
		switch( i ) {
			case 6: return 9/3;
			case 5: return 8/3;
			case 4: return 7/3;
			case 3: return 6/3;
			case 2: return 5/3;
			case 1: return 4/3;
			case 0: return 1;
			case -1: return 3/4;
			case -2: return 3/5;
			case -3: return 3/6;
			case -4: return 3/7;
			case -5: return 3/8;
			case -6: return 3/9;
		}
		throw '!!!';
	}
}