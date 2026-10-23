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
    super.minLinesDebugColor,
    super.semanticsLabel,
    super.textWidthBasis,
    super.textHeightBehavior,
    super.selectionColor,
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
    this.outlineBehind = false,
  });

  /// The color of the text outline.
  final Color outlineColor;

  /// The width of the text outline, in logical pixels.
  final double outlineWidth;

  /// Controls the distance between the text content and its outline in a widget.
  /// It accepts an Offset object, which represents a two-dimensional displacement
  /// in terms of horizontal (dx) and vertical (dy) distances.
  final Offset outlineOffset;

  /// Whether the outline position is behind the text.
  final bool outlineBehind;

  static InlineSpan _applyOutlineStyle(InlineSpan span, Paint outlinePaint) {
    if (span is TextSpan) {
      final style = span.style;
      final newStyle = (style ?? const TextStyle()).copyWith(
        foreground: outlinePaint,
        color: null,
        shadows: const [],
        backgroundColor: null,
      );
      return TextSpan(
        text: span.text,
        children: span.children
            ?.map((child) => _applyOutlineStyle(child, outlinePaint))
            .toList(),
        style: newStyle,
      );
    }
    return span;
  }

  @override
  Widget build(BuildContext context) {
    Widget result = super.build(context);

    if (outlineWidth > 0) {
      final textStyle = DefaultTextStyle.of(context).style;
      final strokePaint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = outlineWidth
        ..color = outlineColor;

      final strokeStyle = textStyle.copyWith(
        foreground: strokePaint,
        shadows: const [],
      );

      final span = textSpan;
      final Widget outlineWidget;
      if (span != null) {
        outlineWidget = Text.rich(
          _applyOutlineStyle(span, strokePaint) as TextSpan,
          style: strokeStyle,
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
        );
      } else {
        outlineWidget = Text(
          text,
          style: strokeStyle,
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
        );
      }

      final textOutline = outlineOffset == Offset.zero
          ? outlineWidget
          : Transform.translate(
              offset: outlineOffset,
              child: outlineWidget,
            );

      result = Stack(
        children: [
          if (outlineBehind == true) textOutline,
          result,
          if (outlineBehind == false) textOutline,
        ],
      );
    }

    return result;
  }
}
