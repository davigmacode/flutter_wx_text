import 'package:flutter/widgets.dart';
import '../widget.dart';
import 'controller.dart';

/// Function signature for building a custom spoiler widget.
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
    super.maxLines,
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
    super.outlineColor,
    super.outlineWidth,
    super.outlineOffset,
    super.outlineBehind,
    super.gradient,
    super.variant,
    super.color,
    super.backgroundColor,
    super.shadows,
    super.fontFamily,
    super.fontSize,
    super.fontWeight,
    super.fontStyle,
    super.letterSpacing,
    super.wordSpacing,
    super.textBaseline,
    super.height,
    this.expanded = false,
    this.filterDisabledOnCollapsed = false,
    this.duration = const Duration(milliseconds: 200),
    this.wrapper = WxSpoilerText.defaultWrapper,
  });

  /// Determines initial text visibility (expanded or collapsed).
  final bool expanded;

  /// Determines whether to disable all the filter when text collapsed.
  final bool filterDisabledOnCollapsed;

  /// The duration of the whole orchestrated animation.
  final Duration duration;

  /// Callback that builds the final widget
  final WxSpoilerBuilder wrapper;

  /// Default builder that uses GestureDetector to enable tapping on the wrapped content
  static const defaultWrapper = _defaultWrapper;
  static Widget _defaultWrapper(context, text, toggle) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: toggle,
        child: text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // if maxLines null, returns normal text
    if (maxLines == null) return super.build(context);

    // build collapsed widget from this widget with optional disabled filter
    final collapsedText = WxText.from(
      this,
      overflow: overflow ?? TextOverflow.ellipsis,
      filterDisabled: filterDisabledOnCollapsed || filterDisabled,
    );

    // build expanded text from this widget with disabled maxLines and visible overflow
    final expandedText = WxText.from(
      this,
      maxLines: -1,
      overflow: TextOverflow.visible,
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
          secondChild: expandedText,
        );
        return wrapper(context, child, state.toggle);
      }),
    );
  }
}
