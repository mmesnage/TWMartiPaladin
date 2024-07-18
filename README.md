# TWMartiPaladin

How it works : 
1) Create a macro : /script one_of_the_available_functions() (example : /script TWMMissingTankBlessing())
2) GG

Available functions :

- **TWMMissingTankBlessing** :
Only in raid, if you are the paladin assigned to Salvation, and too few Paladins are in, tanks may miss Kings, Might, Light or Sanctuary (because they remove your Salvation buff).
This will bless tanks that cancelled their savlvation (will prioritise Kings then Might then Light then Sanctuary (if spell known)).
Spam it when raid is fully blessed (and in range preferably) to give tanks missing 5min blessings.


/!\ Addon Dependencies : PallyPower (https://github.com/madScripting/PallyPower-TurtleWoW)

### Change Log

#### 1.0.1.0

* Improved TWMMissingTankBlessing, small blessings to apply will be determined using PallyPower assignements instead of buffs already on raid members.

#### 1.0.0.0

* first version TWMMissingTankBlessing