package mon_calc.tool;

class IntTool {

	static public function div( a :Int, b :Int ) {
		return Math.floor( a / b );
	}

	static public function clamp( i :Int, iMin :Int, iMax :Int ) {
		if( i < iMin ) return iMin;
		if( i > iMax ) return iMax;
		return i;
	}

	static public function max( a :Int, b :Int ) {
		return ( a < b ) ? b : a;
	}
}