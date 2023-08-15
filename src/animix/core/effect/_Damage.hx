package animix.core.effect;

import mon_calc.entity.EDamageCategory;
import animix.ds.EDamageElement;
import mon_calc.ds.ThisContext;
import mon_calc.core.IProcess;

class Damage implements IProcess {
    
	var _eType :Null<EHitType>;
	var _eCategory :EDamageCategory;
	var _iPower :Int;

	public function new(
		iPower :Int,
		eType :Null<EDamageElement>,
		eCategory :EDamageCategory,
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
	public function getFlagAr() { return []; }

	public function process( oContext :ThisContext ) {

		var oCalcContext = oContext.processor.calcDamage( 
			_createCalcContext( oContext, oEvent )
		);
		
		// Case : attack failed (e.g. type immunity)
		if( oCalcContext.factor == null ) return;

		oContext.processor.damage({
			type: OnDamagePre,
			mon_att: oContext.mon,
			target: _getTarget( oContext ),
			source: this,
			damage: _calcDamage( oContext, oCalcContext ),
			prevent_default: false,
		});
	}

	private function _createCalcContext( 
		oContext :ThisContext, 
		oEvent :MoveContext 
	) :DamageCalcContext {
		var fFactor = oContext.processor.getAffinityFactor(
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

	private function getStabFactor( oMonAtt :Mon ) :Float {
		if( ! oMonAtt.hasHitType( _eType ) )
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

    private function _getTarget( oContext :ThisContext ) {
		return oContext.battle.getCurrentMon(! oContext.side); // TODO 
	}

    
}