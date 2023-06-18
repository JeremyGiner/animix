package mon_calc.core.process;

import mon_calc.action.IAction;

class ProcessResult implements IProcessResult {
	var _bHasFinished :Bool;
	var _aAction :Null<Array<IAction>> = null;
	public function new( 
		bHasFinished :Bool, 
		aAction :Null<Array<IAction>> = null 
	) {
		_bHasFinished = bHasFinished;
		_aAction = aAction;
	}
	
	static public var DONE = new ProcessResult(true);
	static public var TO_BE_CONTINUED = new ProcessResult(false);

	public function hasFinished() :Bool {
		return _bHasFinished;
	}
	public function getActionAr() :Null<Array<IAction>> {
		return _aAction;
	}
}