# Themes

NOTORYX Core Ham offers five themes. They are defined in `lib/theme/bastion_themes.dart`. Each theme is one `BastionPalette`, and that palette feeds both the Material `ColorScheme` (`MeshTheme.forPalette`) and the app's own tokens (`MeshPalette`). Screens never pick colours of their own.

| # | Theme | Look | Light/dark |
|---|---|---|---|
| 1 | **BLACKOUT** (default) | Matte black, charcoal, gunmetal, steel and frost; monochrome | Dark |
| 2 | **Blaze** | Charcoal slate, hi-vis orange | Dark |
| 3 | **Tactical** | Olive, gunmetal, forest, earth | Dark |
| 4 | **Okabe-Ito** | Okabe-Ito hues on blue-grey | Dark |
| 5 | **Night Ops** | Near-black, restrained red | Dark |

## BLACKOUT

The NOTORYX BLACKOUT brand palette:

| Role | Colour | Tokens |
|---|---|---|
| Matte (background) | `#080808` | `bg` |
| Charcoal (surfaces, cards) | `#242424` | `bg3`; `bg1`/`bg2`/`bg4` are steps between |
| Gunmetal (borders, dividers, disabled) | `#484848` | `line2` |
| Steel (secondary text, icons) | `#888888`, lifted to `#9A9A9A` | `ink4` |
| Frost (primary text, primary accent) | `#E8E8E8` | `ink`, `accent`, `nav` |

- There is no brand accent colour: buttons, the selected tab and the backdrop glow are frost.
- Steel is lifted to `#9A9A9A` for text, because `#888888` reaches only 4.35:1 on charcoal.
- `line3` (field and button outlines) is `#7A7A7A` so it reaches 3:1 on every surface.
- Signal (green), warning (amber) and alert (red) keep the same colours as Blaze. They carry meaning, so they are never grey. Map markers, avatar colours and the other fixed colours below don't change either.

## What each palette defines

A palette has 29 colour tokens plus a backdrop motif:

- **Surfaces:** `bg`–`bg4`.
- **Lines:** `line`–`line3`. `line3` is the 3:1 outline for fields and buttons.
- **Text:** `ink`–`ink4`.
- **Status:** `signal`, `warn`, `alert`, each with a dim variant.
- **Actions:** `accent` and `onAccent`.
- **Second hue:** `magenta`.
- **Your own chat bubble:** `me`, `meBorder`, `meInk`.
- **Containers:** primary and secondary.
- **Navigation:** `nav`, the selected tab.

These cover backgrounds, cards, the bottom bar, buttons, text, icons, borders, inputs, chat bubbles and timestamps, connection dots, snack bars, dialogs, selected and disabled states, and warning, error and success.

## Rules every palette meets

`test/theme/bastion_themes_test.dart` checks these for every theme:

- **Text contrast:** at least 4.5:1 on `bg`–`bg3` for every text token and for the status and accent colours.
- **Navigation and second hue:** at least 4.5:1 for `nav` and `magenta` on `bg`/`bg1`.
- **Filled colours:**
  - button text on the accent, at least 4.5:1;
  - your chat bubble text, at least 4.5:1;
  - error text and the error box, at least 4.5:1.
- **Outlines:** `line3` at least 3:1.
- **Alert stays red** (hue under 20° or over 335°), so SOS and errors stay recognisable in every theme. Status is never shown by colour alone: there is always an icon, a word or a shape too.
- **Okabe-Ito:**
  - It uses the reference hues.
  - Vermillion is lightened to `#FF8070`, because the reference vermillion fails 4.5:1 on the dark surfaces. That keeps it more than 25° of hue from the amber warning colour.
  - Map node markers use the reference colours in every theme.

The spec's colours were kept where they passed. Where they didn't, the lightness was nudged and the hue kept. For example:

- BLACKOUT's steel is `#9A9A9A` for text instead of `#888888`.
- Night Ops's outlines are a little lighter than specified.

## Migration from earlier versions

Saved ids map to their replacement in `BastionTheme.fromId`. Themes that were removed open as BLACKOUT, with no error and no reset of other settings:

| Saved | Now |
|---|---|
| `blackout`, or nothing saved (new install) | BLACKOUT |
| `blaze`, `alpine_day` | Blaze |
| `tactical` | Tactical |
| `red_light`, `night_ops` | Night Ops |
| `okabe_ito`, `okabe_ito_slate` | Okabe-Ito |
| `neon_anarchy`, `pink_overload`, `bare_beauty`, `seasonal` (removed) | BLACKOUT |
| `bubble_gum`, `topo_night`, `bronzed_blush`, `autumn_frost`, `christmas` | BLACKOUT |
| anything unknown | BLACKOUT |

The old `seasonal_choice` and `seasonal_holidays` settings are ignored if present.

## Colours deliberately not themed

- **Node markers, route lines and line-of-sight colours on the map.** They carry fixed meanings, and they sit on map tiles rather than on the theme.
- **The dark panel used over dark map tiles.** On light tiles, map panels follow the theme.
- **Per-contact avatar colours.** They identify people, so they must not change with the theme.
- **The first-launch splash.** It is shown before settings load.

## Selector

Settings → Theme shows five cards: two columns on a phone, four on a tablet, and one at very large text. Each card has:

- a miniature drawn in that theme's colours (header, received and sent message, button, status dots, bottom bar);
- the theme's name and a translated description;
- a ring, a tick and the word "Selected" when it's in use.

A change applies instantly and is saved.

## Not verified

- **Real phone:** not tried yet. Screenshots are from the widget-test renderer.
- **System light/dark:** each theme has a fixed brightness, so the system's light/dark setting doesn't switch themes. The app has always worked this way.
