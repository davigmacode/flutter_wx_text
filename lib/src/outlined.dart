import 'package:flutter/widgets.dart';
import 'gradient.dart';

/// The OutlinedText widget is a custom widget
/// that allows you to display text with an outline effect.
/// This can be useful for creating visually distinct text elements
/// or for enhancing readability on certain backgrounds.
class OutlinedText extends GradientText {
  /// Create a outlined text widget
  const OutlinedText(
    super.text, {
    super.key,
    super.strutStyle,
    super.textAlign,
    super.textDirection,
    super.textScaler,
    super.locale,
    super.softWrap,
    super.overflow,
    super.maxLines,
    super.minLines,
    super.semanticsLabel,
    super.textWidthBasis,
    super.textHeightBehavior,
    super.highlight,
    super.highlightStyle,
    super.highlightOnTap,
    super.filter,
    super.filterDisabled,
    super.filterCaseSensitive,
    super.filterMultiLine,
    super.filterUnicode,
    super.filterDotAll,
    super.gradient,
    this.borderColor = const Color(0xFF000000),
    this.borderWidth = 0,
  });

  /// The color of the border.
  final Color borderColor;

  /// The width of the border, in logical pixels.
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    Widget result = super.build(context);

    if (borderWidth > 0) {
      final textStyle = DefaultTextStyle.of(context).style;
      result = Stack(
        children: [
          result,
          Text(
            text,
            style: textStyle.copyWith(
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = borderWidth
                ..color = borderColor,
            ),
            strutStyle: strutStyle,
            textAlign: textAlign,
            textDirection: textDirection,
            textScaler: textScaler,
            locale: locale,
            softWrap: softWrap,
            overflow: overflow,
            maxLines: maxLines,
            semanticsLabel: semanticsLabel,
            textWidthBasis: textWidthBasis,
            textHeightBehavior: textHeightBehavior,
          ),
        ],
      );
    }

    return result;
  }
}
