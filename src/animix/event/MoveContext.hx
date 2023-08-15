package animix.event;

import animix.entity.Move;
import animix.ds.EStat;
import animix.entity.Ani;

typedef MoveContext = {
	var side_att :Bool;

	var attacker :Ani;
	var stat_att :Map<EStat,Int>;

	var defender :Ani;
	var stat_def :Map<EStat,Int>;

	var move :Move;

	var turnover :Bool;
}