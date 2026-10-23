## 3.1.0

* **Dependency**: Upgraded to `animated_repeatable: ^1.2.0` with support for `disableAnimations`.
* **SDK Alignment**: Updated environment SDK constraint to `sdk: '>=3.0.0 <4.0.0'` and upgraded to `flutter_lints: ^5.0.0`.
* **Cloning & Overrides**: Added `WxText.copyWith(...)` for convenient widget reproduction with selective property modifications.
* **New Filters**: Added `WxTextFilter.mention`, `WxTextFilter.hashtag`, and `WxTextFilter.phone` for rich interactive text parsing.
* **Interactivity**: Added `mouseCursor` parameter on `WxTextFilter`, defaulting to `SystemMouseCursors.click` for clickable spans on Web and Desktop.
* **Bug Fix**: Fixed `onExpanded` callback not being invoked in `WxSpoilerText`.
* **Stability**: Refactored `WxSpoilerText` to maintain expanded state across parent widget rebuilds and properly dispose `WxSpoilerController`.
* **Low-Level Layout**: Replaced `ConstrainedText` dummy newline stack with direct line-height measurement (`TextPainter.preferredLineHeight`) via `ConstrainedBox`.
* **Fidelity**: Upgraded `OutlinedText` to preserve `InlineSpan` (highlights, email/URL/mention filters, custom spans, and safe `WidgetSpan` sizing) across stroke outline rendering.
* **Performance**: Optimized `WxText.build` by removing nested `WxTextStyler` wrapper layers and caching regex compilation in `ParsedText`.
* **Documentation**: Overhauled `README.md` with complete code snippets for all features and typography presets.
* **Testing & Coverage**: Added comprehensive test suite with 93.1% code coverage, CI workflow, and coverage badges.
* **Controller Improvements**: Added optional `controller` parameter to `WxSpoilerText`, and added `expand()`, `collapse()`, and reactive `set expanded` to `WxSpoilerController`.
* **Diagnostics**: Added `debugFillProperties` on `WxText` for seamless debugging in Flutter DevTools Widget Inspector.

## 3.0.0

* Added supports for text outline and gradient
* Added supports for animated text
* Added style shortcuts
* Added constructor to create from another instance configuration
* Added option to debug min lines
* Refactor spoiler text, use maxLines instead of trimLines, renamed builder to wrapper
* Refactor parsed text, added base text, and added selectionColor

## 2.0.2

* Adjust sdk constraints

## 2.0.1

* Removed screenshots and example to reduces package size

## 2.0.0

* Changed parameter `highlightCaseSensitive` with `filterCaseSensitive`
* Implemented an advanced text parsing widget with pattern highlighting capabilities
* Added spoiler text

## 1.0.0

* Inherits all the functionalities of the standard Text widget.
* Defines the minimum number of lines the widget will always display.
* Allows users to select and highlight specific portions of the text.
* Provides access to a set of pre-defined text styles commonly used in user interfaces.

