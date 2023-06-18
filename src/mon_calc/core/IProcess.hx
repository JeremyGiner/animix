package mon_calc.core;

import mon_calc.core.process.IProcessResult;
import mon_calc.ds.ThisContext;

interface IProcess {
	
	public function process( oContext :ThisContext ) :IProcessResult;
	
}