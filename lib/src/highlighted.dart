import 'package:flutter/widgets.dart';

/// This widget offers a familiar text display area with
/// the added functionality of highlighting specific portions of the text.
class HighlightedText extends Text {
  /// Create a highlighted text widget
  const HighlightedText(
    this.text, {
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
    super.semanticsLabel,
    super.textWidthBasis,
    super.textHeightBehavior,
    this.highlight,
    this.highlightStyle,
    this.highlightCaseSensitive = false,
  }) : super(text);

  /// The text to display.
  final String text;

  /// The text to highlight
  final String? highlight;

  /// The text style of highlighted text
  final TextStyle? highlightStyle;

  /// Whether the highlighted text match is case sensitive or not
  final bool highlightCaseSensitive;

  /// Default highlight style
  static const TextStyle defaultHighlightStyle = TextStyle(
    backgroundColor: Color(0xFFFBC02D),
  );

  @override
  Widget build(BuildContext context) {
    final q = highlight;
    if (q == null || q.isEmpty || text.isEmpty) {
      return super.build(context);
    }

    final TextStyle highlightedStyle =
        defaultHighlightStyle.merge(highlightStyle);

    final String highlightEscaped = RegExp.escape(q);
    final Pattern pattern = RegExp(
      highlightEscaped,
      caseSensitive: highlightCaseSensitive,
    );
    int start = 0;
    int indexOfHighlight;
    List<TextSpan> spans = [];

    do {
      indexOfHighlight = text.indexOf(pattern, start);
      if (indexOfHighlight < 0) {
        // no highlight
        final content = text.substring(start, text.length);
        spans.add(TextSpan(text: content));
        break;
      }
      if (indexOfHighlight == start) {
        // start with highlight.
        final highlightedText = text.substring(start, start + q.length);
        spans.add(TextSpan(
          text: highlightedText,
          style: highlightedStyle,
        ));
        start += highlightedText.length;
      } else {
        // normal + highlight
        final String normalText = text.substring(start, indexOfHighlight);
        spans.add(TextSpan(text: normalText));
        start += normalText.length;
      }
    } while (true);

    return Text.rich(
      TextSpan(
        children: spans,
        style: style,
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
    );
  }
}
