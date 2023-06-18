package mon_calc.action;

import mon_calc.entity.Battle;

interface IAction {
	public function getSide() :Bool;
	public function validate( oBattle :Battle ) :Bool;
	public function process( oBattle :Battle ) :Void;
}