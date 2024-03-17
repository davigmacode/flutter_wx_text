[![Pub Version](https://img.shields.io/pub/v/wx_text)](https://pub.dev/packages/wx_text) ![GitHub](https://img.shields.io/github/license/davigmacode/flutter_wx_text) [![GitHub](https://badgen.net/badge/icon/buymeacoffee?icon=buymeacoffee&color=yellow&label)](https://www.buymeacoffee.com/davigmacode) [![GitHub](https://badgen.net/badge/icon/ko-fi?icon=kofi&color=red&label)](https://ko-fi.com/davigmacode)

Introducing WxText, a powerful widget that builds upon the familiar Flutter Text widget, offering additional functionalities for a richer text display experience.

[![Preview](https://github.com/davigmacode/flutter_wx_text/raw/main/media/preview.jpg)](https://davigmacode.github.io/flutter_wx_text)

[Demo](https://davigmacode.github.io/flutter_wx_text)

## Features

* **Core Text Functionality**. Inherits all the functionalities of the standard Text widget, including text content, styling, and text direction.
* **Minimum Lines**. Defines the minimum number of lines the widget will always display, ensuring a consistent look and preventing empty space.
* **Text Highlighting**. Allows users to select and highlight specific portions of the text for emphasis or annotation. The highlighted text can be visually distinguished through color customization.
* **Predefined Text Styles**. Provides access to a set of pre-defined text styles commonly used in user interfaces (e.g., headline, body text, caption). This simplifies styling text elements and ensures consistency across the application.

## Usage

To read more about classes and other references used by `wx_text`, see the [API Reference](https://pub.dev/documentation/wx_text/latest/).

```dart
/* spell-checker: disable */
Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: <Widget>[
    ColoredBox(
      color: Colors.black12,
      child: WxText.headlineMedium(
        'Text with a minimum of 3 lines',
        minLines: 3,
      ),
    ),
    SizedBox(height: 20),
    WxText.bodyLarge(
      'Highlighted text, Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum',
      highlight: 'dolor',
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    ),
    SizedBox(height: 20),
    WxTextStyler(
      variant: WxTextVariant.headlineLarge,
      child: Wrap(
        spacing: 5,
        children: [
          WxText('Apply'),
          WxText('styles'),
          WxText('to multiple'),
          WxText('text'),
          WxText('widgets'),
        ],
      ),
    ),
  ],
)
```

## Sponsoring

<a href="https://www.buymeacoffee.com/davigmacode" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" height="45"></a>
<a href="https://ko-fi.com/davigmacode" target="_blank"><img src="https://storage.ko-fi.com/cdn/brandasset/kofi_s_tag_white.png" alt="Ko-Fi" height="45"></a>

If this package or any other package I created is helping you, please consider to sponsor me so that I can take time to read the issues, fix bugs, merge pull requests and add features to these packages.