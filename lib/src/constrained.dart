import 'package:flutter/widgets.dart';
import 'highlighted.dart';

const _transparentColor = Color(0x00000000);

/// The ConstrainedText Widget provides a text entry area
/// with limitations on the number of displayed lines,
/// ensuring content remains concise and visually appealing.
class ConstrainedText extends HighlightedText {
  /// Create a constrained text widget
  const ConstrainedText(
    super.text, {
    super.key,
    super.style,
    super.strutStyle,
    super.textAlign,
    super.textDirection,
    super.textScaler,
    super.locale,
    super.softWrap,
    super.overflow,
    super.maxLines,
    this.minLines = 0,
    super.semanticsLabel,
    super.textWidthBasis,
    super.textHeightBehavior,
    super.highlight,
    super.highlightStyle,
    super.highlightCaseSensitive = false,
  });

  /// Defines the minimum number of lines
  /// the widget will always display,
  /// regardless of the actual text content.
  final int minLines;

  @override
  Widget build(BuildContext context) {
    Widget result = super.build(context);

    if (minLines > 0) {
      result = Stack(
        children: [
          Text(
            '\n' * (minLines - 1),
            style: const TextStyle().merge(style).copyWith(
                  color: _transparentColor,
                  backgroundColor: _transparentColor,
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
          result,
        ],
      );
    }

    return result;
  }
}
