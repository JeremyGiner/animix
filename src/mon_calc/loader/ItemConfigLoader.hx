package mon_calc.loader;

import mon_calc.aspect.endturn.Sustain;
import mon_calc.entity.Item;
import haxe.ds.StringMap;

class ItemConfigLoader {
	public function new() {
		
	}
	public function load() :StringMap<Item> {
		
		return [
			'LEFTOVERS' => new Item('LEFTOVERS','Leftovers',[new Sustain()])
		];
	}
}