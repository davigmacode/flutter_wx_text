import 'package:flutter/widgets.dart';

class BaseText extends Text {
  /// Create a base text widget
  const BaseText(
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
    super.selectionColor,
  }) : super(text);

  /// The text to display.
  final String text;
}
