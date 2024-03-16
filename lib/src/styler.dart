import 'package:flutter/material.dart';
import 'variant.dart';

/// The text style to apply to descendant [WxText]
/// or [Text] widgets which don't have an explicit style.
class WxTextStyler extends StatelessWidget {
  /// Creates a default text style for the given subtree.
  ///
  /// The [maxLines] property may be null (and indeed defaults to null), but if
  /// it is not null, it must be greater than zero.
  const WxTextStyler({
    super.key,
    this.style,
    this.variant,
    this.textAlign,
    this.softWrap = true,
    this.overflow = TextOverflow.clip,
    this.maxLines,
    this.textWidthBasis = TextWidthBasis.parent,
    required this.child,
  }) : assert(maxLines == null || maxLines > 0);

  /// The variant text style to apply.
  final WxTextVariantBuilder? variant;

  /// The text style to apply.
  final TextStyle? style;

  /// How each line of text in the Text widget should be aligned horizontally.
  final TextAlign? textAlign;

  /// Whether the text should break at soft line breaks.
  ///
  /// If false, the glyphs in the text will be positioned as if there was unlimited horizontal space.
  ///
  /// This also decides the [overflow] property's behavior. If this is true or null,
  /// the glyph causing overflow, and those that follow, will not be rendered.
  final bool softWrap;

  /// How visual overflow should be handled.
  ///
  /// If [softWrap] is true or null, the glyph causing overflow, and those that follow,
  /// will not be rendered. Otherwise, it will be shown with the given overflow option.
  final TextOverflow overflow;

  /// An optional maximum number of lines for the text to span, wrapping if necessary.
  /// If the text exceeds the given number of lines, it will be truncated according
  /// to [overflow].
  ///
  /// If this is 1, text will not wrap. Otherwise, text will be wrapped at the
  /// edge of the box.
  ///
  /// If this is non-null, it will override even explicit null values of
  /// [Text.maxLines].
  final int? maxLines;

  /// The strategy to use when calculating the width of the Text.
  ///
  /// See [TextWidthBasis] for possible values and their implications.
  final TextWidthBasis textWidthBasis;

  /// The widget below this widget in the tree
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final variantStyle = variant?.call(context);
    final effectiveStyle = variantStyle?.merge(style) ?? style;
    return DefaultTextStyle.merge(
      style: effectiveStyle,
      textAlign: textAlign,
      softWrap: softWrap,
      overflow: overflow,
      maxLines: maxLines,
      textWidthBasis: textWidthBasis,
      child: child,
    );
  }
}
