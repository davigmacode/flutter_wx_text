import 'package:flutter/widgets.dart';

/// Manage the visibility of spoiler content.
///
/// It provides a mechanism to toggle between an expanded (visible)
/// and collapsed (hidden) state for spoiler text.
class WxSpoilerController extends ChangeNotifier {
  /// Creates a new instance of [WxSpoilerController].
  ///
  /// By default, the spoiler content starts collapsed (not visible).
  ///
  /// * [expanded] (optional): The initial visibility state of the spoiler.
  /// Defaults to `false` (collapsed).
  /// * [onExpanded] (optional): A callback function that is invoked whenever
  /// the `expanded` property changes. It receives the new visibility state
  /// (`true` for expanded, `false` for collapsed).
  WxSpoilerController({
    this.expanded = false,
    this.onExpanded,
  });

  /// Indicates text visibility (expanded or collapsed).
  bool expanded;

  /// A callback function that is invoked whenever the `expanded` property changes.
  ///
  /// This can be used to update the UI of widgets that are listening to changes
  /// in the spoiler's visibility state. The callback receives the new visibility
  /// state (`true` for expanded, `false` for collapsed).
  ValueSetter? onExpanded;

  /// Toggles the visibility of the spoiler content.
  ///
  /// This method flips the current visibility state. If the spoiler is
  /// currently expanded, it will be collapsed. Conversely, if it's collapsed,
  /// it will be expanded.
  ///
  /// The `notifyListeners()` method is called to notify any widgets that are
  /// listening to changes in the `expanded` property, allowing them to update
  /// their UI accordingly. You might also consider invoking the `onExpanded`
  /// callback here to provide additional flexibility.
  void toggle() {
    expanded = !expanded;
    notifyListeners();
    onExpanded?.call(expanded);
  }
}

/// Manage and provide access to a WxSpoilerController instance throughout a widget tree.
/// It allows descendant widgets to access the controller and react to changes in
/// its expanded property, which controls the visibility of spoiler content.
class WxSpoilerProvider extends InheritedNotifier<WxSpoilerController> {
  /// Creates a new [WxSpoilerProvider] instance.
  const WxSpoilerProvider({
    super.key,
    required WxSpoilerController controller,
    required super.child,
  }) : super(notifier: controller);

  /// Attempts to find a [WxSpoilerProvider] in the widget tree above the given context,
  /// and Returns the [WxSpoilerController] associated with the nearest [WxSpoilerProvider] if found,
  /// otherwise returns `null`.
  static WxSpoilerController? maybeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<WxSpoilerProvider>()
        ?.notifier;
  }

  /// Similar to [maybeOf], but throws an assertion error
  /// if no WxSpoilerProvider is found in the context.
  static WxSpoilerController of(BuildContext context) {
    final controller = maybeOf(context);
    assert(controller != null, 'No WxSpoilerProvider found in context');
    return controller!;
  }
}
