import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

typedef WxTextFilterBuilder = InlineSpan Function(String match);
typedef WxTextFilterTap = void Function(String match);

class WxTextFilter with Diagnosticable {
  const WxTextFilter({
    required this.pattern,
    required this.builder,
  });

  WxTextFilter.textSpan({
    required this.pattern,
    TextStyle? style,
    WxTextFilterTap? onTap,
  }) : builder = ((match) {
          const TextStyle defaultStyle = TextStyle(color: Color(0xFF2196F3));
          return TextSpan(
            text: match,
            style: style ?? defaultStyle,
            recognizer: onTap != null
                ? (TapGestureRecognizer()..onTap = () => onTap(match))
                : null,
          );
        });

  factory WxTextFilter.highlight({
    required String search,
    TextStyle? style,
    WxTextFilterTap? onTap,
  }) =>
      WxTextFilter.textSpan(
        pattern: RegExp.escape(search),
        style: style ?? const TextStyle(backgroundColor: Color(0xFFFBC02D)),
        onTap: onTap,
      );

  factory WxTextFilter.email({
    TextStyle? style,
    WxTextFilterTap? onTap,
  }) =>
      WxTextFilter.textSpan(
        pattern: r"\b[\w\.-]+@[\w\.-]+\.\w{2,4}\b",
        style: style,
        onTap: onTap,
      );

  factory WxTextFilter.url({
    TextStyle? style,
    WxTextFilterTap? onTap,
  }) =>
      WxTextFilter.textSpan(
        pattern:
            r"[(http(s)?):\/\/(www\.)?a-zA-Z0-9@:._\+-~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:_\+.~#?&\/\/=]*)",
        style: style,
        onTap: onTap,
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
