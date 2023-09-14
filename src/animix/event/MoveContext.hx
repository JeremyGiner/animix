package animix.event;

import animix.entity.Move;
import animix.ds.EStat;
import animix.entity.Ani;

typedef MoveContext = {
	var side_att :Bool;
	var attacker :Ani;
	var defender :Ani;
	var move :Move;
	var turnover :Bool;
}