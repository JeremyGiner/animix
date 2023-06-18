package mon_calc.core.process;

import mon_calc.ds.ThisContext;

class SwitchMonProcess implements IProcess {
	
	var _bSide :Bool;
	var _iIndex :Int;

	public function new(bSide :Bool, iIndex :Int) {
		_bSide = bSide;
		_iIndex = iIndex;
	}

	public function getLabel() :String {return 'SwitchMonProcess';}
	public function process( oContext :ThisContext ) :IProcessResult {
		
		var oBattle = oContext.battle;
		var oTeam = oBattle.getTeam( _bSide );
		var oCurrentMon = oBattle.getCurrentMon( _bSide );
		var oNextMon = oTeam.getMon( _iIndex );

		oBattle.stackProcess(new TriggerProcess({
			type: OnSwitchOut,
			side: bSide, mon: oCurrentMon,
		}));
		oBattle.stackProcess(new CallbackProcess(( oContext :ThisContext )-> {
			oCurrentMon.reset();
			oContext.battle.getBattleSlot(bSide).switchMon( oNextMon );
			oContext.processor.log( 
				oTeam.getLabel() 
				+ ' change to ' + oNextMon.getLabel() 
				+ ' ('+ oNextMon.getHealth()+')' );
			return null;
		}));

		oBattle.stackProcess(new TriggerProcess({
			type: OnSwitchIn,
			side: bSide, mon: oNextMon,
		}));

		
	}
}