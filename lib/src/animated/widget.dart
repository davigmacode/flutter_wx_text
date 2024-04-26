import 'package:loop_transition/loop_transition.dart';
import 'package:flutter/widgets.dart';
import '../widget.dart';

/// Used within the WxAnimatedText widget to specify
/// the animation function that controls how the text widget
/// is transformed during the animation cycle.
typedef WxAnimatedTextTransition = LoopTransitionBuilder;

/// This class is used to create animated text widgets in Flutter.
/// It inherits from the WxText class and adds the ability to specify
/// an animation function that controls how the text widget
/// is transformed during the animation cycle.
class WxAnimatedText extends WxText {
  /// Create an animated text widget
  const WxAnimatedText(
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
    super.highlightOnTap,
    super.filter,
    super.filterDisabled,
    super.filterCaseSensitive,
    super.filterMultiLine,
    super.filterUnicode,
    super.filterDotAll,
    super.borderColor,
    super.borderWidth,
    super.gradient,
    super.variant,
    this.pause = false,
    this.delay = Duration.zero,
    this.duration = const Duration(milliseconds: 200),
    this.curve = Curves.linear,
    this.repeat = -1,
    this.forward = true,
    this.reverse = false,
    this.transition = WxAnimatedText.fade,
  });

  /// When set to true, the animation playback is paused.
  /// When set to false (default), the animation plays normally
  /// according to the defined loop count [repeat].
  final bool pause;

  /// The delay before the animation starts.
  final Duration delay;

  /// The [duration] of the animation.
  final Duration duration;

  /// The [curve] of the animation. By default it's [Curves.linear].
  final Curve curve;

  /// Controls how many times the animation repeats.
  /// You can set it to repeat indefinitely by using repeat: `-1`,
  /// a specific number of times, or zero for a single play-through (repeat: `0`).
  final int repeat;

  /// Defaults to true. When set to true, the animation plays forward as defined by
  /// the provided transition function (e.g., fading in for LoopTransition.fade).
  ///
  /// When both [forward] and [reverse] are `true`,
  /// the animation plays forward for a while (defined by the animation duration)
  /// and then immediately switches to playing in reverse for the same duration.
  /// This creates a mirroring effect as the animation goes back and forth
  /// between its starting and ending states within a single loop iteration.
  final bool forward;

  /// Defaults to false. When set to true, the animation plays in reverse order.
  /// This means the transition function would be applied in a reversed manner.
  /// For example, with LoopTransition.fade and reverse: true,
  /// the child widget would start fully opaque and fade out during the animation.
  ///
  /// When both [forward] and [reverse] are `true`,
  /// the animation plays forward for a while (defined by the animation duration)
  /// and then immediately switches to playing in reverse for the same duration.
  /// This creates a mirroring effect as the animation goes back and forth
  /// between its starting and ending states within a single loop iteration.
  final bool reverse;

  /// Defines the type of animation applied to the child widget.
  /// By default, it uses a fade transition (LoopTransition.fade).
  /// You can potentially provide your own custom transition function here.
  final WxAnimatedTextTransition transition;

  /// Provides a convenient way to create basic sliding animations
  /// for your text widget within the `WxAnimatedText` widget.
  /// Control the direction and distance of the slide using the [to] and [from] offsets.
  ///
  /// **[to]** (required, Offset) : Defines the ending position of
  /// the slide animation relative to the text widget's original location.
  /// This offset specifies the horizontal and vertical movement
  /// of the text widget during the animation.
  ///
  /// **[from]** (optional, Offset, defaults to Offset.zero) :
  /// Defines the starting position of the slide animation relative to
  /// the text widget's original location. Defaults to Offset.zero,
  /// which means the animation starts with the text widget in its original position.
  static const slide = LoopTransition.slide;

  /// Creates a transition builder that produces a zooming effect on the text widget.
  ///
  /// **[from]** (optional, double) : Defines the starting scale of the text widget
  /// during the animation cycle. Defaults to 0.0, which means the text widget starts off
  /// completely zoomed out (invisible).
  ///
  /// **[to]** (optional, double) : Defines the ending scale of the text widget
  /// during the animation cycle. Defaults to 1.0, which means the text widget ends up
  /// at its original size.
  static const zoom = LoopTransition.zoom;

  /// Creates a transition builder specifically
  /// designed for creating a shimmering effect.
  ///
  /// **[colors]** (required, List<Color>) : A list of colors
  /// used to create the shimmering effect. The animation cycles
  /// through these colors to produce the shimmer.
  ///
  /// **[stops]** (optional, List<double>) : A list of values between 0.0 and 1.0
  /// that specify the position of each color within the gradient. If omitted,
  /// colors will be spread evenly.
  ///
  /// **[begin]** (optional, AlignmentGeometry) : Defines the starting point of
  /// the shimmer gradient. Defaults to Alignment.topLeft.
  ///
  /// **[end]** (optional, AlignmentGeometry) : Defines the ending point of the shimmer gradient.
  /// Defaults to Alignment.centerRight. This controls the direction of the shimmer animation.
  ///
  /// **[tileMode]** (optional, TileMode) : Specifies how the gradient should be tiled
  /// if the child widget is larger than the gradient itself. Defaults to TileMode.clamp,
  /// which clamps the gradient to the edges of the child widget.
  ///
  /// **[direction]** (optional, AxisDirection) : Defines the direction in which
  /// the shimmer animation moves. Defaults to AxisDirection.right,
  /// which means the shimmer moves from left to right.
  ///
  /// **[blendMode]** (optional, BlendMode) : Determines how the shimmer gradient
  /// is blended with the child widget. Defaults to BlendMode.srcATop,
  /// which places the source color over the destination color.
  static const shimmer = LoopTransition.shimmer;

  /// Creates a transition builder for that animates text
  /// by shaking it horizontally or vertically.
  ///
  /// [direction] (optional): An `Axis` value that controls the shaking direction.
  /// Defaults to `Axis.horizontal`, which shakes the widget back and forth horizontally.
  /// You can also use `Axis.vertical` to shake the widget up and down vertically.
  ///
  /// [distance] (optional): A `double` value that determines
  /// the maximum offset of the shaking movement. Defaults to `3.0`,
  /// which creates a moderate shaking effect. Higher values will
  /// result in more pronounced shaking.
  static const shake = LoopTransition.shake;

  /// Animates text by shake them along the horizontal axis.
  static const shakeX = LoopTransition.shakeX;

  /// Animates text by shake them along the vertical axis.
  static const shakeY = LoopTransition.shakeY;

  /// Creates a smooth fading effect on the text widget during the animation cycle.
  static const fade = LoopTransition.fade;

  /// This function is used to create a typing animation
  /// for text widgets in the WxAnimatedText class.
  /// It simulates the effect of text being typed on screen one character at a time.
  static const WxAnimatedTextTransition typing = _typing;
  static Widget _typing(Widget child, Animation<double> animation) {
    return Builder(
      builder: (context) {
        final config = context.findAncestorWidgetOfExactType<WxAnimatedText>()!;
        final value = animation.value.clamp(0, 1);
        final chars = config.data!.characters;
        final count = (value * chars.length).round();
        final text = chars.take(count).toString();
        return WxText.from(config, text: text);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return LoopTransition(
      pause: pause,
      delay: delay,
      duration: duration,
      curve: curve,
      repeat: repeat,
      forward: forward,
      reverse: reverse,
      transition: transition,
      child: super.build(context),
    );
  }
}
