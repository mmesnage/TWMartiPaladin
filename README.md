# TWMartiPaladin

### How it works : 
1) Create a macro : **/script one_of_the_available_functions()** (example : **/script TWMMissingTankBlessing()**)
2) GG

#### Available functions :

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


**/!\ Addon Dependencies : PallyPower (https://github.com/madScripting/PallyPower-TurtleWoW)**

### Change Log :

#### TODO 
* New functions
* Slash commands

#### 1.2.1.0

* Add TWMMissingSmallBlessing

#### 1.1.1.0

* Add TWMPalTaunt, if Judgement not on cooldown, buff paladin with Seal of Justice then Judge. 

#### 1.0.1.0

* Improved TWMMissingTankBlessing, small blessings to apply will be determined using PallyPower assignements instead of buffs already on raid members.

#### 1.0.0.0

* first version TWMMissingTankBlessing