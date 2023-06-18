package mon_calc.core.process;

import mon_calc.ds.PairAspectContext;
import mon_calc.ds.event.EventContext;
import mon_calc.ds.ThisContext;

class TriggerProcess implements IProcess {

	var _oEvent :EventContext;

	var _aExecutionStack :Array<PairAspectContext>; // FIFO

	public function new( aExecutionStack :Array<PairAspectContext> ) {
		_aExecutionStack = aExecutionStack;
	}

	public function process( oContext:ThisContext ):IProcessResult {

		var oPair = _aExecutionStack.pop();
		if( oPair == null ) return ProcessResult.DONE;

		// TODO : handleb "turnover"
		return oPair.aspect.process( oPair.context );
	}
}