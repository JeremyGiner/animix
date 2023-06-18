package mon_calc.validator;

import mon_calc.battle_aspect.status.SleepStatus;
import mon_calc.entity.Mon;
import mon_calc.tool.IValidator;

class SelfSleepVali implements IValidator<Mon> {

	public function new() {}
	public function validate( oMon : Mon ) {
		return oMon.hasAspectByClass(SleepStatus);
	}
}