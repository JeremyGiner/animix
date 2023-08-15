package animix_client_js;

import haxe.Template in TemplateBase;

class Template extends TemplateBase {

    // TODO : why in js does not use super contructor
    
    // Force js to use parent contructor
    public function new(s :String) {
        super(s);
    }

    override function resolve(v:String):Dynamic {
        if (v == "__parent__")
			return stack.first();
        return super.resolve( v );
	}
}