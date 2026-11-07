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
| 2 | Shell and navigation: More reorganised (a Station group with Licensed operator, Connections and Radio), Home hierarchy, no "Private" padlocks for ham channels | Done, except Home (PR 8) |
| 3 | Chats and Nodes: list rows, chat headers, composer, empty states | |
| 4 | Settings, Connections, scanner, radio and repeater settings | Scanner done (PR 8) |
| 5 | Tools: field ops, wardrive, track log, diagnostics, path and route tools, maps | |
| 6 | Dialogs, sheets and snackbars app-wide; destructive confirmations | |
| 7 | Accessibility pass (text scale, touch targets, semantics), screenshots, write-up | |

Each stage ends with `flutter analyze`, the full test suite, and screenshots from `test/preview`. Anything that needs a real phone or radio to verify is listed in that stage's PR.
