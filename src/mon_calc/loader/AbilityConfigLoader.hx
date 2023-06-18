package mon_calc.loader;

import haxe.Resource;
import mon_calc.aspect.ability.SwitchInApplier;
import mon_calc.aspect.ability.ToughClaws;
import mon_calc.aspect.ability.ThickFat;
import mon_calc.aspect.RainDish;
import mon_calc.battle_aspect.weather.SandStorm;
import mon_calc.battle_aspect.weather.Hail;
import mon_calc.battle_aspect.weather.Rain;
import mon_calc.battle_aspect.weather.Sunny;
import mon_calc.aspect.WeatherSpeed;
import mon_calc.tool.EnumTool;
import mon_calc.aspect.InPinchBoost;
import mon_calc.aspect.ability.Steadfast;
import mon_calc.aspect.ability.Adaptability;
import mon_calc.aspect.ability.SuperLuck;
import mon_calc.aspect.ability.Levitate;
import mon_calc.aspect.ability.WonderGuard;
import mon_calc.aspect.ability.MainStatusBoost;
import mon_calc.aspect.ability.SolarPower;
import mon_calc.aspect.ability.PreventCrit;
import mon_calc.aspect.Hydration;
import mon_calc.aspect.ability.Moxie;
import mon_calc.aspect.ability.NaturalCure;
import mon_calc.battle_aspect.IAspect;
import mon_calc.tool.StringTool;
import haxe.Json;
import mon_calc.entity.Ability;
import haxe.ds.StringMap;

typedef AbilityData = {
	var effect :Dynamic;
	var name :String;
};

class AbilityConfigLoader {
	public function new() {
		
	}
	public function load() :StringMap<Ability> {

		var aAbilityConfig :Array<AbilityData> = cast Json.parse(
			Resource.getString('config_ability')
		);

		var m = new StringMap<Ability>();
		for( oData in aAbilityConfig ) {
			if( Reflect.hasField(oData,'comment')) continue;
			try{
				m.set( 
					StringTool.slugify( oData.name ), 
					new Ability(oData.name,parseEffectAr( oData.effect )) 
				);
				//trace(StringTool.slugify( oData.name ));
			} catch( e ) {
				//trace(oData);
				//trace(oData.name+' failed');
			}
		}

		return m;
	}


	public function parseEffectAr( oData :Dynamic ) :Array<IAspect> {

		if( Std.isOfType( oData, Array ) ) {
			return oData.map(function( item ) { return parseEffect( item ); });
		}
		return [parseEffect( oData )];
	}

	public function parseEffect( oData :Dynamic ) :IAspect {

		if( Reflect.hasField(oData,'class') ) {
			return parseClassEffect( oData );
		}
		throw 'cannot parse ' + Json.stringify( oData );
	}

	public function parseClassEffect( oData :Dynamic ) :IAspect {
		switch( cast Reflect.field( oData, 'class' ) ) {
			case 'NaturalCure': return new NaturalCure();
			case 'Moxie': return new Moxie();
			case 'Hydration': return new Hydration();
			case 'InPinchBoost': return new InPinchBoost( EnumTool.getHitTypeFromString( untyped oData.type ) );
			//case 'StickyHold': return new StickyHold();
			case 'PreventCrit': return new PreventCrit();
			case 'SolarPower': return new SolarPower();
			case 'MainStatusBoost': return new MainStatusBoost();
			case 'WonderGuard': return new WonderGuard();
			case 'Levitate': return new Levitate();
			case 'SereneGrace': return new Levitate();
			case 'SuperLuck': return new SuperLuck();
			case 'Adaptability': return new Adaptability();
			case 'Steadfast': return new Steadfast();
			case 'WeatherSpeed': return new WeatherSpeed( _getClass( untyped oData.weather ) );
			case 'RainDish': return new RainDish();
			case 'ThickFat': return new ThickFat();
			case 'ToughClaws': return new ToughClaws();
			case 'SwitchInApplier': return new SwitchInApplier( 
				_getClass( untyped oData.aspect ), Battle
			);
		}
		throw '!!';
	}

	public function _getClass( s :String ) :Class<IAspect> {
		switch( s ) {
			case 'Sunny': return Sunny;
			case 'Rain': return Rain;
			case 'Hail': return Hail;
			case 'Sandstorm': return SandStorm;

		}
		throw '!!!';
	}

}