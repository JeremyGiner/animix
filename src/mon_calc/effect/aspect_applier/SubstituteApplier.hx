package mon_calc.effect.aspect_applier;

import mon_calc.ds.ThisContext;
import mon_calc.aspect.core.AAspect;
import mon_calc.aspect.Substitute;
import mon_calc.ds.EPriority;
import mon_calc.entity.Mon;
import mon_calc.ds.MoveContext;
	
class SubstituteApplier extends AAspect {

	public function new() { 
		super([OnAttack],[Dealing],[]);
	}

	override function onAttack( oContext :ThisContext, oEvent :MoveContext ) {
		var oMon = oEvent.mon_att;
		var iCost = _getCost( oMon );
		
		if( 
			oMon.hasAspectByClass( Substitute ) 
			|| oMon.getHealth() <= iCost
		) {
			oContext.processor.log('TOTO too weak to substitute');
			return;
		}
		
		oMon.damage( iCost ); 
		oMon.addAspect( new Substitute( iCost + 1  ) );
		oContext.processor.log('TOTO create a substitute');
	}

	private function _getCost( oMon :Mon ) :Int {
		return Math.floor( oMon.getMaxHealth() * 1/4 );
	}
}

/** TODO



If a Pokémon breaks a substitute with Hyper Beam, 
it will not need to recharge. 
If a Pokémon breaks a substitute with Explosion or Selfdestruct, it will not faint, although its sprite will still disappear until it switches out (or uses Substitute). If a Pokémon breaks a substitute with a recoil move, it will not take any recoil damage. If a Pokémon breaks a substitute with Pay Day, that use of Pay Day will not count toward the money its Trainer picks up at the end of the battle. If a Pokémon attacks a substitute with a multi-strike move, the hits will automatically end if the substitute breaks.


In Generations I and II, the substitute retains its user's color palette. (For instance, a blue Pokémon would create a blue substitute.)
Generation II

In general, the fixed effects from Stadium in Generation I are retained. For example:

	If the user's current HP is equal to or lower than 25% (rounded down) of its maximum HP, it will be too weak to create a substitute.
	A Pokémon behind a substitute cannot be inflicted with any status condition or caused to flinch by an opponent's move.
	Super Fang affects the substitute rather than the Pokémon behind it.
	Rage works as normal.
	Draining moves always miss if used on a Pokémon behind a substitute.
	If a Pokémon breaks a substitute with Explosion or Selfdestruct, it will faint as usual.

Mechanics changed between Stadium and Generation II include:

	The substitute's HP is now exactly equal to the HP lost to create the substitute, instead of being 1 + the HP lost.
	Leech Seed now fails if the target is behind a substitute.
	If a Pokémon behind a substitute hurts itself in confusion, it takes the damage itself.
	Bide can be successfully used by a Pokémon behind a substitute, but damage dealt to a substitute is not considered for the damage Bide deals.
	Because recoil damage is calculated from how much HP the target has actually lost, if a Pokémon hits a substitute with a recoil move, that attacker will only take 1 HP of recoil damage. (Jump Kick and Hi Jump Kick crash damage is calculated normally.) Breaking a substitute with a recoil move no longer prevents recoil damage.
	A multi-strike move can now continue hitting even after a substitute has been broken, then dealing damage directly to the targeted Pokémon. (Twineedle can poison a target with the second strike if the first strike broke the substitute.)
	Pay Day now works as normal.
	False Swipe does not apply its additional effect if it hits a substitute.

Mechanics newly introduced in Generation II include:

	A substitute can be passed by Baton Pass, and it will keep whatever HP it has remaining.
	The moves Counter, Mirror Coat, Protect, Detect, and Endure will fail if used by a Pokémon behind a substitute.
	The moves Lock-On, Mind Reader, Nightmare, Ghost-type Curse, and Sketch cannot affect a Pokémon behind a substitute. (If a Pokémon affected by one of these moves later gains a substitute, their effects remain.)
	A substitute takes the damage from Future Sight.
	A substitute takes the damage from Pursuit as the user switches out.
	Binding moves will not trap the target if it is behind a substitute. In addition, creating a substitute will cause the user to escape a binding move.
	If a Pokémon behind a substitute is targeted by Swagger, its Attack is sharply increased as normal, but it does not become confused.
	Thief cannot steal an item from a Pokémon behind a substitute.
	Pain Split fails if the target is behind a substitute.

Generation III

The following effects are carried over/expanded from Generation II:

	A Pokémon behind a substitute cannot have its stat stages lowered by an opponent's Intimidate.
	A Pokémon behind a substitute cannot have its item stolen by Covet or knocked off by Knock Off. Trick fails if its target is behind a substitute.
	A substitute takes the damage from Doom Desire.
	Yawn is blocked by the substitute, but if a Pokémon behind a substitute is already drowsy due to Yawn it can still fall asleep.

The following effects are changed between Generations II and III:

	Rage's effect will now no longer activate if its user's substitute is hit.
	Swagger and Flatter will now fail if used on a Pokémon behind a substitute.
	Pay Day now does not cause its Trainer to gain money if it hits a substitute.
	Protect, Detect, and Endure now behave as normal.
	Damaging draining moves (except Dream Eater) can now hit a substitute as normal, and the user of the move will gain HP depending on the HP the substitute lost. (Leech Seed is still blocked by the substitute.)
	Recoil moves now inflict recoil damage to the user depending on the damage dealt to the substitute.
	Trapping moves are now blocked by the substitute.
	Mimic is now blocked by the substitute.

The following effects are newly introduced in Generation III:

	Shedinja, having a maximum of only 1 HP, cannot make a substitute.
	Substitute can be stolen by Snatch.
	SmellingSalt will not have any of its additional effects applied if it hits a substitute, even if the Pokémon behind it is paralyzed.

Generation IV

The following effects are carried over/expanded from Generation III:

	A Pokémon behind a substitute cannot have its item eaten by Pluck or Bug Bite. Switcheroo fails if its target is behind a substitute.
	Like Counter and Mirror Coat, Metal Burst also does not count damage taken by its user's substitute.
	Similar to SmellingSalt, Wake-Up Slap will not have any of its additional effects applied if it hits a substitute, even if the Pokémon behind it is asleep.

The following effects changed between Generations III and IV:

	Self-confusing Berries (such as the Figy Berry) no longer confuse Pokémon behind a substitute.
	Tickle will now fail if used on a Pokémon behind a substitute.

The following effects are newly introduced in Generation IV:

	The Enigma Berry will not activate if the substitute takes the move, nor will damage-reducing Berries (such as the Occa Berry).
	If an opponent's U-turn breaks the user's substitute, and the opponent then switches in a Pokémon with Intimidate, the substitute will not fade until after it has successfully blocked the new Intimidate.
	If a Pokémon behind a substitute uses Baton Pass, the Pokémon switched in cannot be poisoned by Toxic Spikes, but if it is a grounded Poison-type Pokémon it will still remove the Toxic Spikes.
	A Pokémon behind a substitute is unaffected by the effects of items thrown by Fling if the substitute takes the move.
	An opponent's Defog will not lower the evasiveness of a Pokémon behind a substitute, but it will still remove fog as well as team effects (Reflect, Mist, etc.) and entry hazards on the target's side of the field.
	A substitute blocks Copycat, Embargo, Gastro Acid, Heal Block, Psycho Shift, and Worry Seed. A substitute blocks Acupressure regardless of whether it was used by an ally or the user itself.

Generation V

A Pokémon behind a substitute cannot have its item destroyed by Incinerate or be given an item by Bestow. The Ability Pickpocket and the Item Drop from Wonder Launcher can steal or remove a Pokémon's held item, respectively.

If Smack Down, Clear Smog, Circle Throw, or Dragon Tail target a substitute, their secondary effects will not trigger. The move Sky Drop will fail if the target is behind a substitute.

Acupressure can now successfully be used by a Pokémon behind a substitute on itself, but it will still fail if it targets an ally behind a substitute.

Substitute now blocks Transform and Imposter.

Another Pokémon's Dream Eater can now affect a Pokémon's substitute and acts 
the same way as other damaging draining moves.

In Black 2 and White 2 only, due to a glitch, if a Pokémon behind a substitute faints due to Rough Skin or a held Rocky Helmet, the defending Pokémon will appear to be behind a substitute, but will act as normal.
By TrainerOfDistinction
This video is not available on Bulbapedia; instead, you can watch the video on YouTube here.


Generations VI and VII

Substitute no longer blocks sound-based moves (such as Metal Sound) 
or any moves used by Pokémon with the Ability Infiltrator, 
except Transform and Sky Drop. 

The moves Hyperspace Hole, Hyperspace Fury, Play Nice, and Spectral Thief can also bypass a substitute. Aromatherapy can still heal the user's status conditions if it is behind a substitute, but will now fail to affect an ally behind a substitute. Substitute will prevent Knock Off from discarding a removable held item, however Knock Off's power will still be increased.

If powered up by a Normalium Z into Z-Substitute, all of the user's lowered stats are reset. 

**/