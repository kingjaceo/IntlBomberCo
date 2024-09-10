**For Zack:**

These are the steps you should follow if you want to access the "objective grid editor":
1. Download Github Desktop, connect to this repository (Google: how to connect repo to github desktop), pull the repo onto your own computer (Google: how to pull repo github desktop).
2. Download Godot, Import the repo you just pulled as a project in Godot.
3. In Godot: press "Run Project" in the top right corner (to make sure the game runs).




Here are some tips for editing the objective grid:
- There is a camera with zoom and WASD movement. Unfortunately, it takes inputs even as you type in text fields. :)
- The camera can "sprint" with Shift.
- "Upfront" is what the player gets for "Accepting" a contract.
- "Completion" is what the player gets when the "Trigger" is triggered.
- Links between objectives are also Triggers, which will trigger new contracts to appear at at a town, rather than triggering a reward for the player.
- Description/Flavor text do not appear in-game yet.
- Only the first objective at (0,0) currently shows up in town (I need to right code that determines the "frontier" of an objective grid: only the bottom-right-most objectives that are accessible)
- Save/Reset/Selecting towns currently works (try exiting out and rerunning).

Future Functionality:
- More triggers (buildings destroyed, time passed, reputation reached, people fed/helped, region discovered, ship destroyed; I think this is where the real magic of the system comes in)
- More rewards (items, ships, upgrades, abilities, or we could say: all rewards are reputation, which unlocks access to content indirectly, eg, new items appear in the shop after a reputation threshold)
- Automatic update of ObjectiveGrid whenever link triggers are satisfied
- Frontier calculation
