package mon_calc.effect;

import animix.entity.Ani;
import animix.ds.EDamageType;
import mon_calc.entity.EDamageCategory;
import animix.ds.EDamageElement;
import mon_calc.ds.event.DamageCalcContext;
import mon_calc.ds.ThisContext;
import mon_calc.ds.enumeration.EAspectFlag;
import mon_calc.aspect.core.AAspect;
import mon_calc.ds.EPriority;
import mon_calc.tool.IntTool;
import mon_calc.entity.Mon;
import mon_calc.ds.MoveContext;


class Damage {

	var _eType :EDamageType;
	var _eCategory :EDamageElement;
	var _iPower :Int;

	public function new(
		iPower :Int,
		eType :EDamageType,
		eCategory :EDamageElement,
		aFlag :Array<EAspectFlag> = null
	) {
		_eType = eType;
		_eCategory = eCategory;
		_iPower = iPower;
	}

	public function getHitType() { return _eType; }
	public function getCategory() { return _eCategory; }
	public function getDamageCategory() { return _eCategory; }
	public function getPower() { return _iPower; }
	//public function getFlagAr() { return _aFlag; }

	public function onAttack( oContext :ThisContext, oEvent :MoveContext ) {

		if( oEvent.mon_def == null ) throw '!!!';

		var oCalcContext = oContext.processor.calcDamage( 
			_createCalcContext( oContext, oEvent )
		);
		
		// Case : attack failed (e.g. type immunity)
		if( oCalcContext.factor == null ) return;

		oContext.processor.damage({
			type: OnDamagePre,
			attack_context: oEvent,
			mon_att: oEvent.mon_att,
			target: _getTarget( oEvent ),
			source: this,
			damage: _calcDamage( oContext, oCalcContext ),
			prevent_default: false,
		});
	}

	private function _createCalcContext( 
		oContext :ThisContext, 
		oEvent :MoveContext 
	) :DamageCalcContext {
		var fFactor = getAffinityFactor(
			oEvent.mon_def, _eType
		);
		
		var mStatAtt = oContext.processor.getCurrentMonStat( oEvent.mon_att );
		var mStatDef = oContext.processor.getCurrentMonStat( oEvent.mon_def );
		
		return {
			type: OnDamageCalc,
			crit_chance: 1/16,
			factor: fFactor,
			power: getPower(),
			damage: this,

			att_mon: oEvent.mon_att,
			att_stat: ( _eCategory == EDamageType.Physic ) ?
				mStatAtt.get(Att) : mStatAtt.get(Mag),

			def_mon: oEvent.mon_def,
			def_stat: ( _eCategory == EDamageType.Physic ) ?
				mStatDef.get(Def) : mStatDef.get(Res),
			def_side: !oEvent.side_att,
		};
	}

	private function _calcDamage( oContext :ThisContext, oEvent :DamageCalcContext ) :Int {
		// https://bulbapedia.bulbagarden.net/wiki/Damage


		var fStabFactor = getStabFactor( oEvent.att_mon );
		var fCriticFactor = oContext.processor.getChance( oEvent.crit_chance ) ? 
			1.5 : 1;//TODO 2 if crtic
		var fTargetFactor = 1;//TODO 
		var iLevel = 50;
		var fLevelFactor =  IntTool.div( iLevel * 2, 5) + 2;
		// TODO : hook 
		var fBaseDamage = Math.floor(
				( fLevelFactor
					* oEvent.power
					* (oEvent.att_stat / oEvent.def_stat)
				) / 50 
			) 
			+ 2;

		return Math.floor(
			fBaseDamage 
			* fTargetFactor
			* fStabFactor
			* fCriticFactor
			* oEvent.factor
		);
	}

	private function getStabFactor( oMonAtt :Ani ) :Float {
		if( ! oMonAtt.hasElement( _eType ) )
			return 1;
		return 1.5;
	}

	private function _getTarget( oEvent :MoveContext ) {
		return oEvent.mon_def; // TODO 
	}


	private function getAffinityFactor( 
		eElementAtt :EDamageElement,
		eElementDef :EDamageElement
	) :Float {
		if(eElementAtt == eElementDef) return 0;
		switch([eElementAtt,eElementDef]) {
			case [Water,Fire]: return 1.5;
			case [Fire,Air]: return 1.5;
			case [Air,Earth]: return 1.5;
			case [Earth,Electric]: return 1.5;
			case [Electric,Water]: return 1.5;

			case [Fire,Water]: return 0.5;
			case [Air,Fire]: return 0.5;
			case [Earth,Air]: return 0.5;
			case [Electric,Earth]: return 0.5;
			case [Water,Electric]: return 0.5;

			default:
		}
		return 1.0;
	}



	
	
}
