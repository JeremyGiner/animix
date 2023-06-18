package mon_calc.aspect;


class PreventAspect
implements IOnAspectEntry
{
	var _oAspectClass :Class<IAspect>;

	public function new( oAspectClass :Class<IAspect> ) {
		_oAspectClass = oAspectClass;
	}
	public function getPriority() :String { return cast EPriority.prevent; }
	public function onAspectEntry( oContext :AspectEntryContext ) {
		if( ! Std.is(oContext.aspect,_oAspectClass) ) return;
		oContext.prevent_default = true;
	}
}