package mon_calc.aspect;


class SurgeSurfer
extends AAspect2
{
	public function new() {
		super([OnStatCalc],[TargetOwner, TerrainElectric]);
	}
	override public function onStatCalc( 
		oBattle :Battle, 
		oOwner :IAspectBearer, 
		m :Map<EStat,Int> 
	) {
		m.set(Speed,m.get(Speed) * 2);
		return m;
	}
}