import 'package:flutter/material.dart';

enum _TextVariant { small, medium, large }

abstract class BaseText extends Text {
  const BaseText(
    super.data, {
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
  });

  @protected
  TextStyle? getStyle(TextTheme theme);

  @override
  Widget build(BuildContext context) {
    return Text(
      data!,
      style: getStyle(Theme.of(context).textTheme)?.merge(style),
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

class DisplayText extends BaseText {
  const DisplayText(
    super.data, {
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
  }) : _variant = _TextVariant.medium;

  const DisplayText.large(
    super.data, {
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
  }) : _variant = _TextVariant.large;

  const DisplayText.small(
    super.data, {
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
  }) : _variant = _TextVariant.small;

  final _TextVariant _variant;

  @override
  TextStyle? getStyle(TextTheme theme) {
    switch (_variant) {
      case _TextVariant.large:
        return theme.displayLarge;
      case _TextVariant.medium:
        return theme.displayMedium;
      case _TextVariant.small:
        return theme.displaySmall;
    }
  }
}

class HeadlineText extends BaseText {
  const HeadlineText(
    super.data, {
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
  }) : _variant = _TextVariant.medium;

  const HeadlineText.large(
    super.data, {
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
  }) : _variant = _TextVariant.large;

  const HeadlineText.small(
    super.data, {
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
  }) : _variant = _TextVariant.small;

  final _TextVariant _variant;

  @override
  TextStyle? getStyle(TextTheme theme) {
    switch (_variant) {
      case _TextVariant.large:
        return theme.headlineLarge;
      case _TextVariant.medium:
        return theme.headlineMedium;
      case _TextVariant.small:
        return theme.headlineSmall;
    }
  }
}

class BodyText extends BaseText {
  const BodyText(
    super.data, {
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
  }) : _variant = _TextVariant.medium;

  const BodyText.large(
    super.data, {
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
  }) : _variant = _TextVariant.large;

  const BodyText.small(
    super.data, {
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
  }) : _variant = _TextVariant.small;

  final _TextVariant _variant;

  @override
  TextStyle? getStyle(TextTheme theme) {
    switch (_variant) {
      case _TextVariant.large:
        return theme.bodyLarge;
      case _TextVariant.medium:
        return theme.bodyMedium;
      case _TextVariant.small:
        return theme.bodySmall;
    }
  }
}

class LabelText extends BaseText {
  const LabelText(
    super.data, {
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
  }) : _variant = _TextVariant.medium;

  const LabelText.large(
    super.data, {
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
  }) : _variant = _TextVariant.large;

  const LabelText.small(
    super.data, {
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
  }) : _variant = _TextVariant.small;

  final _TextVariant _variant;

  @override
  TextStyle? getStyle(TextTheme theme) {
    switch (_variant) {
      case _TextVariant.large:
        return theme.labelLarge;
      case _TextVariant.medium:
        return theme.labelMedium;
      case _TextVariant.small:
        return theme.labelSmall;
    }
  }
}

class TitleText extends BaseText {
  const TitleText(
    super.data, {
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
  }) : _variant = _TextVariant.medium;

  const TitleText.large(
    super.data, {
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
  }) : _variant = _TextVariant.large;

  const TitleText.small(
    super.data, {
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
  }) : _variant = _TextVariant.small;

  final _TextVariant _variant;

  @override
  TextStyle? getStyle(TextTheme theme) {
    switch (_variant) {
      case _TextVariant.large:
        return theme.titleLarge;
      case _TextVariant.medium:
        return theme.titleMedium;
      case _TextVariant.small:
        return theme.titleSmall;
    }
  }
}
