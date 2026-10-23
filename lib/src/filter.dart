import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

typedef WxTextFilterBuilder = InlineSpan Function(String match);
typedef WxTextFilterTap = void Function(String match);

/// Filter configuration used by [ParsedText] to match patterns in text
/// and format them into interactive [InlineSpan] elements.
class WxTextFilter with Diagnosticable {
  /// Creates a filter with a custom regex [pattern] and [builder].
  const WxTextFilter({
    required this.pattern,
    required this.builder,
  });

  /// Creates a filter that formats matching text into a [TextSpan].
  ///
  /// Defaults [mouseCursor] to [SystemMouseCursors.click] when [onTap] is provided.
  WxTextFilter.textSpan({
    required this.pattern,
    TextStyle? style,
    WxTextFilterTap? onTap,
    MouseCursor? mouseCursor,
  }) : builder = ((match) {
          const TextStyle defaultStyle = TextStyle(color: Color(0xFF2196F3));
          return TextSpan(
            text: match,
            style: style ?? defaultStyle,
            mouseCursor: mouseCursor ??
                (onTap != null ? SystemMouseCursors.click : MouseCursor.defer),
            recognizer: onTap != null
                ? (TapGestureRecognizer()..onTap = () => onTap(match))
                : null,
          );
        });

  /// Factory for matching search strings and applying a highlight style.
  factory WxTextFilter.highlight({
    required String search,
    TextStyle? style,
    WxTextFilterTap? onTap,
    MouseCursor? mouseCursor,
  }) =>
      WxTextFilter.textSpan(
        pattern: RegExp.escape(search),
        style: style ?? const TextStyle(backgroundColor: Color(0xFFFBC02D)),
        onTap: onTap,
        mouseCursor: mouseCursor,
      );

  /// Factory for matching email addresses.
  factory WxTextFilter.email({
    TextStyle? style,
    WxTextFilterTap? onTap,
    MouseCursor? mouseCursor,
  }) =>
      WxTextFilter.textSpan(
        pattern: r"\b[\w\.-]+@[\w\.-]+\.\w{2,4}\b",
        style: style,
        onTap: onTap,
        mouseCursor: mouseCursor,
      );

  /// Factory for matching URLs.
  factory WxTextFilter.url({
    TextStyle? style,
    WxTextFilterTap? onTap,
    MouseCursor? mouseCursor,
  }) =>
      WxTextFilter.textSpan(
        pattern:
            r"[(http(s)?):\/\/(www\.)?a-zA-Z0-9@:._\+-~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:_\+.~#?&\/\/=]*)",
        style: style,
        onTap: onTap,
        mouseCursor: mouseCursor,
      );

  /// Factory for matching `@mention` usernames.
  factory WxTextFilter.mention({
    TextStyle? style,
    WxTextFilterTap? onTap,
    MouseCursor? mouseCursor,
  }) =>
      WxTextFilter.textSpan(
        pattern: r"@[\w\.-]+",
        style: style,
        onTap: onTap,
        mouseCursor: mouseCursor,
      );

  /// Factory for matching `#hashtag` tags.
  factory WxTextFilter.hashtag({
    TextStyle? style,
    WxTextFilterTap? onTap,
    MouseCursor? mouseCursor,
  }) =>
      WxTextFilter.textSpan(
        pattern: r"#[\w\.-]+",
        style: style,
        onTap: onTap,
        mouseCursor: mouseCursor,
      );

  /// Factory for matching phone numbers.
  factory WxTextFilter.phone({
    TextStyle? style,
    WxTextFilterTap? onTap,
    MouseCursor? mouseCursor,
  }) =>
      WxTextFilter.textSpan(
        pattern:
            r"(?:\+?\d{1,4}[-.\s]?)?\(?\d{1,4}\)?[-.\s]?\d{1,4}[-.\s]?\d{1,9}\b",
        style: style,
        onTap: onTap,
        mouseCursor: mouseCursor,
      );

  final String pattern;
  final WxTextFilterBuilder builder;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('pattern', pattern));
    properties
        .add(ObjectFlagProperty<WxTextFilterBuilder>.has('builder', builder));
  }
}
