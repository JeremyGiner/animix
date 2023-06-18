package mon_calc.battle_aspect;

import mon_calc.aspect.core.IAspectBearer;
import mon_calc.core.BattleProcessor;
import mon_calc.ds.ThisContext;
import mon_calc.ds.event.StatCalcContext;
import mon_calc.aspect.IStackable;
import mon_calc.aspect.core.AAspect;
import mon_calc.ds.EPriority;
import mon_calc.tool.IntTool;
import mon_calc.entity.EStat;

class StatModifier extends AAspect implements IStackable {

	var _mStat :Map<EStat,Int>;

	public function new( mStat :Map<EStat,Int> = null ) {
		super([OnStatCalc],[],[]);

		reset();
		if( mStat != null ) {
			_addStat( mStat );
		}
	}

	override function getPriority() :String { return '0'; }
	
	override function onStatCalc(oContext:ThisContext, oEvent:StatCalcContext) {
		for( stat => value in oEvent.stat )
			oEvent.stat.set( stat, _calcStat(stat,value) );
	}

	public function get( eStat :EStat ) {
		return _mStat.get(eStat);
	}

	public function addModifier( eStat :EStat, iStageDelta :Int ) {
		_mStat.set( 
			eStat, 
			IntTool.clamp( iStageDelta + _mStat.get( eStat ), -6, 6 )
		);
	}

	public function addStack( 
		oProcessor :BattleProcessor, 
		oTarget :IAspectBearer,  
		oAspect :IStackable 
	) {
		if( !Std.isOfType(oAspect,StatModifier) ) throw '!!!';
		var oAdd :StatModifier = cast oAspect;
		_addStat( oAdd._mStat );
	}

	public function onStatCalculation( m :Map<EStat,Int> ) {
		
	}

	public function reset() {
		_mStat = [
			Att => 0, Def => 0, Mag => 0, Res => 0, Speed => 0, 
			Accuracy => 0, Evasion => 0,
		];
	}

	private function _addStat( mStat :Map<EStat,Int> ) {
		for( k => v in mStat )
			addModifier(k,v);
	}

	private function _calcStat( eType :EStat, iEffectiveStat :Int ) :Int {

		if( [Accuracy,Evasion].contains(eType) )
			return _mStat.get( eType );

		return Math.floor( 
			iEffectiveStat 
			* _getMultiplier( eType, coal(_mStat.get( eType )) )
		);
	}

	// TODO : make it a feature of stat map
	private function coal( x :Null<Int> ) {
		if( x == null ) return 0;
		return x;
	}

	private function _getMultiplier( eType :EStat, iStage :Int ) :Float {

		switch( iStage ) {
			case 6: return 4;
			case 5: return 3.5;
			case 4: return 3;
			case 3: return 2.5;
			case 2: return 2;
			case 1: return 1.5;
			case 0: return 1;
			case -1: return 2/3;
			case -2: return 2/4;
			case -3: return 2/5;
			case -4: return 2/6;
			case -5: return 2/7;
			case -6: return 2/8;
		}
		throw '!!!';
	}

}