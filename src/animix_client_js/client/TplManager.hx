package animix_client_js.client;

import haxe.Resource;
import animix_client_js.Template;

class TplManager {
	static public var form = {
		input_base: new Template(
			Resource.getString('form.input_base')
		),
		input_aspect: new Template(
			Resource.getString('form.input_aspect')
		),
	};

	public function new() {
	}

	static var _uid = 0;
	@:keep static public function uid() {
		return _uid++;
	}
}