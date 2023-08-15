package animix_client_js.client.form;

import haxe.ds.StringMap;

class InputRange extends AInput {

	var _min :Int;
	var _max :Int;

	public function new(
		label :String,
		name :String,
		min :Int = 0,
		max :Int = 100,
		step :Int = 1,
		attr :StringMap<String> = null
	) {
		attr = attr != null ? attr : new StringMap();
		attr.set('type', 'range');
		attr.set('min', min+'');
		attr.set('max', max+'');
		super(label, name, attr);
	}

    public function getValueInt() :Int {
		return Std.parseInt(getValue());
	}
}