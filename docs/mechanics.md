# Flight mechanics

[Equipment](equipment.md) | [Modes and progression](progression.md)

## Units and records

One foot is 60 game pixels. Coordinates increase right and down. Angles are in degrees, with 0 facing right and −90 up. The game records velocity magnitude in pixels per simulation frame, rounded up to one decimal place.

| Stat | Calculation |
| --- | --- |
| Distance (ft) | `ceil(10 × (player_x − ramp_end_x) / 60) / 10` |
| Altitude (ft) | `ceil(10 × ((ground_y − player_y) / 60 − 0.6)) / 10` |
| Speed | `ceil(10 × sqrt(vx² + (vy + accumulated_gravity)²)) / 10` |
| Duration (s) | Add 0.035 each frame that passes the ground-clearance test. Takeoff resets it. |

Results pay for peak forward distance, altitude, and speed. Each maximum starts at zero. Lifetime distance uses final position. Negative final distance goes into the reverse total. [Stats](../scripts/Main%20timeline.as#L7729) · [Results inputs](../scripts/Library/!Result/results.as#L24) · [Lifetime totals](../scripts/Main%20timeline.as#L293)

## Launching

The slide starts at speed 1.5. The ramp collision shapes determine the local slope and takeoff point. The export contains the hit tests but omits the shapes. [Ramp setup](../scripts/Main%20timeline.as#L4512) · [Slide](../scripts/Main%20timeline.as#L4656)

| Ramp section | Speed update per frame |
| --- | --- |
| Upper slope | `speed × sleigh_friction + max(0, acceleration × slope_radians)` |
| Drop | `speed × sleigh_friction + acceleration × slope_degrees / 57.3` |
| Exit curve | `(speed + max(0, acceleration × slope_radians)) × 1.01` |
| Takeoff | `speed × (1 + takeoff_coefficient × speed²)` |

Default takeoff is −40°. The purchased ramp slider rounds its position `y` to a pixel between 2 and 114. The angle is `ceil(−156 × ln(1 − 0.00415y) − 60)`, giving −58° to +40°. Reset restores −40°. [Takeoff](../scripts/Main%20timeline.as#L4760) · [Angle slider](../scripts/Library/!Bonus%20Shop/!Ramp%20Angle/bonusShop_rampAngle.as#L3)

Sleighs with positive jump power get one slide-meter jump per launch. The meter uses distance from the ramp target and reads `clamp(100 − ceil(100 × distance / window), 1, 100)`. The window is `700 + 30 × length_level²` pixels before the target and 100 after. Meter frames 64, 85, and 94 select the feedback tier. The added speed is `jump_power × max(20, meter) / 100`. On the ramp, the jump forces takeoff at `max(ramp_angle − 30°, player_rotation)` and adds the impulse 50° above that angle. After takeoff, it adds the impulse 35° above the current glide direction. [Slide meter](../scripts/Main%20timeline.as#L7432) · [Jump trigger](../scripts/Main%20timeline.as#L7517) · [Takeoff impulse](../scripts/Main%20timeline.as#L4791)

## Gliding

`clamp(x, a, b)` restricts `x` to the range from `a` through `b`. Each frame:

1. Compute speed from `vx, vy` and cap it at 2,500 before the other modifiers. With pitch `p`, apply the quadrant multiplier below.
2. At the previous tick’s measured speed `s ≥ red_zone + 0.1`, multiply by `1 − red_drag × clamp((s − red_zone) / red_zone, 0, 5)`. Base `red_drag` is 0.05. Underwater, when accumulated gravity is positive and pitch is 1° through 90°, add `accumulated_gravity × pitch / 4500 × catch` to speed. Multiply speed and accumulated gravity by air retention, which starts at 0.9965.
3. Turn the velocity angle toward the player's pitch by the glider's Control fraction, wrapping across ±180°. Recompute `vx, vy` from the new angle and speed.
4. Set the lift gauge frame to `clamp(floor(400 × (speed − lift_start_speed) / (full_lift_speed − lift_start_speed)), 1, 400)`. The lift ratio is the gauge frame's height divided by 100. The export omits the gauge frames.
5. Compute `lift = min_lift + (effective_max_lift − min_lift) × lift_ratio`. Effective max lift is capped at `0.999 × effective_gravity`. If accumulated gravity and lift ratio are positive, multiply accumulated gravity by `1 − lift_ratio / 50`. Then add `effective_gravity − lift` to it. Move by `vx` horizontally and `vy + accumulated_gravity` vertically.

| Pitch | Speed multiplier |
| --- | --- |
| −90° to 0° | `1 − p / −85 × 0.1 × upcatch` |
| 0° to 90° | `1 − p / −85 × 0.1 × catch` |
| Above 90° to 180° | `1 − (p − 180) / 85 × 0.1 × catch` |
| Below −90° | `1 − (p + 180) / 85 × 0.1 × upcatch` |

Turn speed is `2 × spin × (1 + clamp(1.25 × (spin_red_zone − s) / spin_red_zone, −0.3, 1))` degrees/frame. Mouse control has a 1° dead zone and caps the turn at one third of the target angle error. [Glide constants](../scripts/Main%20timeline.as#L4860) · [Glide update](../scripts/Main%20timeline.as#L4938) · [Steering](../scripts/Main%20timeline.as#L5026)

## Boosting

Boost adds a velocity vector in the player's direction. Its magnitude is `power × min(1, 0.85 + 0.15 × abs(−90 − pitch) / 90)`. At straight up, thrust is 85% of the listed power. Base fuel and thrust come from the [fuel upgrade and equipped boost](equipment.md#boosts). Most branches require at least 0.1 fuel. [Boost initialization](../scripts/Main%20timeline.as#L5392) · [Thrust](../scripts/Main%20timeline.as#L5791)

1. THOR Ramjet and Omega Drive at `s ≤ 49` burn `0.6 + 0.4s / 50` fuel/frame at `0.5 × power + 0.35s / 50` thrust. Above that they use full thrust and their listed burn.
2. Air Balloon and Balloon Mk.II spend 0.1 fuel when triggered. Rocket Firework waits through boost animation frame 85. Cruise Missile uses 30% thrust and burns 0.5 fuel/frame while total fuel spent is at most 25.
3. Four-use boosts refill to the full fuel stat at the start of each stage. Solid Booster spends 4 on its first frame per stage and 3.6/frame after that. [Boost cases](../scripts/Main%20timeline.as#L5490)

A powered glider applies thrust at `pitch − 90°`. It uses full thrust while its own fuel counter is ≥0, then `power × decay_left / decay_max` while decay is ≥0. Each active frame consumes one count. Active thrust also multiplies vertical velocity by the Y retention stat and accumulated gravity by 0.99. X retention applies on every propeller update. [Propellers](../scripts/Main%20timeline.as#L5352)

## Ground and water

Ground contact tests player Y minus 7 px against ground Y. For rotation outside −90° to 90°, it also subtracts the hitbox height from ground Y. Crash power is `90 − min(abs(90 − direction), abs(−90 − direction))`. Crash strength records the greatest `speed × payload_hit_power × crash_power / 90`. Ground speed retains 0.985, with another factor of `1 − crash_power / 90` when crash power is above 10 and glide speed is above 25. Ground speed under 0.5 becomes zero. Otherwise subtract 0.3, with a floor of zero. The ground end timer counts down from 30 while the recorded speed is zero. Any nonzero recorded speed resets it. [Landing](../scripts/Main%20timeline.as#L5090)

The ground strip uses a cutoff of 500 ft in Classic and 1,200 ft in Story and Arcade. The water surface sits 60 px below ground. A fresh entry can bounce at speed ≥20 and reported direction from −15° through 17° if the 9-frame cooldown is clear. The bounce multiplies `glide_vx` by 0.85 and `glide_vy` by −0.85. It leaves `grav_mag`, which is added to vertical movement, unchanged. It sets pitch to `−45 + 30 × (direction + 15) / 32` degrees and moves the player 3 px above the surface. The bounce check reads `REF_SPEED` and the stats update writes `REF_speed`. [Landscape](../scripts/Main%20timeline.as#L5805) · [Sea update](../scripts/Main%20timeline.as#L5189)

Underwater, boost is disabled. The water step multiplies both velocity components and accumulated gravity by `0.9 × payload_water_retention` and subtracts `0.88 + glider_float` from accumulated gravity. If the last two reported vertical speeds differ by at most 0.001, the 40-count finish timer starts. Reaching the surface during the finish timer uses an extra count per frame. [Sea finish](../scripts/Main%20timeline.as#L5268)

## Obstacle damage

Story places five obstacles at fixed offsets from the ramp end. Health listed here is before Bonus Shop reductions. Damage persists between days until the obstacle is destroyed. At the start of a day, an obstacle with zero or negative health is restored to full. [Obstacle setup](../scripts/Main%20timeline.as#L6142)

| Obstacle | Distance (ft) | Health | Bounty | Overkill ratio |
| --- | ---: | ---: | ---: | ---: |
| Snowman | 90 | 60 | 40 | 3 |
| Snowpile | 400 | 250 | 150 | 2 |
| Snow Hill | 1,000 | 750 | 1,000 | 2 |
| Iceberg | 2,200 | 2,000 | 2,500 | 1.8 |
| The Wall | 4,500 | 7,000 | 10,000 | 1.7 |

A body hit deals `speed × payload_hit_power`. Set `hit_ratio = min(damage / full_health, 6)`. A kill retains `0.98 − 0.125 × max(0, 5 − hit_ratio)` of both velocity components. A surviving obstacle can stop the player. Without an explosive payload the partial bounty is `0.45 × bounty × hit_ratio`. [Collision](../scripts/Main%20timeline.as#L6203)

An explosive payload detonates after 30 countdown frames on a surviving obstacle. The blast deals its fixed damage. If the obstacle survives, add `min(explosion_damage / remaining_health_before_blast, 6)` to the hit ratio for the partial bounty. A kill pays the listed bounty. If `min(1 + abs(remaining_health_after_kill) / full_health, 5)` reaches the overkill ratio, multiply the bounty by 1.25. [Kills](../scripts/Main%20timeline.as#L6485) · [Explosions](../scripts/Main%20timeline.as#L6660)

## Cash and Arcade score

Inputs are peak altitude `a` and peak distance `d` in feet, duration `t` in seconds, peak raw speed `s`, and destruction `x`. Use `m = 1.1` in Story and 1.35 in Classic, and `b = 1 + 0.05 × cash_bonus_level`. Round each reward up separately and sum them. [Cash functions](../scripts/Main%20timeline.as#L7765)

| Stat | Story and Classic cash |
| --- | --- |
| Altitude up to 500 ft | `ceil((0.5a + 0.0021a²) × m × b)` |
| Altitude above 500 ft | `ceil((250 × ln(0.05a − 20.9) + 420) × m × b)` |
| Distance | `ceil(0.58d × m × b)` |
| Duration up to 100 s | `ceil((0.95t + 0.02t²) × m × b)` |
| Duration above 100 s | `ceil((t + 3) × b)` |
| Speed | `ceil((s + 0.002s²) × m × b − 21)` |
| Destruction | `ceil(x × b)` |

Arcade uses the altitude, distance, and short-duration expressions with the budget multiplier in place of `m × b`. Long duration is `ceil((t + 3) × budget_multiplier)`. Speed is `ceil((s + 0.002s² − 21) × budget_multiplier)`. Destruction scores zero. [Arcade formulas](../scripts/Main%20timeline.as#L7819) · [Budget multipliers](progression.md#game-modes)
