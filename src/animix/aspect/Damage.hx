package animix.aspect;

import animix.core.aspect.OnDamage;
import animix.core.aspect.OnDamageCalc;
import animix.entity.Ani;
import animix.ds.Context;
import animix.event.DamageCalcContext;
import mon_calc.entity.EHitType;
import animix.ds.EDamageType;
import mon_calc.entity.EDamageCategory;
import animix.ds.EDamageElement;
import mon_calc.ds.ThisContext;
import mon_calc.ds.enumeration.EAspectFlag;
import mon_calc.aspect.core.AAspect;
import mon_calc.ds.EPriority;
import mon_calc.tool.IntTool;
import mon_calc.entity.Mon;
import animix.event.MoveContext;


class Damage {

	var _eType :Null<EDamageElement>;
	var _eCategory :EDamageType;
	var _iPower :Int;

	public function new(
		iPower :Int,
		eType :Null<EDamageElement>,
		eCategory :EDamageType,
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

	public function process( oContext :Context, oEvent :MoveContext ) {

		if( oEvent.defender == null ) throw '!!!';

		var oCalcContext = oContext.process.trigger( 
			OnDamageCalc,
			_createCalcContext( oContext, oEvent.side_att, oEvent.attacker, oEvent.defender)
		);
		
		// Case : attack failed (e.g. type immunity)
		if( oCalcContext.factor == null ) return;

		var oDamageContext = oContext.process.trigger( 
			OnDamage,
			{
				source: oEvent.attacker,
				target: oEvent.defender,
				source_effect: this,
				damage: _calcDamage( oContext, oCalcContext ),
				prevent_default: false,
			}
		);
		
		if( oDamageContext.damage == 0 ) {
			//oContext.process.log('attack has no effect');
			return;
		}
		if( oDamageContext.prevent_default ) {
			//oContext.process.log('attack miss');
			return;
		}

		oDamageContext.target.damage( oDamageContext.damage );

		// oContext.process.log( ' damaging ' + oContext.target.getLabel() + ' ' 
		// 	+ oDamageContext.target.getHealth() 
		// 	+ ' (-' + oContext.damage + ')' 
		// );

		
	}


//_____________________________________________________________________________

	public function damage( oContext :DamageCalcContext ) {

	}


//_____________________________________________________________________________

	private function _createCalcContext(
		oContext :Context,
		bSide :Bool,
		oSource :Ani,
		oTarget :Ani
	) :DamageCalcContext {
		var fFactor = 1.0;
		
		if (_eType != null ) {
			fFactor *= getAffinityFactor(
				oTarget.geElement0(), _eType
			);
			if( oTarget.getElement1() != null ) {
				fFactor *= getAffinityFactor(
					oTarget.geElement0(), _eType
				);
			}
		}
		
		var mStatAtt = oSource.getStatEffectiveMap();
		var mStatDef = oTarget.getStatEffectiveMap();
		
		return {
			type: OnDamageCalc,
			crit_chance: 1/16,
			factor: fFactor,
			power: getPower(),

			damage: this,

			att_mon: oSource,
			att_stat: cast ( _eCategory == EDamageType.Physic  ?
				mStatAtt.get(Percing) : mStatAtt.get(Magic)),

			def_mon: oTarget,
			def_stat: cast ( _eCategory == EDamageType.Physic  ?
				mStatDef.get(Defence) : mStatDef.get(Resist)),
			att_side: bSide,
		};
	}

	private function _calcDamage( oContext :Context, oEvent :DamageCalcContext ) :Int {
		// https://bulbapedia.bulbagarden.net/wiki/Damage


		var fStabFactor = getStabFactor( oEvent.att_mon );
		var fCriticFactor = oContext.process.getChance( oEvent.crit_chance ) ? 
			1.5 : 1;//TODO 2 if crtic
		var fTargetFactor = 1;//TODO 
		var iLevel = 50;
		// TODO : hook 
		var fBaseDamage = Math.floor(
				( 
					( IntTool.div( iLevel * 2, 5) + 2 )
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

	private function getStabFactor( oAttacker :Ani ) :Float {
		if( ! oAttacker.hasElement( _eType ) )
			return 1;
		return 1.5;
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
