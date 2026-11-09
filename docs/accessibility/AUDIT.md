# Accessibility audit: NOTORYX Core Ham

**Audited:** 2026-11-09, on `dev` at `fd16fbc5` (0.1.0-test.7).
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

30 of 56 screen and theme combinations passed every check. The harness's `channels` preview also reports its known pending-timer error, after its results are written.

| Finding | Where | Measured | Verdict |
|---|---|---|---|
| Text contrast below 4.5:1 | Settings segmented control, both themes | 3.25:1 and 3.85:1 | **Open defect** |
| Text contrast below 4.5:1 | Prefix tool, both themes | 3.82:1 | **Open defect** |
| Text contrast below 2.5:1 (36 results) | Section labels and headers on the patterned backdrop, such as "Trip" and "Your station" | 1.0 to 2.5:1 | Likely false positives, because the checker reads the backdrop pattern. An earlier review compared these with screenshots; they were not re-inspected one by one for this audit |
| Tap target under 48 dp | Message text in chat bubbles | Text height | Accepted: the whole bubble stays tappable |
| Tap target under 48 dp | 24-hour chart bars in field stats | About 14 dp wide | Accepted: each bar has a spoken label and the same data is listed below |

### 2. Code scan

No icon button lacks a tooltip, and nothing overrides the system text size. 18 tap handlers were flagged for review. Those read so far:

| Where | Finding | Verdict |
|---|---|---|
| `lib/widgets/jump_to_bottom_button.dart:23` | Icon only, no spoken name, 40 dp | **Open defect** |
| `lib/screens/repeater_cli_screen.dart:500` | Send icon with no visible name, small padding | **Open defect**, confirm with TalkBack |
| `lib/widgets/gif_message.dart:180` | Tap to pause has no spoken name | **Open defect** |
| `lib/widgets/received_image_message.dart:384` | Depends on what the caller puts inside | Needs a screen-reader check |
| `lib/widgets/radio_stats_entry.dart:79` | Wrapped in a tooltip and 48 dp | No defect |
| `lib/widgets/mesh_ui.dart:114`, `lib/screens/settings_screen.dart:426` | Shared wrappers; the name comes from their content | No defect in the wrapper |

Not yet reviewed: the map, line-of-sight and wardrive screens, the field stats chart, the snack bars and the GIF picker.

### 3. Screen reader

Not done. It needs a person with a phone. VoiceOver is also not done, because there is no iPhone build to test.

## Limits

- Every result comes from test renders with fake data, not a real device.
- Only two of the app's themes were measured.
- SALUTE and 9-Line reports, forwarding, app lock and team config were still in review and are not covered.
