# NOTORYX Core Ham: UI/UX redesign

A full pass over the app's look and flow, done in stages so each one can be reviewed, tested and released on its own. It changes how screens look and how you move between them. It does not change features, radio protocols, stored data or settings.

## Audit (November 2026)

- **Size:** 62 screens and 67 shared widgets, about 62,000 lines of UI code. Bottom bar: Home, Chats, Nodes, Map, More.
- **The existing system is decent but bypassed.** `MeshTheme`, `MeshPalette`, `MeshSpace`, `MeshRadii` and five themes exist, yet screens hardcode 414 `fontSize:` values, 409 `TextStyle(`s, 167 `Colors.*` and 160 `BorderRadius.circular`s. Text sizes, section headers and corner radii drift from screen to screen.
- **No shared states.** Each screen invents its own empty, loading and error views, and some show nothing at all.
- **Corners disagree.** Buttons use 6 px corners, inputs 14 px and cards 18 px.
- **Ham meaning.** Channels still show a padlock and "Private", which is misleading when everything on air is readable.
- **Navigation gaps.** More has no entry for the ham-specific Licensed operator page or for Connections. Both are reachable only from Settings or Home.

## Design direction

Material 3 structure (roles, components, motion), with Apple HIG restraint: content first, few colours, clear hierarchy, no decoration that doesn't carry meaning. The NOTORYX identity stays: dark field-instrument surfaces, the theme's accent colour (Blaze orange by default), monospaced numbers for radio readings, and the frosted backdrop on main screens.

**Principles**
1. **One source of truth.** Colours come from the theme's colour scheme or status colours, text from the type scale, and spacing and corners from tokens.
2. **Hierarchy before decoration.** One clear title per screen, grouped sections with quiet headers, and at most one prominent action.
3. **Say what's happening.** Every async view has loading, empty and error states. Connection state is always visible. Destructive actions ask first.
4. **Progressive disclosure.** Everyday actions are up front; advanced settings sit one level down with a plain-language description.
5. **Accessible by default.** 48 dp touch targets, contrast of at least 4.5:1 for body text, text that scales with the system setting, and motion that respects the system's reduce-motion setting.

## Stages

| Stage | Scope | Status |
|---|---|---|
| 1 | Design system v2: type scale, status colours, unified corners and controls, touch targets, motion tokens; shared components for empty, loading and error states, status banners and destructive confirmations | Done (PR 8) |
| 2 | Shell and navigation: More reorganised (a Station group with Licensed operator, Connections and Radio), Home hierarchy, no "Private" padlocks for ham channels | Done (PR 8; Home order in PR 21) |
| 3 | Chats and Nodes: list rows, chat headers, composer, empty states | Done (PR 9) |
| 4 | Settings, Connections, scanner, radio and repeater settings | Done (PR 8 scanner, PR 12) |
| 5 | Tools: field ops, wardrive, track log, diagnostics, path and route tools, maps | Done (PR 17) |
| 6 | Dialogs, sheets and snackbars app-wide; destructive confirmations | Done (PR 18) |
| 7 | Accessibility pass (text scale, touch targets, semantics), screenshots, write-up | Done (PR 19) |

Each stage ends with `flutter analyze`, the full test suite, and screenshots from `test/preview`. Anything that needs a real phone or radio to verify is listed in that stage's PR.

## Outcome

### Design system

All of it lives in `lib/theme/` and `lib/widgets/ui/`; screens consume it rather than define their own.

| Piece | What it is |
|---|---|
| Type scale | `meshTextTheme`: the Material 3 roles (display → label) set in Inter. Screens use `Theme.of(context).textTheme.<role>`. Radio readings use `MeshTheme.mono` on purpose. |
| Colour | The theme's `ColorScheme`, built from five palettes: Blaze, Autumn Frost, Bubble Gum (light), Red light and Okabe-Ito. `MeshStatusColors` adds info, success, warning and error, each with a container colour. |
| Shape | `MeshShape`: 12 for controls, 16 for cards, 24 for sheets and dialogs, and a 48 dp minimum touch size. All buttons, inputs, chips and toggles share the control radius. |
| Motion | `MeshMotion`: short, medium and long durations. They become zero when the system asks for reduced motion. |
| States | `EmptyState`, `MeshLoadingState`, `MeshErrorState` and `MeshStatusBanner`, all announced to screen readers. |
| Feedback | `confirmDestructive` (red) and `confirmAction` (primary) for confirmations. `meshSnackBar` and `showDismissibleSnackBar` for messages: tap to dismiss, 4 s, never stuck. `friendlyError` for error text. |
| Badges | `UnreadBadge`: "99+" cap and a spoken count. |

### By the numbers

Counted outside `lib/theme` and generated translations, before stage 1 and after stage 7:

- Hand-set `fontSize:` dropped from 418 to 264. About half of what's left is `MeshTheme.mono` number readouts. The rest are chat bubbles that scale with their own setting, and canvas painters, which have no theme to read.
- `TextStyle(` dropped from 414 to 253. Type-scale references went up to 294.
- Confirmation dialogs: 22 hand-built ones now share one of two patterns.
- Raw snack bars: 39 now go through one builder. 17 error messages no longer show raw exception text.
- Icon buttons with no spoken label: 23 now have one.

### Screens

Every screen moved onto the type scale and the shared shapes. Stage by stage:

- **Shell and Home (stage 2):**
  - More is regrouped into Your station (Licensed operator, Connections), App & settings, and In the field.
  - Ham channels no longer show a padlock or "Private".
  - Home (PR 21) now reads top to bottom in order of urgency:
    1. an active SOS;
    2. the station: readouts, Connect radio when offline, and a station row with the call sign and the first thing stopping it from transmitting (the same check, in the same order, as the warning banner);
    3. Check in and SOS;
    4. the trip;
    5. nearby repeaters and sensors;
    6. field tools.
  - On a fresh install (offline, no contacts, setup not done), Get started moves up under the station row.
- **Chats and Nodes (stage 3):**
  - List rows, unread badges, chat headers, composer, and empty states.
  - Contact rows announce the contact instead of just "button".
- **Settings, Connections, scanner, radio and repeater settings (stage 4).**
- **Tools and maps (stage 5):**
  - Covers path graph, route intelligence, track log, field stats, prefix tool, repeater tools, line of sight, coverage, field ops, diagnostics, networks and Wi-Fi.
  - Shared loading states replace bare spinners.
- **Dialogs, sheets and messages (stage 6):**
  - One confirmation language.
  - Sheets come from the theme: drag handle, 24-pt corners.
- **Accessibility (stage 7):** see below.

### Accessibility

`PREVIEW_A11Y=1 PREVIEW_OUT=<dir> flutter test test/preview` runs Flutter's tap-target, labelled-target and text-contrast guidelines on every preview screen in both a dark theme (Blaze) and a light theme (Bubble Gum). It writes the results to `<dir>/a11y.txt`.

- **Result (re-run with PR 21):** 37 of 54 screen/theme combinations pass all three. The stage 7 run reported 46 of 52 with every combination passing contrast, but its contrast check never ran: the harness wrapped it in a second `runAsync`, which this Flutter version refuses. PR 21 fixes the harness.
- **Contrast, real failures (all in the light theme, Bubble Gum):**
  - Cancel in the confirmation dialogs: 4.39:1.
  - "Clear log" on Networks: 4.11:1.
  - The hex prefix chips on the prefix tool: 3.95:1.
  - These still need a palette fix.
- **Contrast, false positives:** the rest of the contrast failures score 1.0–1.9:1. Every one is a section label or list header drawn straight on the patterned backdrop ("Trip", "Your station", "Near you", "All"). In the screenshots they read clearly. The checker measures the backdrop's pattern, not the text colour, which passes in the same widget elsewhere.
- **Fixed in stage 7:**
  - 23 unlabelled icon buttons now have spoken, translated tooltips: back, close, clear, show/hide password, send location, flashlight and switch camera.
  - Contact rows and the add-contact button now have labels.
  - Region switches are named.
  - Bar-chart rows in path graph and field stats are 48 dp tall and read as one sentence.
  - "Start recording", the scanner action and the channel header are now 48 dp tall.
  - Help and error text under fields wraps instead of being cut off; the limit is set once, in the theme.
  - Two English-only line-of-sight labels are translated.
- **Accepted tap-target exceptions:**
  - Message text in chat bubbles is shorter than 48 dp, because the long-press target for text selection is the text itself. The whole bubble stays tappable.
  - The 24-hour activity chart in field stats has bars narrower than a finger. Each bar has a spoken label ("3 hours ago, 4"), and the same data is also in the lists below it.
- **Large text:** every preview screen renders at 200 % system text without a layout overflow.

### Testing

- `flutter analyze --fatal-infos`: clean.
- `flutter test --exclude-tags=integration`: 1315+ tests passing at each stage. New tests cover the design tokens, shared states, confirmations, snack bars and `friendlyError`.
- Screenshots: `test/preview` with `PREVIEW_THEME` (comma-separated theme ids), `PREVIEW_TEXT_SCALE`, `PREVIEW_LOCALE`, `PREVIEW_HEIGHT` and `PREVIEW_ONLY`.

### Not finished, or needs a real phone

- **On a phone:**
  - TalkBack and VoiceOver walk-throughs of Home, Chats, a chat, Nodes and Settings.
  - 200 % system text on line of sight and the map.
  - Each delete and clear prompt appears once, and the item is gone afterwards.
- **On air:** the two-station test needs radio hardware. It doesn't depend on the redesign, but it's still owed.
- **Preview harness:** the `channels` preview leaves a self-rescheduling service timer pending, so that one preview test reports an error after writing its screenshot. Only the preview harness is affected.
