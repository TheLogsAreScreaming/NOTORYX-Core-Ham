# Themes

NOTORYX Core Ham offers exactly eight themes. They are defined in `lib/theme/bastion_themes.dart`, with Seasonal's looks in `lib/theme/seasonal_theme.dart`. Each theme is one `BastionPalette`, and that palette feeds both the Material `ColorScheme` (`MeshTheme.forPalette`) and the app's own tokens (`MeshPalette`). Screens never pick colours of their own.

| # | Theme | Look | Light/dark |
|---|---|---|---|
| 1 | **Blaze** (default) | Charcoal slate, hi-vis orange | Dark |
| 2 | **Neon Anarchy** | Toxic green actions, electric-purple navigation, faint terminal grid | Dark |
| 3 | **Tactical** | Olive, gunmetal, forest, earth | Dark |
| 4 | **Pink Overload** | Hot pink, bubblegum, lavender, small sparkles | Light |
| 5 | **Bare Beauty** | Warm nude and peach, dusty rose, cocoa, sage/hazel | Light |
| 6 | **Okabe-Ito** | Okabe-Ito hues on blue-grey | Dark |
| 7 | **Night Ops** | Near-black, restrained red | Dark |
| 8 | **Seasonal** | Changes with the date (below) | Varies |

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

`test/theme/bastion_themes_test.dart` checks these for all 7 fixed themes and all 7 Seasonal looks:

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

- Pink Overload's text-weight pink is `#B00062`; the brighter `#FF1493` is kept for accents and glows.
- Night Ops's outlines are a little lighter than specified.

## Seasonal

- **Automatic** follows the local date using meteorological seasons for the northern hemisphere:

  | Season | Months | Colours |
  |---|---|---|
  | Spring | March–May | sage, lavender, pale yellow, floral pink |
  | Summer | June–August | ocean teal, turquoise, coral, warm sand |
  | Autumn | September–November | burnt orange, amber, forest green, deep brown |
  | Winter | December–February | ice blue, navy, silver, frost white |

- **Holiday colours** is an optional switch, off by default, and applies only in Automatic:

  | Holiday | Dates | Colours |
  |---|---|---|
  | Halloween | 24–31 October | black, purple, pumpkin |
  | Christmas | 1–26 December | evergreen, cranberry, gold |
  | Valentine's Day | 7–14 February | rose, blush, burgundy |

- **Override:** a season can be picked instead of Automatic.
- **Saved in settings:** `seasonal_choice` (`auto` or a season id) and `seasonal_holidays`.
- **Date changes:** the date is checked again when the app comes back to the foreground. No other theme ever reads the date.

## Migration from earlier versions

Saved ids map to their replacement in `BastionTheme.fromId`, so nobody's choice is reset to the default:

| Saved | Now |
|---|---|
| `blaze` | Blaze |
| `bubble_gum`, `topo_night` | Pink Overload |
| `bronzed_blush` | Bare Beauty |
| `red_light` | Night Ops |
| `okabe_ito`, `okabe_ito_slate` | Okabe-Ito |
| `autumn_frost`, `christmas` | Seasonal |
| anything unknown | Blaze |

## Colours deliberately not themed

- **Node markers, route lines and line-of-sight colours on the map.** They carry fixed meanings, and they sit on map tiles rather than on the theme.
- **The dark panel used over dark map tiles.** On light tiles, map panels follow the theme.
- **Per-contact avatar colours.** They identify people, so they must not change with the theme.
- **The first-launch splash.** It is shown before settings load.

## Selector

Settings → Theme shows eight cards: two columns on a phone, four on a tablet, and one at very large text. Each card has:

- a miniature drawn in that theme's colours (header, received and sent message, button, status dots, bottom bar);
- the theme's name and a translated description;
- a ring, a tick and the word "Selected" when it's in use.

A change applies instantly and is saved. With Seasonal chosen, the season chips and the holiday switch appear under the cards.

## Not verified

- **Real phone:** not tried yet. Screenshots are from the widget-test renderer.
- **System light/dark:** each theme has a fixed brightness, so the system's light/dark setting doesn't switch themes. The app has always worked this way.
