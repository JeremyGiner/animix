package mon_calc.ds.event;

import mon_calc.entity.Mon;
import mon_calc.entity.Move;
import mon_calc.ds.EEventType;

typedef MoveCalcContext = {
    var type :EEventType;

	var side :Bool;
    var mon :Mon;
    var move_origin :Move;
    var move :Move;
}