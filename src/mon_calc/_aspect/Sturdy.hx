package mon_calc.aspect;


class Sturdy 
implements IOnPostDamage
{
	public function new() {}
	public function getPriority() :String { return cast EPriority.postCalc; }
	public function onPostDamage( oContext :MonDamageContext ) {
	
		if( oContext.target.getHealth() >= 0 ) return;
		if( oContext.prev_health != oContext.target.getMaxHealth() ) return;
		
		oContext.target.setHealth(1);
	}
}