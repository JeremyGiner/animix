package mon_calc.core;


interface IAction<CBattle> {
	public function getSide() :Bool;
	public function validate( oBattle :CBattle ) :Bool;
	public function process( oBattle :CBattle ) :Void;
}