package mon_calc.aspect;

import mon_calc.ds.event.AspectEntryContext;
import mon_calc.ds.ThisContext;
import mon_calc.aspect.core.AAspect;
import mon_calc.effect.Damage;
import mon_calc.battle_aspect.IMainStatus;
import mon_calc.tool.IntTool;
import mon_calc.ds.MonDamageContext;
import mon_calc.ds.EPriority;
import mon_calc.entity.Mon;
import mon_calc.battle_aspect.IAspect;


// TODO: 
// - Substitute no longer blocks sound-based moves (such as Metal Sound) or any moves used by Pokémon with the Ability Infiltrator, except Transform and Sky Drop
// - The moves Hyperspace Hole, Hyperspace Fury, Play Nice, and Spectral Thief can also bypass a substitute
// - prevent switch
// - prevent stat change
// - Substitute will prevent Knock Off from discarding a removable held item, however Knock Off's power will still be increased
// - A one-hit KO attack will always break a substitute if it hits
class Substitute extends AAspect {

	var _iHealth :Int;
	
	public function new( iHealth :Int ) {
		super([OnDamagePre,OnAspectEntryPre],[Receiving],[]);
		_iHealth = iHealth;
	}

	override function onDamagePre( oContext :ThisContext, oEvent :MonDamageContext ) {
		if( oEvent.attack_context == null ) return;
		if( !Std.isOfType( oEvent.source, Damage ) ) throw '!!!';

		// Unless sound base
		var oDamage = cast(oEvent.source,Damage);
		if( oDamage.hasFlag(SoundBase) ) return;

		// Reroute damage to this
		// TODO : They can hit and drain HP, but will not drain any HP if they break the substitute.
		//oContext.battle.filterProcessByClass(Damage,OnAttack);
		oEvent.prevent_default = true;
		_iHealth -= oEvent.damage;
		
		if( _iHealth <= 0 ) {
			oContext.processor.removeAspect( oContext.owner, this, this );
			oContext.processor.log('Substitute fade.');
		}
	}

	override function onAspectEntryPre( oContext:ThisContext, oEvent:AspectEntryContext ) {
		// TODO : While behind a substitute, its opponent's moves cannot lower its stat stages, 
		// poison it, freeze it, burn it, or cause it to flinch. 

		// TODO : A Pokémon behind a substitute can be inflicted with paralysis 
		// or sleep by status moves (such as Thunder Wave and Hypnosis), 
		// but not by damaging moves (such as Thunderbolt). 

		// TODO : Conversely, a Pokémon behind a substitute cannot be confused by status moves 
		// (such as Confuse Ray), but can be confused by damaging moves 
		// (such as Confusion) as long as they do not break the substitute. 
		// Even if a move breaks a substitute, it cannot inflict any effects 
		// it would not be able to inflict to a Pokémon behind a substitute.

		// TODO : Additionally, Substitute does not affect the opponent's Disable, 
		// Leech Seed, Super Fang, Transform, or binding moves; the user's Bide, Counter, or Rage; 
		// nor either Pokémon's Haze.
	}

	// TODO : If a substitute is created while the user is trapped by a binding move, 
	// the binding effect ends immediately
// TODO : The user still takes normal damage from weather and status effects while behind its substitute
	// TODO : does it trigger IOnDamage ?
}

/*
DONE:
The substitute always has the same type and stats as the Pokémon that created it currently has.


TODO:
If the user's maximum HP is 3 or less, it will not lose any HP when the substitute is made. 

If the substitute is hit by a one-hit KO move, it breaks. 
Other damage (except self-inflicted confusion damage), such as recoil damage or damage from status conditions, 
is not affected by a substitute.

While behind a substitute, its opponent's moves cannot lower its stat stages, poison it, freeze it, burn it, or cause it to flinch. 
A Pokémon behind a substitute can be inflicted with paralysis or sleep by status moves (such as Thunder Wave and Hypnosis), 
but not by damaging moves (such as Thunderbolt). 
Conversely, a Pokémon behind a substitute cannot be confused by status moves (such as Confuse Ray), 
but can be confused by damaging moves (such as Confusion) as long as they do not break the substitute. 
Even if a move breaks a substitute, it cannot inflict any effects it would not be able to inflict to a Pokémon behind a substitute.

Additionally, Substitute does not affect the opponent's Disable, Leech Seed, Super Fang, Transform, or binding moves; 
the user's Bide, Counter, or Rage; nor either Pokémon's Haze.


If a Pokémon breaks a substitute with Hyper Beam, it will not need to recharge. If a Pokémon breaks a substitute with Explosion or Selfdestruct, it will not faint, although its sprite will still disappear until it switches out (or uses Substitute). If a Pokémon breaks a substitute with a recoil move, it will not take any recoil damage. If a Pokémon breaks a substitute with Pay Day, that use of Pay Day will not count toward the money its Trainer picks up at the end of the battle. If a Pokémon attacks a substitute with a multi-strike move, the hits will automatically end if the substitute breaks.


In Generations I and II, the substitute retains its user's color palette. (For instance, a blue Pokémon would create a blue substitute.)
Generation II

In general, the fixed effects from Stadium in Generation I are retained. For example:

	If the user's current HP is equal to or lower than 25% (rounded down) of its maximum HP, it will be too weak to create a substitute.
	A Pokémon behind a substitute cannot be inflicted with any status condition or caused to flinch by an opponent's move.
	Super Fang affects the substitute rather than the Pokémon behind it.
	Rage works as normal.
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
	A Pokémon behind a substitute cannot have its item stolen by Covet. 
	Trick fails if its target is behind a substitute.
	A substitute takes the damage from Doom Desire.
	Yawn is blocked by the substitute, but if a Pokémon behind a substitute is already drowsy due to Yawn it can still fall asleep.

The following effects are changed between Generations II and III:

	Rage's effect will now no longer activate if its user's substitute is hit.
	Swagger and Flatter will now fail if used on a Pokémon behind a substitute.
	Protect, Detect, and Endure now behave as normal.
	Damaging draining moves (except Dream Eater) can now hit a substitute as normal, and the user of the move will gain HP depending on the HP the substitute lost. (Leech Seed is still blocked by the substitute.)
	Recoil moves now inflict recoil damage to the user depending on the damage dealt to the substitute.
	Trapping moves are now blocked by the substitute.
	Mimic is now blocked by the substitute.

The following effects are newly introduced in Generation III:

	Shedinja, having a maximum of only 1 HP, cannot make a substitute.
	Substitute can be stolen by Snatch.
	SmellingSalt will not have any of its additional effects applied if it hits a substitute, 
	even if the Pokémon behind it is paralyzed.

Generation IV

The following effects are carried over/expanded from Generation III:

	A Pokémon behind a substitute cannot have its item eaten by Pluck or Bug Bite. 
	Switcheroo fails if its target is behind a substitute.
	Like Counter and Mirror Coat, Metal Burst also does not count damage taken by its user's substitute.
	Similar to SmellingSalt, Wake-Up Slap will not have any of its additional effects applied if it hits a substitute, 
	even if the Pokémon behind it is asleep.

The following effects changed between Generations III and IV:

	Tickle will now fail if used on a Pokémon behind a substitute.

The following effects are newly introduced in Generation IV:

	The Enigma Berry will not activate if the substitute takes the move, 
	nor will damage-reducing Berries (such as the Occa Berry).
	If an opponent's U-turn breaks the user's substitute, 
	and the opponent then switches in a Pokémon with Intimidate, 
	the substitute will not fade until after it has successfully blocked the new Intimidate.

	If a Pokémon behind a substitute uses Baton Pass, 
	the Pokémon switched in cannot be poisoned by Toxic Spikes, 
	but if it is a grounded Poison-type Pokémon it will still remove the Toxic Spikes.
	A Pokémon behind a substitute is unaffected by the effects of items thrown by Fling if the substitute takes the move.
	An opponent's Defog will not lower the evasiveness of a Pokémon behind a substitute, but it will still remove fog as well as team effects (Reflect, Mist, etc.) and entry hazards on the target's side of the field.
	A substitute blocks Copycat, Embargo, Gastro Acid, Heal Block, Psycho Shift, and Worry Seed. A substitute blocks Acupressure regardless of whether it was used by an ally or the user itself.

Generation V

A Pokémon behind a substitute cannot have its item destroyed by Incinerate or be given an item by Bestow. 
The Ability Pickpocket and the Item Drop from Wonder Launcher can steal or remove a Pokémon's held item, respectively.

If Smack Down, Clear Smog, Circle Throw, or Dragon Tail target a substitute, 
their secondary effects will not trigger. 
The move Sky Drop will fail if the target is behind a substitute.

Substitute now blocks Transform and Imposter.

Another Pokémon's Dream Eater can now affect a Pokémon's substitute and acts the same way as other damaging draining moves.

Generations VI and VII

Substitute no longer blocks sound-based moves (such as Metal Sound) 
or any moves used by Pokémon with the Ability Infiltrator, except Transform and Sky Drop. 
The moves Hyperspace Hole, Hyperspace Fury, Play Nice, and Spectral Thief can also bypass a substitute. 

Aromatherapy can still heal the user's status conditions if it is behind a substitute, 
but will now fail to affect an ally behind a substitute. 
Substitute will prevent Knock Off from discarding a removable held item, however Knock Off's power will still be increased.

TODO team :
- Self-confusing Berries (such as the Figy Berry) no longer confuse Pokémon behind a substitute.
- Acupressure can now successfully be used by a Pokémon behind a substitute on itself, 
but it will still fail if it targets an ally behind a substitute.
*/
