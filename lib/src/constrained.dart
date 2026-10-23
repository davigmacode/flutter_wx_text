import 'package:flutter/widgets.dart';
import 'parsed.dart';

/// The ConstrainedText Widget provides a text entry area
/// with limitations on the number of displayed lines,
/// ensuring content remains concise and visually appealing.
class ConstrainedText extends ParsedText {
  /// Create a constrained text widget
  const ConstrainedText(
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
    this.minLines = 0,
    this.minLinesDebugColor,
    super.semanticsLabel,
    super.textWidthBasis,
    super.textHeightBehavior,
    super.selectionColor,
    super.highlight,
    super.highlightStyle,
    super.highlightOnTap,
    super.filter,
    super.filterDisabled,
    bool filterCaseSensitive = false,
    bool filterMultiLine = false,
    bool filterUnicode = false,
    bool filterDotAll = false,
  }) : super(
          caseSensitive: filterCaseSensitive,
          multiLine: filterMultiLine,
          unicode: filterUnicode,
          dotAll: filterDotAll,
        );

  /// Defines the minimum number of lines
  /// the widget will always display,
  /// regardless of the actual text content.
  final int minLines;

  /// This property defines the background color used to highlight
  /// the area where the minimum number of lines of text will be displayed.
  /// It's helpful for visually debugging layouts that rely on
  /// a specific number of text lines being shown.
  final Color? minLinesDebugColor;

  @override
  Widget build(BuildContext context) {
    Widget result = super.build(context);

    if (minLines > 0) {
      final defaultTextStyle = DefaultTextStyle.of(context);
      TextStyle effectiveTextStyle = style ?? const TextStyle();
      if (style == null || style!.inherit) {
        effectiveTextStyle = defaultTextStyle.style.merge(style);
      }
      final effectiveScaler =
          textScaler ?? MediaQuery.maybeTextScalerOf(context) ?? TextScaler.noScaling;
      final effectiveDirection =
          textDirection ?? Directionality.maybeOf(context) ?? TextDirection.ltr;

      final textPainter = TextPainter(
        text: TextSpan(text: ' ', style: effectiveTextStyle),
        textDirection: effectiveDirection,
        textScaler: effectiveScaler,
        strutStyle: strutStyle,
        locale: locale,
      )..layout();
      final minHeight = textPainter.preferredLineHeight * minLines;
      textPainter.dispose();

      result = ConstrainedBox(
        constraints: BoxConstraints(minHeight: minHeight),
        child: result,
      );

      if (minLinesDebugColor != null) {
        result = ColoredBox(
          color: minLinesDebugColor!,
          child: result,
        );
      }
    }

    return result;
  }
}
