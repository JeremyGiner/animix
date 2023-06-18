package mon_calc.aspect;


class Hustle
extends AAspect2
{
	public function new() {
		super([OnStatCalc],[TargetOwner]);
	}
	override public function onStatCalc( 
		oBattle :Battle, 
		oOwner :IAspectBearer, 
		m :Map<EStat,Int> 
	) {
		m.set(Att,Math.floor( m.get(Att) * 1.5 ) );
		m.set(Accuracy,m.get(Accuracy) - 0.2 ); // TODO
		return m;
	}
}