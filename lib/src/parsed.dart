import 'package:flutter/widgets.dart';
import 'base.dart';
import 'filter.dart';

class ParsedText extends BaseText {
  /// Create a parsed text widget
  const ParsedText(
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
    super.semanticsLabel,
    super.textWidthBasis,
    super.textHeightBehavior,
    super.selectionColor,
    this.highlight,
    this.highlightStyle,
    this.highlightOnTap,
    this.filter = const [],
    this.filterDisabled = false,
    this.caseSensitive = false,
    this.multiLine = false,
    this.unicode = false,
    this.dotAll = false,
  });

  /// The text to highlight
  final String? highlight;

  /// The text style of highlighted text
  final TextStyle? highlightStyle;

  /// Function triggered when a user taps on highlighted text
  final WxTextFilterTap? highlightOnTap;

  /// List of [WxTextFilter] used to filter and control text appearance
  final List<WxTextFilter> filter;

  /// Determines whether the text filter is disabled or not
  final bool filterDisabled;

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

  /// Creates and returns a new [RegExp] object based on the provided [source] string
  /// and optional configuration flags. The [source] string represents the actual regular
  /// expression pattern you want to match against text.
  RegExp createRegExp(String source) => RegExp(
        source,
        multiLine: multiLine,
        caseSensitive: caseSensitive,
        dotAll: dotAll,
        unicode: unicode,
      );

  /// This getter calculates and returns a combined list of [WxTextFilter] objects
  /// representing the actual filters applied to text content.
  List<WxTextFilter> get effectiveFilter {
    // return empty list if filter disabled
    if (filterDisabled) return [];

    final highlightSearch = highlight;
    return [
      ...filter,
      if (highlightSearch != null && highlightSearch.isNotEmpty)
        WxTextFilter.highlight(
          search: highlightSearch,
          style: highlightStyle,
          onTap: highlightOnTap,
        ),
    ];
  }

  /// The text to display.
  ///
  /// This will be null if a [textSpan] is provided instead.
  @override
  String? get data => null;

  /// The text to display as a [InlineSpan].
  ///
  /// This will be null if [data] is provided instead.
  @override
  InlineSpan? get textSpan {
    if (effectiveFilter.isEmpty || text.isEmpty) {
      return TextSpan(text: text);
    }

    final patterns = createRegExp(
      '(${effectiveFilter.map((e) => e.pattern).join('|')})',
    );

    if (!patterns.hasMatch(text)) {
      return TextSpan(text: text);
    }

    final builders = {for (var v in effectiveFilter) v.pattern: v.builder};
    List<InlineSpan> spans = [];
    text.splitMapJoin(
      patterns,
      onMatch: (match) {
        final matchText = match[0]!;
        final pattern = builders.keys.firstWhere((element) {
          return createRegExp(element).hasMatch(matchText);
        });
        final span = builders[pattern]?.call(matchText);
        if (span != null) spans.add(span);
        return '';
      },
      onNonMatch: (nonMatchText) {
        spans.add(TextSpan(text: nonMatchText));
        return '';
      },
    );

    return TextSpan(children: spans);
  }
}
