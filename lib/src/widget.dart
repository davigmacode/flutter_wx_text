import 'package:flutter/widgets.dart';
import 'constrained.dart';
import 'variant.dart';
import 'styler.dart';

/// A powerful widget that builds upon
/// the familiar Flutter Text widget,
/// offering additional functionalities
/// for a richer text display experience.
class WxText extends ConstrainedText {
  /// Create an extended text widget
  const WxText(
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
    super.minLines,
    super.semanticsLabel,
    super.textWidthBasis,
    super.textHeightBehavior,
    super.highlight,
    super.highlightStyle,
    super.highlightCaseSensitive,
    this.variant,
  });

  /// The variant text style to apply.
  final WxTextVariantBuilder? variant;

  @override
  Widget build(BuildContext context) {
    return WxTextStyler(
      style: style,
      variant: variant,
      child: super.build(context),
    );
  }
}
