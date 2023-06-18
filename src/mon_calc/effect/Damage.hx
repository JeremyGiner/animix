package mon_calc.effect;

import mon_calc.ds.event.DamageCalcContext;
import mon_calc.ds.ThisContext;
import mon_calc.ds.enumeration.EAspectFlag;
import mon_calc.aspect.core.AAspect;
import mon_calc.ds.EPriority;
import mon_calc.entity.EDamageCategory;
import mon_calc.entity.EHitType;
import mon_calc.tool.IntTool;
import mon_calc.entity.Mon;
import mon_calc.ds.MoveContext;


class Damage extends AAspect {

	var _eType :Null<EHitType>;
	var _eCategory :EDamageCategory;
	var _iPower :Int;

	public function new(
		iPower :Int,
		eType :Null<EHitType>,
		eCategory :EDamageCategory,
		aFlag :Array<EAspectFlag> = null
	) {
		super([OnAttack],[Dealing],aFlag);
		_eType = eType;
		_eCategory = eCategory;
		_iPower = iPower;
	}

	override public function getPriority() :String { return cast EPriority.Normal; }

	public function getHitType() { return _eType; }
	public function getCategory() { return _eCategory; }
	public function getDamageCategory() { return _eCategory; }
	public function getPower() { return _iPower; }
	public function getFlagAr() { return _aFlag; }

	override public function onAttack( oContext :ThisContext, oEvent :MoveContext ) {

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
			att_stat: ( _eCategory == EDamageCategory.Physic ) ?
				mStatAtt.get(Att) : mStatAtt.get(Mag),

			def_mon: oEvent.mon_def,
			def_stat: ( _eCategory == EDamageCategory.Physic ) ?
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

	private function _getTarget( oEvent :MoveContext ) {
		return oEvent.mon_def; // TODO 
	}



	
	
}
