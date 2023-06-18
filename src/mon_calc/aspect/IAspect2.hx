package mon_calc.aspect;


interface IAspect2 {
	public function getEvent() :Array<EEvent>
	public function validate( o :Event ) :Bool;
	public function process( o :Event ) :Void;
	public function hasFlag( e :EAspectFlag ) :Bool;
}



class Effect2 implements IProcedure {
	// TODO : handle fade 
}

enum EEventFilter {

	TargetFoe;
	TargetOwner;
	
	

	WeatherRain;
	Weather...;
	TerrainElectric;
	Terrain...;
	
	TargetHasStatus;
	TargetSleepable;
	TargetPoisonable;
	Target...;
	TargetGrounded;
	TargetAirBorn;
	TargetUnderground;
	Damage;
	DamagePhy;
	DamageMag;
	DamageTypeNormal;
	DamageTypeDark;
	DamageType...;
	
}

interface IOnAspectExecute {
	public function OnAspectExecute( o :IAspect ) :Void;
}

typeddef AspectExecuteContext {
	var owner :IAspectBearer;
	var aspect :IAspect;
}

private function _parseAspect( oData :Dynamic ) {
	switch( oData ) {
		case 'Adaptability': return new Adaptability();
		case 'LiquidOoze': return new LiquidOoze();
		case 'PreventCrit': return new PreventCrit();
		case 'Levitate': return new Levitate();
		case 'Moxie': return new Moxie();
		case 'NaturalCure': return new NaturalCure();
		case 'Sturdy': return new Sturdy();
		case 'SereneGrace': return new SereneGrace();
		case 'SuperLuck': return new SuperLuck();
		case 'Steadfast': return new Steadfast();
		case 'StickyHold': return new StickyHold();
		case 'WeakArmor': return new WeakArmor();
		case 'WonderGuard': return new WonderGuard();
		
		case 'WeatherApplier': return new WeatherApplier( 
			_parseClass( untpyed oData.weather ) );
		case 'TerrainApplier': return new TerrainApplier( 
			_parseClass( untpyed oData.terrain ) );
		case 'InPinchBoost': return new InPinchBoost( 
			_parseHitType( untyped oData.type ) );
		case 'WeatherSpeed': return new WeatherSpeed( 
			_parseClass( untyped oData.weather ) );
		case 'SwitchInEffect': return new SwitchInEffect( 
			_parseEffectAr( untyped oData.child ) );
	}
	throw 'Invalid ';
}

private function _parseClass( s :String ) {
	switch( s ) {
		case 'GrassyTerrain': return GrassyTerrain;
		case 'MistyTerrain': return MistyTerrain;
		case 'PsychicTerrain': return PsychicTerrain;
		case 'ElectricTerrain': return ElectricTerrain;
		case 'Sunny': return Sunny;
		case 'Hail': return Hail;
		case 'Sandstorm': return Sandstorm;
		case 'Rain': return Rain;
	}
}
