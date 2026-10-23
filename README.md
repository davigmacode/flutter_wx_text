# wx_text

> [!IMPORTANT]
> **Repository Moved to Monorepo**: Active development of `wx_text` has migrated to the official [**davigmacode/flutter_wx**](https://github.com/davigmacode/flutter_wx) monorepo.
> - Core text package: [`packages/wx_text`](https://github.com/davigmacode/flutter_wx/tree/main/packages/wx_text)
> - Spoiler text package: [`packages/wx_text_spoiler`](https://github.com/davigmacode/flutter_wx/tree/main/packages/wx_text_spoiler)
> - Animated text package: [`packages/wx_text_animated`](https://github.com/davigmacode/flutter_wx/tree/main/packages/wx_text_animated)

[![Pub Version](https://img.shields.io/pub/v/wx_text?color=blue)](https://pub.dev/packages/wx_text)
[![Test](https://github.com/davigmacode/flutter_wx_text/actions/workflows/test.yml/badge.svg)](https://github.com/davigmacode/flutter_wx_text/actions/workflows/test.yml)
[![Coverage](https://codecov.io/gh/davigmacode/flutter_wx_text/branch/main/graph/badge.svg)](https://codecov.io/gh/davigmacode/flutter_wx_text)
[![License](https://img.shields.io/github/license/davigmacode/flutter_wx_text)](https://github.com/davigmacode/flutter_wx_text/blob/main/LICENSE)
[![Buy Me A Coffee](https://badgen.net/badge/icon/buymeacoffee?icon=buymeacoffee&color=yellow&label)](https://www.buymeacoffee.com/davigmacode)
[![Ko-Fi](https://badgen.net/badge/icon/ko-fi?icon=kofi&color=red&label)](https://ko-fi.com/davigmacode)

Supercharge your Flutter text experience. `wx_text` is an all-in-one extension of Flutter's standard `Text` widget, packing **Material 3 typography presets**, **direct style shortcuts**, **regex pattern filtering (URLs, emails, mentions, hashtags)**, **text highlighting**, **pixel-perfect outlines**, **gradient shaders**, **minimum line constraints**, **interactive spoiler/read-more expansion**, and **captivating animations** into a single cohesive API.

[![Preview](https://github.com/davigmacode/flutter_wx_text/raw/main/media/preview.gif)](https://davigmacode.github.io/flutter_wx_text)

🌐 **[Live Web Demo](https://davigmacode.github.io/flutter_wx_text)**

---

## Why wx_text?

Standard Flutter `Text` often requires verbose boilerplate and multiple external dependencies:

```dart
// ❌ Standard Flutter: Verbose, nested boilerplate
Text(
  'Featured Article',
  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
    color: Colors.indigo,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.2,
  ),
);

// ✅ wx_text: Clean, expressive, and concise
WxText.headlineMedium(
  'Featured Article',
  color: Colors.indigo,
  fontWeight: FontWeight.bold,
  letterSpacing: 1.2,
);
```

---

## Features at a Glance

* 🎯 **Zero-Boilerplate Typography**: Pre-built Material 3 constructors (`displayLarge`, `headlineMedium`, `bodySmall`, etc.).
* ⚡ **Direct Style Shortcuts**: Adjust `color`, `fontSize`, `fontWeight`, `shadows`, etc. directly without nesting inside `TextStyle(...)`.
* 🔍 **Smart Parsing & Highlighting**: Highlight keywords or auto-convert URLs, emails, `@mentions`, and `#hashtags` into interactive taps.
* 📏 **Precise Layout Constraints**: Enforce `minLines` calculated from exact font metrics (`preferredLineHeight`).
* 🎨 **Outlines & Gradients**: Span-aware stroke outlines and shader gradients.
* 📖 **Interactive Spoiler / Read More**: Expand and collapse text with smooth cross-fade animations and retained state.
* ✨ **Rich Text Animations**: Integrated shimmer, typewriter, slide, zoom, and shake animations via `animated_repeatable`.
* 🌳 **Contextual Subtree Styling**: Apply consistent variants across descendant widgets using `WxTextStyler`.

---

## Installation

Add `wx_text` to your `pubspec.yaml`:

```yaml
dependencies:
  wx_text: ^3.1.0
```

Import the package:

```dart
import 'package:wx_text/wx_text.dart';
```

---

## Usage Guide & Code Examples

### 1. Typography Presets & Style Shortcuts

Use ready-made Material 3 named constructors and apply style shortcuts directly on the widget:

```dart
// Display typography with color and weight shortcuts
WxText.displayLarge(
  'Trending Today',
  color: Colors.deepPurple,
  fontWeight: FontWeight.w800,
);

// Title typography with custom letter spacing and shadow
WxText.titleMedium(
  'Dashboard Overview',
  letterSpacing: 1.2,
  shadows: [
    Shadow(
      color: Colors.black26,
      blurRadius: 4,
      offset: Offset(0, 2),
    ),
  ],
);
```

### 2. Text Highlighting & Pattern Parsing

Search and highlight keywords, or parse URLs, emails, mentions, and hashtags into interactive clickable spans:

```dart
WxText(
  'Check out @davigma on https://github.com or email contact@example.com! #flutter',
  highlight: 'Check out',
  highlightStyle: TextStyle(
    backgroundColor: Colors.amberAccent,
    fontWeight: FontWeight.bold,
  ),
  filter: [
    WxTextFilter.url(
      onTap: (url) => launchUrl(Uri.parse(url)),
    ),
    WxTextFilter.mention(
      onTap: (user) => print('Tapped user: $user'),
    ),
    WxTextFilter.hashtag(
      onTap: (tag) => print('Tapped hashtag: $tag'),
    ),
    WxTextFilter.phone(
      onTap: (phone) => print('Call phone: $phone'),
    ),
  ],
);
```

You can also define custom regex patterns with `WxTextFilter`:

```dart
WxText(
  'Order #ORD-12345 has been confirmed',
  filter: [
    WxTextFilter(
      pattern: r'#ORD-\d+',
      builder: (match) => TextSpan(
        text: match,
        style: TextStyle(
          color: Colors.green,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  ],
);
```

### 3. Outlined & Gradient Text

Create visually striking headings with outlines and gradient shaders:

```dart
// Gradient Text
WxText.displayMedium(
  'Shaded Gradient',
  gradient: LinearGradient(
    colors: [Colors.purple, Colors.blue, Colors.teal],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
);

// Outlined Text (Span-Aware)
WxText.headlineLarge(
  'Outlined Heading',
  color: Colors.white,
  outlineColor: Colors.black,
  outlineWidth: 2.0,
  outlineOffset: Offset(1.0, 1.0),
  outlineBehind: true,
);
```

### 4. Minimum Line Constraints (`minLines`)

Reserve vertical space for a minimum number of lines based on the resolved font metrics, preventing layout jumps when text loads dynamically:

```dart
WxText(
  'Short description',
  minLines: 3,
  minLinesDebugColor: Colors.grey.withOpacity(0.1), // Optional visual guide
);
```

### 5. Interactive Spoiler / Read More (`WxSpoilerText`)

Create expandable/collapsible text blocks that remember user interaction across rebuilds:

```dart
WxSpoilerText(
  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod '
  'tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, '
  'quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
  maxLines: 2,
  expanded: false,
  duration: Duration(milliseconds: 250),
  onExpanded: (isExpanded) {
    print('Spoiler is now expanded: $isExpanded');
  },
);
```

### 6. Animated Text (`WxAnimatedText`)

Animate text with repeat transitions such as shimmer, typewriter, slide, or shake:

```dart
// Shimmer effect
WxAnimatedText(
  duration: Duration(seconds: 2),
  transition: WxAnimatedText.shimmer(
    colors: [
      Colors.grey.shade400,
      Colors.white,
      Colors.grey.shade400,
    ],
  ),
  child: WxText.headlineMedium('Loading shimmer headline...'),
);

// Typewriter effect
WxAnimatedText(
  duration: Duration(seconds: 3),
  repeat: 1,
  transition: WxAnimatedText.typing(
    trails: '|',
  ),
  child: WxText.bodyLarge('Welcome to wx_text in Flutter!'),
);
```

### 7. Contextual Subtree Typography (`WxTextStyler`)

Apply consistent typography tokens across an entire column or card without wrapping every child individually:

```dart
WxTextStyler(
  variant: WxTextVariant.bodyMedium,
  style: TextStyle(color: Colors.black87),
  child: Column(
    children: [
      Text('Inherits bodyMedium style'),
      WxText('Also inherits bodyMedium with custom overrides', color: Colors.blue),
    ],
  ),
);
```

---

## Migration & Changelog

See the [CHANGELOG.md](CHANGELOG.md) for details on recent updates and migration notes.

---

## Sponsoring & Support

<a href="https://www.buymeacoffee.com/davigmacode" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" height="45"></a>
<a href="https://ko-fi.com/davigmacode" target="_blank"><img src="https://storage.ko-fi.com/cdn/brandasset/kofi_s_tag_white.png" alt="Ko-Fi" height="45"></a>

If this package helps you build better Flutter applications, please consider supporting its ongoing development and maintenance!
