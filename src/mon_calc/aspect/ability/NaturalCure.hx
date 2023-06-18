package mon_calc.aspect.ability;

import mon_calc.battle_aspect.status.AMainStatus;
import mon_calc.ds.ThisContext;
import mon_calc.ds.event.SwitchOutContext;
import mon_calc.aspect.core.AAspect;

class NaturalCure extends AAspect {

    public function new() {
        super([OnSwitchOut],[Self],[]);
    }

    override function onSwitchOut( oContext:ThisContext, oEvent:SwitchOutContext ) {
        // Remove Status
        var oStatus = oContext.owner.getAspectByClass(AMainStatus);
        if( oStatus == null ) return;
        oContext.processor.removeAspect( oContext.owner, oStatus, this );
	}
}