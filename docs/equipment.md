# Equipment

[Flight mechanics](mechanics.md) | [Modes and progression](progression.md)

A new game starts at upgrade level 0 with item ID 0 equipped in each slot. Buying an item equips it. Switching to an owned item is free. [New-game setup](../scripts/Main%20timeline.as#L2276) · [Buying and equipping](../scripts/Main%20timeline.as#L2767)

## Sleighs

Acceleration and friction apply on the ramp. The takeoff coefficient scales launch speed. Jump power is the slide meter's maximum extra speed. The detached stats affect the discarded sleigh. [Source](../scripts/Main%20timeline.as#L4049)

| ID | Sleigh | Cash | Acceleration | Ramp friction | Takeoff coefficient | Jump power | Detached speed multiplier | Detached spin | Detached gravity | Detached resistance |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 0 | None | 0 | 0.29 | 0.9905 | 0 | 0 | 2 | 2 | 0.6 | 0.92 |
| 1 | The Plank | 25 | 0.52 | 0.995 | 0.000007 | 0 | 2 | 3 | 0.5 | 0.92 |
| 2 | The Plank Mark II | 125 | 0.64 | 0.997 | 0.00001 | 0 | 2 | 2 | 0.5 | 0.93 |
| 3 | Good Ol' Sled | 750 | 0.78 | 0.999 | 0.000013 | 0 | 1.8 | 2 | 0.6 | 0.94 |
| 4 | Bobsleigh | 2500 | 1 | 1.01 | 0.00002 | 0 | 1.3 | 0.5 | 0.7 | 0.98 |
| 5 | Spring Box | 100 | 0.4 | 0.985 | 0 | 15 | 2 | 4 | 0.6 | 0.9 |
| 6 | El Bouncy | 500 | 0.47 | 0.986 | 0 | 40 | 2 | 3 | 0.6 | 0.9 |
| 7 | (ka)Boom Box | 2500 | 0.54 | 0.987 | 0 | 100 | 2 | 2 | 0.6 | 0.92 |
| 8 | SuperSlide | 10000 | 1.1 | 1.02 | 0.00005 | 0 | 1.3 | 2 | 0.6 | 0.95 |
| 9 | Omega Coil | 15000 | 0.6 | 0.989 | 0.00002 | 350 | 2 | 2 | 0.6 | 0.93 |

## Gliders

Speeds use the game's raw speed scale. Lift and gravity are per-frame changes to vertical speed. See [gliding](mechanics.md#gliding) for the lift gauge and the gravity cap. [Source](../scripts/Main%20timeline.as#L4023)

| ID | Glider | Cash | Drag red zone | Lift starts | Full lift speed | Min lift | Max lift | Gravity | Float |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 0 | None | 0 | 50 | 998 | 999 | 0 | 0 | 0.4 | 0.15 |
| 1 | Kite | 15 | 25 | 2 | 10 | 0 | 0.3 | 0.4 | 0.15 |
| 2 | Old Glider | 200 | 60 | 3 | 12 | 0 | 0.33 | 0.4 | 0.15 |
| 3 | Hang Glider | 800 | 100 | 4 | 25 | 0 | 0.36 | 0.4 | 0.125 |
| 4 | H.I.G.H. Tech | 5000 | 250 | 5 | 50 | 0 | 0.395 | 0.4 | 0.1 |
| 5 | UltraLight Trike | 1500 | 175 | 10 | 40 | 0 | 0.36 | 0.4 | 0 |
| 6 | UltraLight Aircraft | 7500 | 300 | 20 | 40 | 0 | 0.39 | 0.4 | 0 |
| 7 | Pingu Balloon | 25 | 15 | 3 | 12 | 0.15 | 0.37 | 0.4 | 0.4 |
| 8 | Umbrella | 125 | 25 | 7 | 20 | 0.18 | 0.38 | 0.4 | 0.2 |
| 9 | Parachute | 500 | 45 | 10 | 25 | 0.23 | 0.39 | 0.4 | 0.15 |
| 10 | Zeppelin | 3500 | 100 | 15 | 40 | 0.28 | 0.395 | 0.4 | 0.6 |
| 11 | Old Fan | 350 | 50 | 998 | 999 | 0 | 0 | 0.4 | 0.15 |
| 12 | Propeller | 2250 | 100 | 998 | 999 | 0 | 0 | 0.4 | 0.15 |
| 13 | Whirlybird 512 | 5500 | 200 | 998 | 999 | 0 | 0 | 0.4 | 0.15 |
| 14 | The Brick | 0 | 50 | 998 | 999 | 0 | 0 | 0.42 | 0.15 |
| 15 | Omeglider | 35000 | 400 | 10 | 50 | 0 | 0.395 | 0.4 | 0.15 |
| 16 | The Chopper | 40000 | 300 | 998 | 999 | 0 | 0 | 0.6 | 0.15 |

## Glider control

Control is the fraction of the angle difference applied to the velocity each frame. Catch and upcatch scale the speed change with pitch. Spin sets turn speed before speed scaling. [Source](../scripts/Main%20timeline.as#L4030)

| ID | Glider | Control | Catch | Upcatch | Spin | Spin red zone |
| --- | --- | --- | --- | --- | --- | --- |
| 0 | None | 0 | 0.01 | 0.02 | 0.7 | 25 |
| 1 | Kite | 0.1 | 0.7 | 0.6 | 1.2 | 25 |
| 2 | Old Glider | 0.15 | 0.73 | 0.63 | 1 | 40 |
| 3 | Hang Glider | 0.3 | 0.76 | 0.66 | 1.1 | 65 |
| 4 | H.I.G.H. Tech | 0.5 | 0.79 | 0.69 | 1.2 | 120 |
| 5 | UltraLight Trike | 0.5 | 0.8 | 0.7 | 0.6 | 140 |
| 6 | UltraLight Aircraft | 0.75 | 0.8 | 0.7 | 0.7 | 200 |
| 7 | Pingu Balloon | 0.05 | 0.1 | 0.2 | 0.2 | 15 |
| 8 | Umbrella | 0.06 | 0.5 | 0.45 | 0.3 | 25 |
| 9 | Parachute | 0.08 | 0.5 | 0.55 | 0.3 | 45 |
| 10 | Zeppelin | 0.1 | 0.7 | 0.65 | 0.8 | 100 |
| 11 | Old Fan | 0 | 0.01 | 0.1 | 1.2 | 50 |
| 12 | Propeller | 0 | 0.01 | 0.1 | 1.5 | 100 |
| 13 | Whirlybird 512 | 0 | 0.01 | 0.1 | 2 | 200 |
| 14 | The Brick | 0 | 0.01 | 0.02 | 1 | 25 |
| 15 | Omeglider | 0.75 | 0.8 | 0.7 | 1.3 | 250 |
| 16 | The Chopper | 0 | 0.01 | 0.1 | 1.1 | 225 |

## Powered gliders

Fuel counts powered frames from the listed value through zero. Decay counts down through zero after full power. The [fuel bonus](progression.md#bonus-shop) increases the starting fuel. [Source](../scripts/Main%20timeline.as#L4035)

| ID | Glider | Thrust | X retention | Y retention | Fuel | Decay |
| --- | --- | --- | --- | --- | --- | --- |
| 11 | Old Fan | 0.42 | 0.995 | 0.991 | 275 | 25 |
| 12 | Propeller | 0.55 | 0.998 | 0.992 | 550 | 35 |
| 13 | Whirlybird 512 | 0.77 | 0.9991 | 0.991 | 1150 | 50 |
| 16 | The Chopper | 0.99 | 0.9997 | 0.994 | 1600 | 60 |

## Boosts

Starting fuel comes from the fuel upgrade. The table gives steady-state thrust and fuel burn. See [boosting](mechanics.md#boosting) for startup and staged behavior. [Source](../scripts/Main%20timeline.as#L4060)

| ID | Boost | Cash | Uses | Thrust | Fuel per frame |
| --- | --- | --- | --- | --- | --- |
| 0 | None | 0 | None | 0 | 0 |
| 1 | Propulsor | 100 | Held | 0.8 | 1 |
| 2 | Sugar Rocket | 250 | Held | 1.5 | 1 |
| 3 | Pulse Jet | 1000 | Held | 2.4 | 1 |
| 4 | THOR Ramjet | 10000 | Held | 4 | 1 |
| 5 | Air Balloon | 35 | 1 | 0.5 | 1.5 |
| 6 | Canned Air | 150 | 1 | 1.2 | 1 |
| 7 | Rocket Firework | 800 | 1 | 2.8 | 1.2 |
| 8 | Cruise Missile | 9500 | 1 | 5.5 | 1 |
| 9 | "Whistle" Rocket | 175 | 4 | 1 | 3 |
| 10 | Auxiliary Boosters | 1250 | 4 | 2 | 4 |
| 11 | "Lift-Off" | 7500 | 4 | 3.6 | 3.6 |
| 12 | Omega Drive | 25000 | Held | 6 | 1 |
| 13 | Balloon Mk.II | 25000 | 1 | 8 | 1.2 |
| 14 | Solid Booster | 25000 | 4 | 7 | 3.6 |

## Payloads

Story sells payloads. Classic and Arcade hide the payload controls. Hit power multiplies collision speed. Weight is a catalog rating. Water retention multiplies the base water drag. [Source](../scripts/Main%20timeline.as#L4068)

| ID | Payload | Cash | Hit power | Explosion damage | Post-blast frames | Weight rating | Water retention |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 0 | Snow | 0 | 0.5 | 0 | 0 | 0 | 0.82 |
| 1 | Sand | 25 | 1 | 0 | 0 | 1 | 0.88 |
| 2 | Iron Pellets | 175 | 2.5 | 0 | 0 | 2 | 0.94 |
| 3 | Cast Iron | 1000 | 6 | 0 | 0 | 5 | 0.97 |
| 4 | Osmium | 10000 | 13 | 0 | 0 | 10 | 1 |
| 5 | Dyna-MIGHT | 200 | 0.6 | 250 | 55 | 1 | 0.85 |
| 6 | C4 | 1500 | 1.5 | 1750 | 70 | 3 | 0.89 |
| 7 | Nuclear Warhead | 10000 | 4 | 4500 | 90 | 5 | 0.93 |
| 8 | Dark Matter | 25000 | 15 | 0 | 0 | 8 | 0.98 |

## Cash upgrades

The shop accepts levels 1 to 10. The price is for the selected level, even when skipping levels. Both shop scripts cap the selection at 10. The tables in the code extend past that cap. [Shop selection](../scripts/Main%20timeline.as#L2522) · [Purchase](../scripts/Main%20timeline.as#L2583) · [Stats](../scripts/Main%20timeline.as#L4084)

| Level | Length cash | Length offset (px) | Height cash | Height (px) | Fuel cash | Fuel |
| --- | --- | --- | --- | --- | --- | --- |
| 0 | 0 | -85 | 0 | 350 | 0 | 23 |
| 1 | 10 | -185 | 20 | 450 | 50 | 30 |
| 2 | 40 | -330 | 50 | 550 | 100 | 40 |
| 3 | 150 | -550 | 200 | 750 | 250 | 55 |
| 4 | 250 | -915 | 350 | 1000 | 500 | 70 |
| 5 | 500 | -1500 | 650 | 1500 | 850 | 90 |
| 6 | 800 | -2500 | 1000 | 2000 | 1250 | 115 |
| 7 | 1300 | -3500 | 2000 | 2500 | 2000 | 145 |
| 8 | 2500 | -4500 | 3500 | 3000 | 3500 | 180 |
| 9 | 5000 | -5500 | 6000 | 4000 | 6000 | 240 |
| 10 | 8500 | -7500 | 10000 | 5000 | 10000 | 350 |

The length offset sets the upper ramp geometry and `ramp_y = 380 − length_offset`. Ground is at `ramp_y + height_stat + 5 × length_level²` pixels. See [launching](mechanics.md#launching). [Ramp setup](../scripts/Main%20timeline.as#L4512) · [Landscape setup](../scripts/Main%20timeline.as#L5805)

## Unlocks

The Brick is the zero-cost glider on the empty catalog entry. Equipping it in the regular shop triggers a medal. The Omega Catalog costs 1,000 Bonus Points and opens the extra equipment pages. [Brick medal](../scripts/Main%20timeline.as#L2748) · [Omega pages](../scripts/Main%20timeline.as#L2657) · [Bonus shop prices](../scripts/Main%20timeline.as#L3773)
