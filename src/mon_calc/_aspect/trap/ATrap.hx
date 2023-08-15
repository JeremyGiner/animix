package mon_calc.aspect.trap;
import mon_calc.aspect.trap.ATrap;


class ATrap implements IOnSwichIn {
	
	public function getPriority() :String { return cast EPriority.Normal; }
	public function onSwichIn( oBattle :Battle, oMon :Mon ) { 
		throw 'override me';
	}
}