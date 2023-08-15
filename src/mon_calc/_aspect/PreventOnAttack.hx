package mon_calc.aspect;


class PreventOnAttack 
implements IOnAttack
{
	var _oAspectClass :Class<IAspect>;

	public function new( oAspectClass :Class<IAspect> ) {
		_oAspectClass = oAspectClass;
	}
	public function getPriority() :String { return cast EPriority.prevent; }
	public function onAttack( oContext :MoveContext ) {
		oContext.aspect_stack = oContext.aspect_stack.filter(function( oAspect ) ) {
			// TODO : handle Composite ?
			return !Std.is( oAspect, _oAspectClass );
		});
	}
}