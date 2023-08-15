package animix_client_js.macro;

#if macro
import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.macro.Type;
#end

class TemplateMacro {

	public static macro function getTemplate( ):ExprOf<String> {
		// return as expression
		return macro $v{''};
	}
	
}
