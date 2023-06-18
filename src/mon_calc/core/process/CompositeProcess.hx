package mon_calc.core.process;

import mon_calc.ds.PairAspectContext;
import mon_calc.ds.ThisContext;

class CompositeProcess implements IProcess {

	var _lExecutionStack :List<IProcess>; // FIFO

	public function new( lExecutionStack :List<IProcess> ) {
		_lExecutionStack = null;
	}

	public function process( oContext :ThisContext ) :IProcessResult {

		var oChildProcess = _lExecutionStack.pop();
		var res = oChildProcess.process( oContext );
		if( ! res.hasFinished() )
			_lExecutionStack.push( oChildProcess );

		// Failsafe
		if( res.getActionAr() != null ) throw '!!!';

		if( !_lExecutionStack.isEmpty() ) 
			return ProcessResult.TO_BE_CONTINUED;

		_lExecutionStack = null;
		return ProcessResult.DONE;
	}

}