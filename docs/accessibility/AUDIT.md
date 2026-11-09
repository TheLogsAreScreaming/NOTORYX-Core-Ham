# Accessibility audit: NOTORYX Core Ham

**Audited:** 2026-11-09, first on `dev` at `fd16fbc5` (0.1.0-test.7), then re-measured after fixes on top of `cc9b72b3` (0.1.0-test.8).
**Status:** automated and code-review parts done. **The screen-reader walk-through on a real phone has not been done**, so this audit is incomplete and makes no compliance claim.

Use NOTORYX Core Ham only after a great deal of coordination with your frequency coordinator and the other stations on your net.

## Method

Anyone can repeat these steps from the repository.

| Step | How | What it can show |
|---|---|---|
| 1. Rendered screens | `PREVIEW_A11Y=1 PREVIEW_OUT=<dir> flutter test test/preview` | Flutter's tap-target, labelled-target and text-contrast checks on 28 preview screens, in the Blaze and Pink Overload themes |
| 2. Code scan | `python3 tools/a11y_scan.py` | Tap handlers and icon buttons that may have no spoken name, and text-scaling overrides. Results are candidates for a person to review |
| 3. Screen reader | `PHONE_ACCESSIBILITY_CHECK` table, on a real phone with TalkBack | Whether the app makes sense when listened to. Automated checks cannot show this |

## Results

### 1. Rendered screens

After the fixes, 32 of 56 screen and theme combinations pass every check (30 of 56 before). The harness's `channels` preview also reports its known pending-timer error, after its results are written.

| Finding | Where | Measured | Verdict |
|---|---|---|---|
| Text contrast below 4.5:1 | Segmented controls on Settings, the prefix tool and Networks | 3.25 to 4.48:1 before | **Fixed:** these checks no longer report a failure |
| Text contrast below 2.5:1 (34 results) | Section labels and headers on the patterned backdrop, such as "Trip" and "Your station" | 1.0 to 2.43:1 | Likely false positives, because the checker reads the backdrop pattern. An earlier review compared these with screenshots; they were not re-inspected one by one for this audit |
| Tap target under 48 dp | Message text in chat bubbles | Text height | Accepted: the whole bubble stays tappable |
| Tap target under 48 dp | 24-hour chart bars in field stats | About 14 dp wide | Accepted: each bar has a spoken label and the same data is listed below |

### 2. Code scan

No icon button lacks a tooltip, and nothing overrides the system text size. The first scan flagged 18 tap handlers, and all have now been read. The scan can't see every label, so it still lists some that were fixed or cleared.

| Where | Finding | Verdict |
|---|---|---|
| `lib/widgets/jump_to_bottom_button.dart` | Had no spoken name; 40 dp | **Fixed:** named, 48 dp |
| `lib/screens/repeater_cli_screen.dart` | Send icon had no spoken name; 38 dp | **Fixed:** named, 48 dp |
| `lib/widgets/gif_message.dart` | Tap to pause had no spoken name | **Fixed:** says Play or Pause |
| `lib/widgets/gif_picker.dart` | GIF tiles had no spoken name | **Fixed:** says Send GIF, though not which GIF |
| `lib/screens/map_screen.dart` node and guessed-position markers | Had no spoken name | **Fixed:** say the node name |
| `lib/screens/map_screen.dart` shared-pin markers | Had no spoken name | **Fixed:** say the pin's label |
| `lib/screens/wardrive_screen.dart` ping dots | Had no spoken name; 22 dp | **Fixed name:** say the ping's time. Still 22 dp, because larger targets would overlap on a dense drive |
| `lib/screens/line_of_sight_map_screen.dart` obstruction markers | Had no spoken name | **Fixed:** say the blocked spot's distance and height |
| `lib/widgets/received_image_message.dart` | Depends on what the caller puts inside | Needs a screen-reader check |
| Field stats chart, the line-of-sight chart markers, `radio_stats_entry.dart` | Already labelled | No defect |
| `mesh_ui.dart`, `settings_screen.dart` rows, snack bars | The name comes from their content | No defect |

### 3. Screen reader

Not done. It needs a person with a phone. VoiceOver is also not done, because there is no iPhone build to test.

## Limits

- Every result comes from test renders with fake data, not a real device.
- Only two of the app's themes were measured.
- The new SALUTE and 9-Line, forwarding, app lock and team config screens have no preview in the harness, so the automated checks don't cover them. Include them in the screen-reader pass.
