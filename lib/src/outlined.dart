import 'package:flutter/widgets.dart';
import 'gradient.dart';
import 'outlined_position.dart';

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
    super.minLinesDebugColor,
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
    this.outlineColor = const Color(0xFF000000),
    this.outlineWidth = 0,
    this.outlineOffset = Offset.zero,
    this.outlinePosition = WxTextOutlinePosition.foreground,
  });

  /// The color of the text outline.
  final Color outlineColor;

  /// The width of the text outline, in logical pixels.
  final double outlineWidth;

  /// Controls the distance between the text content and its outline in a widget.
  /// It accepts an Offset object, which represents a two-dimensional displacement
  /// in terms of horizontal (dx) and vertical (dy) distances.
  final Offset outlineOffset;

  /// Specifies the position of an outline drawn around the text content.
  final WxTextOutlinePosition outlinePosition;

  @override
  Widget build(BuildContext context) {
    Widget result = super.build(context);

    if (outlineWidth > 0) {
      final textStyle = DefaultTextStyle.of(context).style;
      final textOutline = Transform.translate(
        offset: outlineOffset,
        child: Text(
          text,
          style: textStyle.copyWith(
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = outlineWidth
              ..color = outlineColor,
            shadows: [],
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
      );
      result = Stack(
        children: [
          if (outlinePosition.isBackground) textOutline,
          result,
          if (outlinePosition.isForeground) textOutline,
        ],
      );
    }

    return result;
  }
}
