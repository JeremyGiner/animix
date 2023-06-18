package mon_calc.aspect.flag;

import mon_calc.battle_aspect.IAspect;

/**
 * Prevent switch from opponent
 */
class StandFirm implements IAspect {
	public function getPriority() { return ''; }
}

/*
The most basic can be a simple strategic decision to battle using another Pokémon in lieu of using a move, 
recalling the active one to switch in another; 
Any Pokémon that faints must also be recalled, and the Trainer can switch in another Pokémon to continue the battle if possible. In a wild Pokémon battle, after a Pokémon faints, its Trainer may attempt to flee instead of continuing the battle, but if it fails, they must switch in a new Pokémon instead. A handful of moves also return the user to the party and allow the Trainer to send in a different Pokémon. The held items Eject Button and Eject Pack also makes the holder switch out in certain situations.

Dragon Tail, Circle Thrown, Roar, and Whirlwind force, Red Card
- overrided by : Suction Cups, Ingrain, or has Substitute

Pokémon with the Abilities Wimp Out and Emergency Exit switch out in Trainer battles 
when their HP falls below half, forcing their Trainers to select another Pokémon to send out. 


There are also a variety of circumstances that may trap a Pokémon, 
preventing it from being reca
lled from battle. 
The moves Anchor Shot, Block, Mean Look, Shadow Hold, Spider Web, Spirit Shackle, and Thousand Waves 
prevent opposing Pokémon from leaving battle, and Fairy Lock does the same for the next turn only. 
The Abilities Arena Trap, Magnet Pull, and Shadow Tag also prevent opposing Pokémon from leaving battle. 
A trapped Pokémon can bypass these restrictions with a Shed Shell, by using Baton Pass, U-turn, or Volt Switch, 
or if it is hit by Circle Throw, Dragon Tail, Roar, or Whirlwind. 
Starting in Generation VI, Ghost-type Pokémon are also immune to these trapping effects. 
A Pokémon that has used Ingrain is similarly prevented from leaving the battle under most circumstances and can only be recalled after an opponent is defeated or by using Baton Pass, U-turn, or Volt Switch.

Manually withdrawing a Pokémon happens before all moves, except Pursuit if it is targeting the Pokémon that is switching out. 
In Generation III and earlier, players always switch before NPCs do, and "player 1" always switches before "player 2" does in link battles.

When a Pokémon is withdrawn, all of its stat changes, type changes, Ability changes, moves learned via Mimic, 
and volatile status conditions are removed. 
Additionally, Pokémon with Natural Cure heal their non-volatile status conditions, 
and Pokémon with Regenerator heal their HP by up to 1/3 of its maximum. 
The replacement Pokémon can be affected by Spikes, Stealth Rock, Toxic Spikes, or Sticky Web.

Experience is fundamentally evenly divided among Pokémon that participated in a battle (and are not fainted) 
against an opponent that has not switched out, but many factors can affect this.

In Single Battles against NPC Trainers (excluding Battle Tower Trainers), 
if the Battle Style is set as "Shift" ("Switch" in Generation VI), 
then after defeating one of the opponent's Pokémon, the player is notified what the opponent's next 
Pokémon will be and given the option to recall their own Pokémon before the next turn. 

*/