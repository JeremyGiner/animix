package mon_calc.ds;

enum EEventFilter {

	Self;
	Ally; Foe;
	Dealing;

	AllyReceiving;
	Receiving;

	TargetFoe;
	TargetOwner;
	
	WeatherRain;
	WeatherSunny;
	//Weather...;
	TerrainElectric;
	//Terrain...;
	
	TargetHasStatus;
	TargetSleepable;
	TargetPoisonable;
	//Target...;
	TargetGrounded;
	TargetAirBorn;
	TargetUnderground;
	Damage;
	DamagePhy;
	DamageMag;
	DamageTypeNormal;
	DamageTypeDark;
	//DamageType...;
	
}