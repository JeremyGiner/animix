package mon_calc.core.process;

import mon_calc.ds.ThisContext;
typedef Callback = ThisContext->IProcessResult;
class CallbackProcess implements IProcess {
	
	var _fn :Callback;

	public function new(fn :Callback) {
		_fn = fn;
	}

	public function getLabel() :String {return 'CallbackProcess';}
	public function process( oContext :ThisContext ) :IProcessResult {
		return _fn(oContext);
	}
}