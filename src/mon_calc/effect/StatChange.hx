package mon_calc.effect;

import mon_calc.ds.ThisContext;
import mon_calc.ds.EEventFilter;
import mon_calc.aspect.core.AAspect;
import mon_calc.battle_aspect.StatModifier;
import mon_calc.ds.MoveContext;
import mon_calc.ds.ETargetType;
import mon_calc.entity.EStat;
import mon_calc.battle_aspect.IMainStatus;

class StatChange extends AAspect {

	var _mStat :Map<EStat,Int>;
	var _eTarget :ETargetType;

	public function new( 
		aStat :Map<EStat,Int>,
		eTarget :ETargetType,
		aFilter :Array<EEventFilter> = null
	) {
		super([OnAttack],[Dealing].concat(aFilter == null ? [] : aFilter),[]);
		_mStat = aStat;
		_eTarget = eTarget;
	}
	override public function getPriority() :String { return '8'; }

	override function onAttack(oContext:ThisContext, oEvent:MoveContext) {
		
		// Get target
		var oTarget = null;
		if( _eTarget == Self ) oTarget = oEvent.mon_att;
		if( _eTarget == SingleFoe ) oTarget = oEvent.mon_def;

		if( oTarget == null ) throw 'invalid target';


		oContext.processor.addAspect( oTarget, new StatModifier( _mStat ), oEvent.mon_att, this );
	}
}