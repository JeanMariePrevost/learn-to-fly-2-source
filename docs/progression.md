# Modes and progression

[Flight mechanics](mechanics.md) | [Equipment](equipment.md)

## Game modes

| Mode | Goal | Progress |
| --- | --- | --- |
| Story | Destroy The Wall to start the Story ending. | Cash and upgrades carry across days. Obstacles and payloads are available. |
| Classic | Reach 6,000 ft. | Cash and upgrades carry across days. Obstacle destruction and payload purchases are unavailable. |
| Arcade | Score as high as possible on one flight with a fixed equipment budget. | Each attempt resets the loadout. Arcade tracks the best score per budget and awards Bonus Points per flight. |

Completing Story unlocks Classic and Arcade. Clicking the main menu penguin's beak also unlocks them and gives The easy way medal. [Story ending](../scripts/Main%20timeline.as#L6626) · [Classic ending](../scripts/Main%20timeline.as#L5006) · [Mode locks](../scripts/Library/!MainMenu/mainmenu.as#L239) · [Beak](../scripts/Library/!MainMenu/playerfront.as#L3)

| Arcade budget | Score multiplier | Bonus Points |
| ---: | ---: | --- |
| 1,000 | 2.6 | `round(score × 0.022)` |
| 5,000 | 2.2 | `round(score × 0.009)` |
| 25,000 | 1.75 | `round(score × 0.0055)` |

Arcade Mode medal requires 12,500 across the three best scores. [Budgets](../scripts/Main%20timeline.as#L8088) · [Arcade results](../scripts/Library/!Result/results_arcade.as#L24) · [Medal check](../scripts/Main%20timeline.as#L1958)

## Challenges

A challenge pays once per Story or Classic game. Crossing its threshold in flight awards cash immediately. Arcade skips the challenge checks. [Challenge setup](../scripts/Main%20timeline.as#L1193) · [Checks](../scripts/Main%20timeline.as#L1455) · [Rewards](../scripts/Main%20timeline.as#L1522)

| Goal | Thresholds | Story reward tiers | Classic reward tiers |
| --- | --- | --- | --- |
| Forward distance (ft) | 100 / 350 / 1000 / 2000 / 4000 | 1 / 2 / 3 / 4 / 5 | 1 / 2 / 3 / 4 / 5 |
| Altitude (ft) | 10 / 35 / 100 / 200 / 400 | 1 / 2 / 3 / 4 / 5 | 1 / 2 / 3 / 4 / 5 |
| Speed | 35 / 75 / 125 / 250 / 450 | 1 / 2 / 3 / 4 / 5 | 1 / 2 / 3 / 4 / 5 |
| Duration (s) | 10 / 25 / 40 / 60 / 90 | 1 / 2 / 3 / 4 / 5 | 1 / 2 / 3 / 4 / 5 |
| Destroy each obstacle | One target per tier, listed in map order | 2 / 3 / 4 / 5 / 6 | Unavailable |
| Obstacles destroyed in one flight | 2 / 3 / 4 / 5 | 3 / 4 / 5 / 6 | Unavailable |
| Sea bounces in one flight | 2 / 10 | 2 / 4 | 2 / 4 |
| Backward distance (ft) | 100 / 2500 | 2 / 5 | 2 / 5 |
| Depth below the altitude origin (ft) | 15 / 50 | 2 / 5 | 2 / 5 |

| Tier | 1 | 2 | 3 | 4 | 5 | 6 |
| --- | ---: | ---: | ---: | ---: | ---: | ---: |
| Story cash | 30 | 75 | 350 | 800 | 1,500 | 2,500 |
| Classic cash | 45 | 90 | 450 | 1,000 | 2,000 | 3,500 |

## Bonus Shop

The shop checks `BP earned − BP on hand` against the 2,500 BP spending cap before regular purchases. A purchase can take spending past the cap. Ramp Angle and VHS have separate purchase rules. [Cap](../scripts/Main%20timeline.as#L9) · [Spending check](../scripts/Main%20timeline.as#L3760) · [Prices](../scripts/Main%20timeline.as#L3773)

| Shop slot | Price in BP by level | Effect |
| ---: | --- | --- |
| 1 | 100 / 250 / 500 | Start at day `1 − level`. |
| 2 | 100 / 250 / 500 | Multiply flight cash by `1 + 0.05 × level`. |
| 3 | 100 / 250 / 500 | Add `0.1 × level` of the gap to 1 to air and propeller X retention. |
| 4 | 100 / 250 / 500 | Multiply boost power by `1 + 0.05 × level`. |
| 5 | 100 / 250 / 500 | Multiply obstacle health by `1 − 0.15 × level`. |
| 6 | 100 / 250 / 500 | Multiply red-zone drag by `1 − 0.1 × level`. |
| 7 | 100 / 250 / 500 | Multiply gravity by `1 − 0.0333 × level`. |
| 8 | 100 / 250 / 500 | Multiply boost fuel by `1 + 0.05 × level` and propeller fuel by `1 + 0.1 × level`. |
| 9 | 250 | Ramp Angle slider. |
| 10 | 1,000 | Omega Catalog. |
| 11 | 50 | VHS cutscene viewer. |
| 12 | 100 / 150 / 250 | Bonus HUD adds distance, then pitch resistance, then the red-zone readout. |

Music tracks cost 150 BP each. See [cash](mechanics.md#cash-and-arcade-score), [glide setup](../scripts/Main%20timeline.as#L4882), [propeller fuel](../scripts/Main%20timeline.as#L5352), and [obstacle health](../scripts/Main%20timeline.as#L6142).

## Secrets

Rise and Rob roll at most once each on their trigger, with at most one successful secret per flight. Both have a base chance of 0.005. Until the relevant medal is earned, multiply Rob's chance by `min(50, 0.7 × total_days)` and Rise's by `min(50, 0.5 × total_days)`. [Odds](../scripts/Main%20timeline.as#L2414)

| Secret | Trigger | Effect |
| --- | --- | --- |
| It's ROB! | Outside Arcade, fuel crosses from above 0.1 to 0.1 or below on the last stage of a staged boost or with a non-staged boost. Altitude must be at least 80 ft. | The supply box refills boost fuel when it comes within 70 px. |
| Rise! | Outside Arcade, a normal ground finish on day 6 or later. | Moves the player to 7,000 px above ground and relaunches at −20° with 200 jump power. |

[Rob trigger](../scripts/Main%20timeline.as#L5416) · [Supply box](../scripts/Library/!Secrets/!rob64_com.as#L39) · [Rise trigger](../scripts/Main%20timeline.as#L5249) · [Rise relaunch](../scripts/Library/!Secrets/!riseFromYourGrave.as#L22)

## Medals

Each medal pays BP once. The game checks totals and cash in the shop and flight thresholds during flight. [Medal table](../scripts/Main%20timeline.as#L1571) · [Flight checks](../scripts/Main%20timeline.as#L1764) · [Shop checks](../scripts/Main%20timeline.as#L1877)

| Medal | Trigger | BP |
| --- | --- | ---: |
| Milestone 1–4 | Days logged ≥ 10 / 25 / 75 / 150 | 50 / 100 / 150 / 250 |
| Traveler 1–4 | Total forward finish distance (ft) ≥ 500 / 5000 / 50000 / 150000 | 50 / 100 / 150 / 250 |
| High Flyer 1–2 | Altitude (ft) ≥ 250 / 1000 | 50 / 150 |
| Speedster 1–2 | Speed ≥ 100 / 500 | 50 / 150 |
| Master Bouncer | Total sea bounces ≥ 100 | 200 |
| C-C-C-Combo | Obstacles destroyed in one flight ≥ 5 | 200 |
| Achiever 1 | Story challenges completed ≥ 35 | 250 |
| Achiever 2 | Classic challenges completed ≥ 26 | 250 |
| Duration 1–4 | Total flight duration (s) ≥ 60 / 300 / 1500 / 3600 | 50 / 100 / 150 / 250 |
| Destruction 1 | First obstacle destroyed | 50 |
| Destruction 2 | Destroy each of the five obstacles | 100 |
| Destruction 3–4 | Total obstacles destroyed ≥ 25 / 75 | 150 / 250 |
| Story Mode | Story ending | 500 |
| Classic Mode | Classic ending | 500 |
| Arcade Mode | 12,500 combined best Arcade score | 500 |
| Bounty Hunter 1–2 | Total BP earned ≥ 1000 / 5000 | 100 / 200 |
| Rich Bird 1–2 | Cash on hand outside Arcade ≥ 25000 / 100000 | 100 / 200 |
| I.C.B.P. | Pacifist cutscene | 250 |
| Give an inch / He'll take a yard | Click the shop cash display twice | 100 / 100 |
| The Brick | Equip The Brick | 100 |
| Revenge of The Brick | Destroy an obstacle with The Brick | 100 |
| It's ROB! | Trigger Rob | 100 |
| Rise! | Trigger Rise | 100 |
| The easy way | Click the penguin's beak on the main menu | 100 |
| Achievement! | Click the medal's own icon | 100 |
| Secret disabled | Disabled | 100 |
| Pacifist 1–2 | Consecutive pacifist Story days ≥ 10 / 25 | 100 / 250 |
| Skull Crusher, Planet Crusher | Crash strength ≥ 350 / 2500 | 100 / 250 |
| Reverse 1–2 | Total backward finish distance (ft) ≥ 250 / 15000 | 50 / 150 |
| Dive 1–2 | Total dive depth (ft) ≥ 100 / 1000 | 50 / 150 |
