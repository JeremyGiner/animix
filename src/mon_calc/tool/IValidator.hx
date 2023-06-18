package mon_calc.tool;

interface IValidator<C> {
    public function validate( o :C ) :Bool;
}