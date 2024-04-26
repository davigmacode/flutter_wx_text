import 'package:flutter/widgets.dart';
import 'constrained.dart';

/// The GradientText widget is a custom widget
/// that allows you to display text filled with a gradient color effect.
/// This can be visually appealing and create a more dynamic look for your text elements.
class GradientText extends ConstrainedText {
  /// Create a gradient text widget
  const GradientText(
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
    super.minLines,
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
    this.gradient,
  });

  /// A gradient to use when filling the text.
  /// If this is specified, [style.color] has no effect.
  final Gradient? gradient;

  @override
  Widget build(BuildContext context) {
    Widget result = super.build(context);

    if (gradient != null) {
      result = ShaderMask(
        blendMode: BlendMode.srcIn,
        shaderCallback: (bounds) => gradient!.createShader(
          Rect.fromLTWH(0, 0, bounds.width, bounds.height),
        ),
        child: result,
      );
    }

    return result;
  }
}
