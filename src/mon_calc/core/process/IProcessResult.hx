package mon_calc.core.process;

import mon_calc.action.IAction;

interface IProcessResult {
	public function hasFinished() :Bool;
	public function getActionAr() :Array<IAction>;
}