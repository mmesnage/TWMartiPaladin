# TWMartiPaladin

### How it works : 
1) Create a macro : **/script one_of_the_available_functions()** (example : **/script TWMMissingTankBlessing()**)
2) GG

#### Available functions :

- **TWMBoP** :
Only in raid, this one in particular and need to be activated, to activate run the command : **/script TWMAutoBoP(1)** (or create an additional macro for it) (0 instead of 1 to deactivate, and will be deactivated on reload ui / relogging)    
Once activated if someone whisper you exactly "BOP ME!", it will set the one that whispered you as the next target for the TWMBoP function, if you tap your TWMBoP macro it will attend to BoP the whisperer and then reset the target of the TWMBoP function.
Ask the ones that want to use that functionality to create a macro : **/script SendChatMessage("BOP ME!", "WHISPER", nil, "YourPaladinName")**.

- **TWMMissingSmallBlessing** :
Only in raid, if you are the paladin assigned to Might or Wisdom, and too few Paladins are in, some hybrid class may miss Might or Wisdom. For example, you have 3 feral druids and a Moonkin in raid, but only 3 paladins in raid, one paladin is assigned to Salvation and another to Kings, you are assigned to Might/Wisdom (Might on Druid because more ferals) => The moonkin will want Wisdom instead of Might!
This will bless raid members that cancelled their blessing of Might or Wisdom with the opposite one.
Spam it when raid is fully blessed (and in range preferably) to give missing 5min blessings.
Additionnally it will have the same behavior as TWMMissingTankBlessing if you are assign to Salvation.

- **TWMMissingTankBlessing** :
Only in raid, if you are the paladin assigned to Salvation, and too few Paladins are in, tanks may miss Kings, Might, Light or Sanctuary (because they remove your Salvation buff).
This will bless tanks that cancelled their savlvation (will prioritise Kings then Might then Light then Sanctuary (if spell known)).
Spam it when raid is fully blessed (and in range preferably) to give tanks missing 5min blessings.

- **TWMPalTaunt** :
If Judgement not on cooldown, buff paladin with Seal of Justice then judge (macro must be tapped 2 times). 


**/!\ Addon Dependencies : PallyPower (https://github.com/madScripting/PallyPower-TurtleWoW), SuperMacro (https://github.com/Monteo/SuperMacro)** 

### Change Log :

#### TODO 
* New functions
* Slash commands

#### 1.3.0.0

* Add TWMBoP

#### 1.2.1.0

* Fix : Add SuperMacro Dependency

#### 1.2.0.0

* Add TWMMissingSmallBlessing

#### 1.1.0.0

* Add TWMPalTaunt, if Judgement not on cooldown, buff paladin with Seal of Justice then Judge. 

#### 1.0.1.0

* Improved TWMMissingTankBlessing, small blessings to apply will be determined using PallyPower assignements instead of buffs already on raid members.

#### 1.0.0.0

* first version TWMMissingTankBlessing