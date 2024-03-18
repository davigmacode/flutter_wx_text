[![Pub Version](https://img.shields.io/pub/v/wx_text)](https://pub.dev/packages/wx_text) ![GitHub](https://img.shields.io/github/license/davigmacode/flutter_wx_text) [![GitHub](https://badgen.net/badge/icon/buymeacoffee?icon=buymeacoffee&color=yellow&label)](https://www.buymeacoffee.com/davigmacode) [![GitHub](https://badgen.net/badge/icon/ko-fi?icon=kofi&color=red&label)](https://ko-fi.com/davigmacode)

Introducing WxText, a powerful widget that builds upon the familiar Flutter Text widget, offering additional functionalities for a richer text display experience.

[![Preview](https://github.com/davigmacode/flutter_wx_text/raw/main/media/preview.gif)](https://davigmacode.github.io/flutter_wx_text)

[Demo](https://davigmacode.github.io/flutter_wx_text)

## Features

* **Core Text Functionality**. Inherits all the functionalities of the standard Text widget, including text content, styling, and text direction.
* **Minimum Lines**. Defines the minimum number of lines the widget will always display, ensuring a consistent look and preventing empty space.
* **Text Highlighting**. Allows users to select and highlight specific portions of the text for emphasis or annotation. The highlighted text can be visually distinguished through color customization.
* **Custom Filter**. Offers a powerful API using regular expressions to filter and style text dynamically. Highlight or modify specific patterns within the text, providing granular control over the visual presentation of your content.
* **Predefined Text Styles**. Provides easy access to a set of pre-defined text styles commonly used in user interfaces (e.g., headline, body text, caption).
* **Spoiler Text**. Implements a dynamic text expansion/collapse mechanism controlled by user interaction or specific triggers.

## Usage

To read more about classes and other references used by `wx_text`, see the [API Reference](https://pub.dev/documentation/wx_text/latest/).

```dart
/* spell-checker: disable */
Card(
  child: Padding(
    padding: const EdgeInsets.all(20.0),
    child: WxTextStyler(
      variant: WxTextVariant.bodyLarge,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ListTile(
            title: const WxText.displaySmall('WxText'),
            subtitle: const WxText(
              'A powerful widget that builds upon the familiar Flutter Text widget',
            ),
            trailing: Transform.translate(
              offset: const Offset(10, 0),
              child: Transform.rotate(
                angle: -90 * pi / 180,
                child: const FlutterLogo(size: 70),
              ),
            ),
            contentPadding: EdgeInsets.zero,
          ),
          const SizedBox(height: 20),
          WxSpoilerText(
            'Enhanced text processing with email and URL converted to clickable links, highlighted text, and dynamic text expansion/collapse\n\n'
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.\n\n'
            'https://pub.dev/packages/wx_text\n'
            'https://pub.dev/publishers/widgetarian.com\n'
            'davigmacode@gmail.com\n',
            highlight: 'do',
            trimLines: 5,
            textAlign: TextAlign.justify,
            overflow: TextOverflow.ellipsis,
            filterDisabledOnCollapsed: true,
            filter: [
              WxTextFilter.email(onTap: sendMail),
              WxTextFilter.url(onTap: openURL),
            ],
            builder: (context, text, toggle) {
              return InkWell(
                splashFactory: NoSplash.splashFactory,
                onTap: toggle,
                child: text,
              );
            },
          ),
          const SizedBox(height: 20),
          ColoredBox(
            color: Colors.amber.shade100,
            child: const WxText.labelLarge(
              'Text with a minimum of 3 lines',
              minLines: 3,
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    ),
  ),
)
```

## Sponsoring

<a href="https://www.buymeacoffee.com/davigmacode" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" height="45"></a>
<a href="https://ko-fi.com/davigmacode" target="_blank"><img src="https://storage.ko-fi.com/cdn/brandasset/kofi_s_tag_white.png" alt="Ko-Fi" height="45"></a>

If this package or any other package I created is helping you, please consider to sponsor me so that I can take time to read the issues, fix bugs, merge pull requests and add features to these packages.