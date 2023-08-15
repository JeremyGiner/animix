package mon_calc.aspect.ability;

import mon_calc.battle_aspect.StatModifier;
import mon_calc.ds.ThisContext;
import mon_calc.ds.event.SwitchOutContext;
import mon_calc.aspect.core.AAspect;


class Moxie extends AAspect {

	public function new() {
		super([OnSwitchOut],[Foe],[]);
	}

	override function onSwitchOut(oContext:ThisContext, oEvent:SwitchOutContext) {
	
		// On Foe dying
		if( oEvent.mon.getHealth() > 0 ) return;
		
		oContext.processor.addAspect( 
			oContext.owner, 
			new StatModifier([Att => 1]),  
			oContext.mon,
			this
		);
	}
}