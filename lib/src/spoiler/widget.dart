import 'package:flutter/widgets.dart';
import '../widget.dart';
import 'controller.dart';

typedef WxSpoilerBuilder = Widget Function(
  BuildContext context,
  Widget text,
  VoidCallback toggle,
);

/// An extension of [WxText] that allows expand/collapse text dynamically
class WxSpoilerText extends WxText {
  /// Create an collapsible text widget
  const WxSpoilerText(
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
    super.variant,
    this.expanded = false,
    this.trimLines,
    this.duration = const Duration(milliseconds: 200),
    this.builder = WxSpoilerText.defaultBuilder,
  });

  /// Determines initial text visibility (expanded or collapsed).
  final bool expanded;

  /// Maximum lines shown in collapsed view.
  final int? trimLines;

  /// The duration of the whole orchestrated animation.
  final Duration duration;

  /// Callback that builds the final widget
  final WxSpoilerBuilder builder;

  /// Default builder that uses GestureDetector to enable tapping on the wrapped content
  static const defaultBuilder = _defaultBuilder;
  static Widget _defaultBuilder(context, text, toggle) {
    return GestureDetector(
      onTap: toggle,
      child: text,
    );
  }

  @override
  Widget build(BuildContext context) {
    final collapsedText = WxText(
      text,
      style: style,
      strutStyle: strutStyle,
      textAlign: textAlign,
      textDirection: textDirection,
      textScaler: textScaler,
      locale: locale,
      softWrap: softWrap,
      overflow: overflow,
      semanticsLabel: semanticsLabel,
      textWidthBasis: textWidthBasis,
      textHeightBehavior: textHeightBehavior,
      highlight: highlight,
      highlightStyle: highlightStyle,
      highlightOnTap: highlightOnTap,
      filter: filter,
      filterDisabled: filterDisabled,
      filterCaseSensitive: caseSensitive,
      filterMultiLine: multiLine,
      filterUnicode: unicode,
      filterDotAll: dotAll,
      variant: variant,
      maxLines: trimLines,
    );
    final expandedWidget = WxText(
      text,
      style: style,
      strutStyle: strutStyle,
      textAlign: textAlign,
      textDirection: textDirection,
      textScaler: textScaler,
      locale: locale,
      softWrap: softWrap,
      semanticsLabel: semanticsLabel,
      textWidthBasis: textWidthBasis,
      textHeightBehavior: textHeightBehavior,
      highlight: highlight,
      highlightStyle: highlightStyle,
      highlightOnTap: highlightOnTap,
      filter: filter,
      filterDisabled: filterDisabled,
      filterCaseSensitive: caseSensitive,
      filterMultiLine: multiLine,
      filterUnicode: unicode,
      filterDotAll: dotAll,
      variant: variant,
    );
    return WxSpoilerProvider(
      controller: WxSpoilerController(
        expanded: expanded,
      ),
      child: Builder(builder: (context) {
        final state = WxSpoilerProvider.of(context);
        final child = AnimatedCrossFade(
          duration: duration,
          crossFadeState: state.expanded
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          firstChild: collapsedText,
          secondChild: expandedWidget,
        );
        return builder(context, child, state.toggle);
      }),
    );
  }
}
