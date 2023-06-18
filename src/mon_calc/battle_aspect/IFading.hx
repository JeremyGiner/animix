package mon_calc.battle_aspect;

interface IFading {
	public function hasFade() :Bool;
	public function onEndTurn() :Void;
}
