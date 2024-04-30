import 'package:animated_repeatable/animated_repeatable.dart';
import 'package:flutter/widgets.dart';
import '../widget.dart';

/// Used within the [WxAnimatedText] widget to specify
/// the animation function that controls how the text widget
/// is transformed during the animation cycle.
typedef WxAnimatedTextBuilder = AnimatedRepeatableBuilder;

/// The [WxAnimatedTextState] class is responsible for managing
/// the internal logic and animation of the [WxAnimatedText] widget.
///
/// The state class also handles methods for controlling
/// the animation playback (play, pause). The play method optionally
/// allows resetting the animation progress and cycle count before starting playback.
typedef WxAnimatedTextState = AnimatedRepeatableState;

/// This class is used to create animated text widgets in Flutter.
/// It inherits from the [WxText] class and adds the ability to specify
/// an animation function that controls how the text widget
/// is transformed during the animation cycle.
class WxAnimatedText extends AnimatedRepeatable {
  /// Creates an animated text widget.
  ///
  /// This constructor allows you to specify the following properties:
  ///
  /// [repeat]: The number of times to repeat the animation loop. Defaults to `-1` (infinite).
  ///
  /// [pause]: Whether to start the animation. Defaults to `false`.
  ///
  /// [continuity]: Controls whether the animation should maintain continuity when paused.
  ///
  /// [mirror]: Whether the animation should play forward, then backward in a mirroring effect.
  /// Defaults to false.
  ///
  /// [reverse]: Whether the animation plays backward initially. Defaults to `false`.
  ///
  /// [transition]: The [WxAnimatedTextBuilder] function that defines the animation behavior.
  /// Defaults to [WxAnimatedText.fade].
  ///
  /// [curve]: The animation curve that controls the easing of the animation.
  /// Defaults to `Curves.linear`.
  ///
  /// [delay]: The delay before the animation starts. Defaults to `Duration.zero`.
  ///
  /// [duration]: The duration of the animation. Defaults to `Duration(milliseconds: 200)`.
  ///
  /// [reverseTransition]: Defines the type of animation applied to the child widget
  /// for the backward direction (only applicable if [mirror] is `true`). Defaults to [transition] value.
  ///
  /// [reverseCurve]: The curve to use in the reverse direction.
  /// (only applicable if [mirror] is `true`). Defaults to [curve] value.
  ///
  /// [reverseDelay]: The delay before the backward animation starts. Defaults to [delay] value.
  ///
  /// [reverseDuration]: The duration of the backward animation. Defaults to [duration] value.
  ///
  /// [onStart]: A callback function called only once at the very beginning when the animation starts playing.
  ///
  /// [onPause]: A callback function called whenever the animation is paused.
  ///
  /// [onContinue]: A callback function called whenever the animation is resumed after being paused.
  ///
  /// [onCycle]: A callback function called every time the animation completes
  /// a single loop iteration (forward and potentially backward if reverse is true).
  ///
  /// [onComplete]: A callback function called only once when all loops
  /// have finished playing (if repeat is not set to `-1` for infinite loops).
  ///
  /// [wrapper]: control how the child widget is transformed based on
  /// the animation's progress and current state.
  ///
  /// [child]: The text widget that will be animated during the transition.
  /// This is a required parameter.
  const WxAnimatedText({
    super.key,
    super.repeat,
    super.pause,
    super.continuity,
    super.mirror,
    super.reverse,
    super.transition,
    super.curve,
    super.delay,
    super.duration,
    super.reverseTransition,
    super.reverseCurve,
    super.reverseDelay,
    super.reverseDuration,
    super.wrapper,
    super.onStart,
    super.onPause,
    super.onContinue,
    super.onCycle,
    super.onComplete,
    required Text child,
  }) : super(child: child);

  /// Provides a convenient way to create basic sliding animations
  /// for your text widget within the [WxAnimatedText] widget.
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
  static AnimatedRepeatableBuilder slide(
    Offset to, [
    Offset from = Offset.zero,
  ]) {
    return AnimatedRepeatable.slide(to, from);
  }

  /// Creates a transition builder that produces a zooming effect on the text widget.
  ///
  /// **[from]** (optional, double) : Defines the starting scale of the text widget
  /// during the animation cycle. Defaults to 0.0, which means the text widget starts off
  /// completely zoomed out (invisible).
  ///
  /// **[to]** (optional, double) : Defines the ending scale of the text widget
  /// during the animation cycle. Defaults to 1.0, which means the text widget ends up
  /// at its original size.
  static AnimatedRepeatableBuilder zoom([
    double from = 0,
    double to = 1,
  ]) {
    return AnimatedRepeatable.zoom(from, to);
  }

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
  static WxAnimatedTextBuilder shimmer({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry begin = Alignment.topLeft,
    AlignmentGeometry end = Alignment.centerRight,
    TileMode tileMode = TileMode.clamp,
    AxisDirection direction = AxisDirection.right,
    BlendMode blendMode = BlendMode.srcATop,
  }) {
    return AnimatedRepeatable.shimmer(
      colors: colors,
      stops: stops,
      begin: begin,
      end: end,
      tileMode: tileMode,
      direction: direction,
      blendMode: blendMode,
    );
  }

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
  static AnimatedRepeatableBuilder shake({
    Axis direction = Axis.horizontal,
    double distance = 5,
  }) {
    return AnimatedRepeatable.shake(
      direction: direction,
      distance: distance,
    );
  }

  /// Animates text by shake them along the horizontal axis.
  static const shakeX = AnimatedRepeatable.shakeX;

  /// Animates text by shake them along the vertical axis.
  static const shakeY = AnimatedRepeatable.shakeY;

  /// Creates a smooth fading effect on the text widget during the animation cycle.
  static const fade = AnimatedRepeatable.fade;

  /// This function is used to create a typing animation
  /// for text widgets in the WxAnimatedText class.
  /// It simulates the effect of text being typed on screen one character at a time.
  static WxAnimatedTextBuilder typing({
    String? trails,
    Duration trailsBlinking = const Duration(milliseconds: 500),
  }) {
    return (child, final state) {
      final config = child as WxText;
      final value = state.animation.value.clamp(0, 1);
      final chars = config.data!.characters;
      final count = (value * chars.length).round();
      final text = chars.take(count).toString();

      final trailing = (trails ?? '').trim();
      if (trailing.isNotEmpty) {
        if (state.isCompleted) {
          return AnimatedRepeatable(
            duration: trailsBlinking,
            transition: (widget, state) {
              final blinking = state.animation.value > .5 ? trailing : '';
              return WxText.from(config, text: text + blinking);
            },
            child: const SizedBox(),
          );
        }
      }

      return WxText.from(config, text: text + trailing);
    };
  }
}
