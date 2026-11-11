# Learn to Fly 2: source code

The ActionScript 2 code of Learn to Fly 2 (2011), from the main Flash project file as last saved (2017).

This is for reading, not building. The game lived inside a Flash project file, with its code spread over the frames of its timelines, and the art and sound aren't included.

## What's here

`scripts/` holds the exported game code:

1. `Main timeline.as`: the code on the game's main timeline, which is most of the game.
2. `Library/`: one file per library symbol that has code, in the same folders as the project's library.

Each block starts with a comment saying where it sits, for example `// ---- layer "Control", frame 4`, or the instance it's attached to for `on (...)` and `onClipEvent (...)` code.

## Game mechanics

1. [Flight mechanics and scoring](docs/mechanics.md)
2. [Equipment and cash upgrades](docs/equipment.md)
3. [Modes and progression](docs/progression.md)

## License

The [LBG-NCNC License v1.0](LICENSE.md) covers Light Bringer Games' source code in this repository.

You can read, use, change, and share the code for noncommercial purposes, including by forking it on GitHub. When sharing, credit Light Bringer Games and keep the license and copyright notices. Get written permission before distributing or hosting a product based on the code that competes with or undercuts a Light Bringer Games product or service, even if it's free. The full license governs.

Light Bringer Games reserves its rights in the game's name, art, and sound. Third-party files have their own licenses.
