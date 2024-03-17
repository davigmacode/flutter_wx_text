import 'package:flutter/widgets.dart';
import 'filter.dart';

class ParsedText extends Text {
  /// Create a parsed text widget
  const ParsedText(
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
    this.highlightOnTap,
    this.filter = const [],
    this.caseSensitive = false,
    this.multiLine = false,
    this.unicode = false,
    this.dotAll = false,
  }) : super(text);

  /// The text to display.
  final String text;

  /// The text to highlight
  final String? highlight;

  /// The text style of highlighted text
  final TextStyle? highlightStyle;

  /// Function triggered when a user taps on highlighted text
  final WxTextFilterTap? highlightOnTap;

  final List<WxTextFilter> filter;

  /// If [filter] not empty,
  /// then Dart ignores the case of letters when matching.
  /// For example, with caseSensitive disable,
  /// the `regexp` pattern `a` matches both `a` and `A`.
  final bool caseSensitive;

  /// If [filter] not empty,
  /// then `^` and `$` will match the beginning and end of a line,
  /// as well as matching beginning and end of the input, respectively.
  final bool multiLine;

  /// If [filter] not empty,
  /// then Dart treats the pattern as a Unicode pattern per the ECMAScript standard.
  final bool unicode;

  /// If [filter] not empty,
  /// then the `.` pattern will match all characters,
  /// including line terminators.
  final bool dotAll;

  @override
  Widget build(BuildContext context) {
    final highlightSearch = highlight;
    final effectiveFilter = [
      ...filter,
      if (highlightSearch != null && highlightSearch.isNotEmpty)
        WxTextFilter.highlight(
          search: highlightSearch,
          style: highlightStyle,
          onTap: highlightOnTap,
        ),
    ];

    if (effectiveFilter.isEmpty || text.isEmpty) {
      return super.build(context);
    }

    final patterns = RegExp(
      '(${effectiveFilter.map((e) => e.pattern).join('|')})',
      multiLine: multiLine,
      caseSensitive: caseSensitive,
      unicode: unicode,
      dotAll: dotAll,
    );

    if (!patterns.hasMatch(text)) {
      return super.build(context);
    }

    List<InlineSpan> spans = [];

    final builders = {for (var v in effectiveFilter) v.pattern: v.builder};

    text.splitMapJoin(
      patterns,
      onMatch: (match) {
        final matchText = match[0]!;
        final pattern = builders.keys.firstWhere((element) {
          final reg = RegExp(
            element,
            multiLine: multiLine,
            caseSensitive: caseSensitive,
            dotAll: dotAll,
            unicode: unicode,
          );
          return reg.hasMatch(matchText);
        });
        final span = builders[pattern]?.call(matchText);
        if (span != null) {
          spans.add(span);
        }
        return '';
      },
      onNonMatch: (nonMatchText) {
        spans.add(TextSpan(text: nonMatchText));
        return '';
      },
    );

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
