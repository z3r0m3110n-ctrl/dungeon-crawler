# Dungeon Crawler RPG

Welcome to my first game! This is work-in-progress dungeon crawler RPG built with the Godot Engine. The project focuses on building the foundations of a 2D RPG, including player movement, character animations, state management, custom terrain, and collision detection.

The long-term goal is to create a more advanced dungeon environment with multiple levels, unique tilesets, and expanded gameplay mechanics.

<img width="1153" height="648" alt="Screenshot 2026-10-25 155136" src="https://github.com/user-attachments/assets/8a793617-9312-45a9-840a-8fe97ce4e32e" />


## Download and Play
Current Release: v0.1.0 — Initial Prototype

A Windows build of the Dungeon Crawler RPG is available for download.

**Windows**
- Go to the [Latest Release](https://github.com/z3r0m3110n-ctrl/dungeon-crawler/releases) page.
- Download the Windows .exe file from the release assets.
- Run the executable to start the game.
- Use the arrow keys to move the player

Note: This is an early prototype. Some features, including character animations and dungeon environments, are still under development.

### Current Status

Early development — movement, animation state management, terrain, and collision systems implemented.

The project has progressed from a basic movement prototype into a more structured RPG foundation. The next major priorities are explaning the gameplay mechanics to include jumping and attacking, as well refining the environment with more varied terrain and level designs.

The project also serves as a learning experience in Godot, with each new feature helping build a better understanding of game programming, animation systems, and level design.

## Features
- Player Movement: Move the player character using the arrow keys.
- Character Animations: Implemented a repeating idle animation, with a state machine designed to manage idle and walking states.
- Animation State Machine: Separates animation logic based on the player's current state.
- Custom Terrain: Handcrafted terrain created in GIMP and imported into Godot as a tileset.
- Terrain Painting: Includes a dirt path terrain that can be painted into the level using Godot's terrain tools.
- Collision Detection: Rocky cliff terrain blocks player movement, requiring the player to navigate around obstacles.
- Movement Refinements: Improved collision behavior so the player can move along blocking terrain without passing through it or getting stuck as easily.

## Built With
- Godot Engine — Game engine used for development.
- GIMP — Used to create custom terrain textures.
- itch.io — Source of open-source placeholder sprites.
- GDScript — Used to implement movement and animation state management.

## Development Log
### Player Movement and Placeholder Sprites
Implemented a player movement system using the arrow keys.
Added placeholder sprites and converted them to PNG format for compatibility with Godot.
Applied a sprite texture to the player character.

This was the starting point for the project. Although learning Godot presented some challenges, the movement system worked as intended. The next step was to develop character animations before building out the environment.

### Player Idle Animation
Created a repeating idle animation using character sprites.
Began implementing the walking animation logic.
Explored Godot's animation workflow and scripting tools.

At this stage, the idle animation only displayed the character facing downward. Directional animations and a complete walking animation were identified as future improvements.

One thing that stood out about Godot was its helpful error messages, which explain what needs to be added or corrected. This made learning the engine and troubleshooting code easier.

### Animation State Machine
Replaced the original placeholder sprites with an open-source sprite set from itch.io.
Created a state machine to distinguish between idle and walking animations.
Added scripting logic to determine which animation should play based on the character's current state.

The state machine introduced a more structured approach to animation management. Working on it provided a deeper understanding of Godot's functions and scripting, while creating code that can be revisited and expanded as the project grows.

<img width="1919" height="1006" alt="Screenshot 2026-10-24 010352" src="https://github.com/user-attachments/assets/40a822cd-c2c8-44d2-8c47-9adc88164997" />

### Custom Terrain and Collision
Designed custom terrain textures in GIMP.
Imported the terrain into Godot and created a tileset.
Added a dirt path terrain that can be painted into the environment using Godot's terrain tools.
Implemented collision on rocky cliff terrain to prevent the player from walking through obstacles.
Refined player movement along blocking terrain to reduce sticking and improve navigation.

Creating custom terrain gave the game its own visual identity and established the foundation for building more advanced environments. The current terrain serves as a starting point, with plans to develop additional tilesets for different levels.

<img width="512" height="256" alt="grassTileset" src="https://github.com/user-attachments/assets/bcd10f96-2dbd-46d9-a8e8-8c8f23c81e88" />


## Art and Assets

The project uses custom terrain textures created in GIMP and open-source placeholder sprites sourced from itch.io.



