package animix.event;

import animix.ds.EEventType;
import animix.entity.Move;
import animix.ds.EStat;
import animix.entity.Ani;

typedef MoveCalcContext = {
	var side :Bool;
    var mon :Ani;
    var move_origin :Move;
    var move :Move;
}