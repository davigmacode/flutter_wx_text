import 'package:loop_transition/loop_transition.dart';
import 'package:flutter/widgets.dart';
import '../widget.dart';

/// Used within the WxAnimatedText widget to specify
/// the animation function that controls how the text widget
/// is transformed during the animation cycle.
typedef WxAnimatedTextTransition = LoopTransitionBuilder;

/// This typedef defines a function signature used
/// within the WxAnimatedText widget. It's essentially a function
/// that builds the animated widget based on the provided parameters.
typedef WxAnimatedTextWrapper = LoopTransitionWrapperBuilder;

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
    this.repeat = -1,
    this.pause = false,
    this.mirror = false,
    this.reverse = false,
    this.transition = WxAnimatedText.fade,
    this.curve = Curves.linear,
    this.delay = Duration.zero,
    this.duration = const Duration(milliseconds: 200),
    this.backwardDelay,
    this.backwardDuration,
    this.wrapper,
    this.onStart,
    this.onPause,
    this.onContinue,
    this.onCycle,
    this.onComplete,
  });

  /// Controls how many times the entire animation loop
  /// (forward and potentially backward if [mirror] is `true`) will be played.
  /// Regardless of the [repeat] value, the animation will always play through
  /// one complete cycle (forward and potentially backward) before considering the [repeat] condition.
  ///
  /// Here's how repeat actually works:
  /// * `repeat = -1` (default): Plays the animation indefinitely (loops forever).
  /// * `repeat = 0`: Plays the animation one time only (one cycle).
  /// * `repeat = 1`: Plays the animation twice (one complete loop, then repeats the entire loop again).
  /// * `repeat > 1`: Plays the animation for the specified number of loops in addition to the initial cycle. For example, repeat = 3 plays the animation four times in total (one initial cycle + three repeats).
  ///
  /// In essence, the repeat property doesn't affect whether the animation plays one cycle initially. It controls how many times the entire loop repeats after the first cycle.
  final int repeat;

  /// When set to `true`, the animation playback is paused.
  /// When set to `false` (default), the animation plays normally
  /// according to the defined loop count [repeat].
  final bool pause;

  /// Defines whether the animation should play forward, then backward in a mirroring effect.
  final bool mirror;

  /// When set to `true`, the animation plays backward initially.
  final bool reverse;

  /// Defines the type of animation applied to the child widget.
  /// By default, it uses a fade transition (LoopTransition.fade).
  /// You can potentially provide your own custom transition function here.
  final WxAnimatedTextTransition transition;

  /// The [curve] of the animation. By default it's [Curves.linear].
  final Curve curve;

  /// The delay before the animation starts.
  final Duration delay;

  /// The [duration] of the animation.
  final Duration duration;

  /// The delay before the animation starts playing in the backward direction
  /// (only applicable if [mirror] is true). This allows for a slight pause between
  /// the forward and backward animations in the mirroring effect.
  ///
  /// Defaults to `null`, which means the backward animation will use
  /// the same delay as the forward animation specified by the [delay] property.
  final Duration? backwardDelay;

  /// An optional duration that can be specified for the backward animation
  /// (only applicable if [mirror] is true), allowing for a different duration
  /// compared to the forward animation, creating an asymmetrical mirroring effect.
  ///
  /// Defaults to `null`, which means the backward animation will use the same duration
  /// as the forward animation specified by the duration property.
  final Duration? backwardDuration;

  /// Called only once at the very beginning when
  /// the animation starts playing for the first time.
  final VoidCallback? onStart;

  /// Called when the animation is paused.
  final VoidCallback? onPause;

  /// Called when the animation is resumed after being paused.
  final VoidCallback? onContinue;

  /// Called when a complete loop iteration finishes.
  final ValueSetter<int>? onCycle;

  /// Called when all specified loops have finished playing
  /// (if repeat is not set to -1 for infinite loops).
  final VoidCallback? onComplete;

  /// It allows you to control how the child widget
  /// is transformed based on the animation's progress
  /// and current state (LoopAnimationStatus).
  final WxAnimatedTextWrapper? wrapper;

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
  static WxAnimatedTextTransition typing({
    String? trails,
    Duration trailsBlinking = const Duration(milliseconds: 500),
  }) {
    return (Widget child, Animation<double> animation) {
      return Builder(
        builder: (context) {
          final config =
              context.findAncestorWidgetOfExactType<WxAnimatedText>()!;
          final value = animation.value.clamp(0, 1);
          final chars = config.data!.characters;
          final count = (value * chars.length).round();
          final text = chars.take(count).toString();

          final trailing = (trails ?? '').trim();
          if (trailing.isNotEmpty) {
            final loop =
                context.findAncestorStateOfType<LoopTransitionState>()!;
            if (loop.isCompleted) {
              return LoopTransition(
                duration: trailsBlinking,
                transition: (widget, animation) {
                  final blinking = animation.value > .5 ? trailing : '';
                  return WxText.from(config, text: text + blinking);
                },
                child: const SizedBox(),
              );
            }
          }

          return WxText.from(config, text: text + trailing);
        },
      );
    };
  }

  @override
  Widget build(BuildContext context) {
    return LoopTransition(
      repeat: repeat,
      pause: pause,
      mirror: mirror,
      reverse: reverse,
      transition: transition,
      curve: curve,
      delay: delay,
      duration: duration,
      backwardDelay: backwardDelay,
      backwardDuration: backwardDuration,
      onStart: onStart,
      onPause: onPause,
      onContinue: onContinue,
      onCycle: onCycle,
      onComplete: onComplete,
      wrapper: wrapper,
      child: super.build(context),
    );
  }
}
