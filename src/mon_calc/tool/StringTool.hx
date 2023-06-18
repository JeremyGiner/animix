package mon_calc.tool;
using StringTools;

class StringTool {

	static public function ucfirst( string :String ) {
		return string.charAt(0).toUpperCase() + string.substr(1);
	}

	static public function slugify( s :String ) :String {
		return s.toUpperCase().replace( ' ', '_' );
	}
}