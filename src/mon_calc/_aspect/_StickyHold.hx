package mon_calc.aspect;


class StickyHold extends AAspect {
	public function new() {
		super([OnItemRemove],[Self]);
	}
	override public function onItemRemove( oContext :ItemRemoveContext ) {
		// TODO : prevent switch item
		oContext.prevent_default = true;
	}
}