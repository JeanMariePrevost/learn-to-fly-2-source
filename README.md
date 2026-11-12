# Learn to Fly 2: source code

![Learn to Fly 2 cover art](docs/capsule.jpg)

ActionScript 2 source for Learn to Fly 2 (2011), from the Flash project last saved in 2017, version 1.14. Most of the code was on the main timeline. The rest was on library symbol timelines, including frame scripts that set up button and movie clip behavior.

I used scripts, AI agents and some manual edits to remove platform integrations, clean up the scripts that called them, and put together the docs. The guides link to the code so you can check the details yourself.

## Mechanics

The guides trace a flight from launch through gliding, boosting, and obstacle hits. They also cover the equipment stats and how scoring and progression vary by mode.

1. [Flight mechanics and scoring](docs/mechanics.md)
2. [Equipment and cash upgrades](docs/equipment.md)
3. [Modes and progression](docs/progression.md)

## Artwork renders

[Preview](docs/art-renders/preview.png) · [Asset manifest](docs/art-renders/manifest.csv). The full pack contains transparent 256 × 256 and 1024 × 1024 PNGs in `learn-to-fly-2-art-renders.zip` for [Releases](../../releases).

## What's here

This release is for reading the source. I left out the Flash project file and the original art and sound.

`scripts/` holds the exported game code:

1. `Main timeline.as`: the code on the game's main timeline.
2. `Library/`: one file per library symbol that has code, in the same folders as the project's library.

Each block starts with a comment saying where it sits, for example `// ---- layer "Control", frame 4`, or the instance it's attached to for `on (...)` and `onClipEvent (...)` code.

## License

This project is licensed under the [LBG-NCNC License v1.0](LICENSE.md).

**Short version:** Do whatever, but give credit, don’t make money from it, don’t compete with me, and don’t hurt my business. (See the license for the actual terms.)

Light Bringer Games reserves its rights in the game's name, art, and sound. Third-party files have their own licenses.
