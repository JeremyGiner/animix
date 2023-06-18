package mon_calc.ds;

enum abstract EMovePriority(Int) {
	var HelpingHand = 5; 
	var Protect = 4; //  	Baneful Bunker, Detect, Endure, King's Shield, Magic Coat, Max Guard, Obstruct, Protect, Spiky Shield
	var FakeOut = 3; //  	Crafty Shield, Fake Out, Quick Guard, Wide Guard
	var AllySwitch = 2; //  	Ally Switch, Extreme Speed, Feint, First Impression, Follow Me, Rage Powder
	var QuickAttack = 1; //  Accelerock, Aqua Jet, Baby-Doll Eyes, Bullet Punch, Ice Shard, Mach Punch, Quick Attack, Shadow Sneak, Sucker Punch, Vacuum Wave, Water Shuriken
	var Normal = 0; 
	var VitalThrow = -1; 
	var FocusPunch = -3; // Focus Punch, Shell Trap
	var Revenge = -4; // Avalanche, Revenge
	var Counter = -5; //  	Counter, Mirror Coat
	var Teleport = -6; //  	Circle Throw, Dragon Tail, Roar, Whirlwind, Teleport
	var TrickRoom = -7; 
}