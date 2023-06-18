package mon_calc.tool;

class ArrayTool {
	static public function unique<T>(array:Array<T>) {
        var l = [];
        for (v in array) {
         	if (l.indexOf(v) == -1) { // array has not v
            	l.push(v);
            }
         }
        return l;
    }
}