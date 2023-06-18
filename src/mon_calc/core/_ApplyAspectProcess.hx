package mon_calc.core;

import mon_calc.ds.EPriority;
import mon_calc.ds.ThisContext;
import mon_calc.aspect.core.IAspectBearer;
import mon_calc.entity.Mon;
import mon_calc.battle_aspect.IAspect;

class ApplyAspectProcess implements IProcess {


	var _oAspect :IAspect;
	var _oTarget :IAspectBearer;
	var _oSourceMon :Mon;
	var _oSource :IAspect;

	public function new( oTarget :IAspectBearer, oAspect :IAspect, oSourceMon :Mon, oSource :IAspect)  {
		_oAspect = oAspect;
		_oTarget = oTarget;
		_oSourceMon = oSourceMon;
		_oSource = oSource;
	}

	public function getLabel() { return Type.getClassName( Type.getClass( this ) ); }
	public function getPriority() :String { return cast EPriority.Normal; }
	public function getAspect() :IAspect { return _oAspect; }
	public function getSourceMon() :Mon { return _oSourceMon; }
	public function getTarget() :IAspectBearer { return _oTarget; }

	public function validate( oContext :ThisContext ) {
		return true;
	}

	public function process( oContext :ThisContext ) {
		oContext.processor.addAspect( _oTarget, _oAspect,  _oSourceMon, _oSource ); // TODO : retire processor addAspect
		// TODO : oContext.processor.log(oMon.getLabel() + ' is poisonned.');
	}
}