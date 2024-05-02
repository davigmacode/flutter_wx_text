import 'package:flutter/widgets.dart';
import '../widget.dart';
import 'controller.dart';

/// Function signature for building a custom spoiler widget.
typedef WxSpoilerBuilder = Widget Function(
  BuildContext context,
  Widget text,
  VoidCallback toggle,
);

/// A widget that extends [WxText] to provide dynamic text expansion/collapse functionality.
///
/// This widget allows users to reveal or hide text content through a tap interaction.
/// It's ideal for displaying sensitive information or lengthy text snippets that
/// can be gradually revealed upon user request.
class WxSpoilerText extends WxText {
  /// Creates a collapsible text widget.
  ///
  /// Inherits all properties from [WxText] for styling and text content.
  ///
  /// * [text]: The text content to be displayed.
  /// * [key]: A unique key for the widget (optional).
  /// * [style]: The text style (optional).
  /// * [strutStyle]: The strut style for text layout (optional).
  /// * [textAlign]: The text alignment (optional).
  /// * [textDirection]: The text direction (optional).
  /// * [textScaler]: The text scaler (optional).
  /// * [locale]: The locale for text rendering (optional).
  /// * [softWrap]: Whether to allow soft wrapping of text (optional).
  /// * [overflow]: How to handle overflowing text (optional).
  /// * [maxLines]: The maximum number of lines to display (optional).
  /// * [semanticsLabel]: The semantic label for accessibility (optional).
  /// * [textWidthBasis]: The basis for calculating text width (optional).
  /// * [textHeightBehavior]: How to handle text height (optional).
  /// * [selectionColor]: The color for text selection (optional).
  /// * [highlight]: Whether to highlight the text (optional).
  /// * [highlightStyle]: The style for text highlighting (optional).
  /// * [highlightOnTap]: Whether to highlight the text on tap (optional).
  /// * [filter]: A regular expression for text filtering (optional).
  /// * [filterDisabled]: Whether to disable text filtering entirely (optional).
  /// * [filterCaseSensitive]: Whether the filter should be case-sensitive (optional).
  /// * [filterMultiLine]: Whether the filter should match across multiple lines (optional).
  /// * [filterUnicode]: Whether the filter should support Unicode characters (optional).
  /// * [filterDotAll]: Whether the `.` character in the filter should match any character (optional).
  /// * [outlineColor]: The color of the text outline (optional).
  /// * [outlineWidth]: The width of the text outline (optional).
  /// * [outlineOffset]: The offset of the text outline (optional).
  /// * [outlineBehind]: Whether to draw the outline behind the text (optional).
  /// * [gradient]: A gradient to apply to the text (optional).
  /// * [variant]: The text variant (optional).
  /// * [color]: The text color (optional).
  /// * [backgroundColor]: The background color for the text (optional).
  /// * [shadows]: A list of text shadows (optional).
  /// * [fontFamily]: The font family for the text (optional).
  /// * [fontSize]: The font size for the text (optional).
  /// * [fontWeight]: The font weight for the text (optional).
  /// * [fontStyle]: The font style for the text (optional).
  /// * [letterSpacing]: The spacing between letters (optional).
  /// * [wordSpacing]: The spacing between words (optional).
  /// * [textBaseline]: The text baseline for text alignment (optional).
  /// * [height]: The height of the widget (optional).
  /// * [expanded] (optional): The initial visibility state of the text. Defaults to `false` (collapsed).
  /// * [onExpanded] (optional): A callback function invoked when the text expands or collapses.
  /// Receives the new visibility state (`true` for expanded, `false` for collapsed).
  /// * [filterDisabledOnCollapsed] (optional): Whether to disable text filtering when
  /// the text is collapsed. Defaults to `false`.
  /// * [duration] (optional): The duration of the expansion/collapse animation. Defaults to 200 milliseconds.
  /// * [wrapper] (optional): A callback that builds the final widget around the spoiler text.
  /// Defaults to a `GestureDetector` for tapping to toggle visibility.
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
    this.onExpanded,
    this.filterDisabledOnCollapsed = false,
    this.duration = const Duration(milliseconds: 200),
    this.wrapper = WxSpoilerText.defaultWrapper,
  });

  /// Determines initial text visibility (expanded or collapsed).
  final bool expanded;

  /// A callback function that is invoked whenever the `expanded` property changes.
  ///
  /// This can be used to update the UI of widgets that are listening to changes
  /// in the spoiler's visibility state. The callback receives the new visibility
  /// state (`true` for expanded, `false` for collapsed).
  final ValueSetter? onExpanded;

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
