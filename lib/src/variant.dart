import 'package:flutter/material.dart';

typedef WxTextVariantBuilder = TextStyle? Function(BuildContext context);

/// Definitions for the various typographical styles found in Material Design
/// (e.g., labelLarge, bodySmall). Rather than creating a [TextTheme] directly,
/// you can obtain an instance as [Typography.black] or [Typography.white].
abstract class WxTextVariant {
  static const displayLarge = _displayLarge;
  static TextStyle? _displayLarge(BuildContext context) {
    return Theme.of(context).textTheme.displayLarge;
  }

  static const displayMedium = _displayMedium;
  static TextStyle? _displayMedium(BuildContext context) {
    return Theme.of(context).textTheme.displayMedium;
  }

  static const displaySmall = _displaySmall;
  static TextStyle? _displaySmall(BuildContext context) {
    return Theme.of(context).textTheme.displaySmall;
  }

  static const headlineLarge = _headlineLarge;
  static TextStyle? _headlineLarge(BuildContext context) {
    return Theme.of(context).textTheme.headlineLarge;
  }

  static const headlineMedium = _headlineMedium;
  static TextStyle? _headlineMedium(BuildContext context) {
    return Theme.of(context).textTheme.headlineMedium;
  }

  static const headlineSmall = _headlineSmall;
  static TextStyle? _headlineSmall(BuildContext context) {
    return Theme.of(context).textTheme.headlineSmall;
  }

  static const bodyLarge = _bodyLarge;
  static TextStyle? _bodyLarge(BuildContext context) {
    return Theme.of(context).textTheme.bodyLarge;
  }

  static const bodyMedium = _bodyMedium;
  static TextStyle? _bodyMedium(BuildContext context) {
    return Theme.of(context).textTheme.bodyMedium;
  }

  static const bodySmall = _bodySmall;
  static TextStyle? _bodySmall(BuildContext context) {
    return Theme.of(context).textTheme.bodySmall;
  }

  static const labelLarge = _labelLarge;
  static TextStyle? _labelLarge(BuildContext context) {
    return Theme.of(context).textTheme.labelLarge;
  }

  static const labelMedium = _labelMedium;
  static TextStyle? _labelMedium(BuildContext context) {
    return Theme.of(context).textTheme.labelMedium;
  }

  static const labelSmall = _labelSmall;
  static TextStyle? _labelSmall(BuildContext context) {
    return Theme.of(context).textTheme.labelSmall;
  }

  static const titleLarge = _titleLarge;
  static TextStyle? _titleLarge(BuildContext context) {
    return Theme.of(context).textTheme.titleLarge;
  }

  static const titleMedium = _titleMedium;
  static TextStyle? _titleMedium(BuildContext context) {
    return Theme.of(context).textTheme.titleMedium;
  }

  static const titleSmall = _titleSmall;
  static TextStyle? _titleSmall(BuildContext context) {
    return Theme.of(context).textTheme.titleSmall;
  }
}
