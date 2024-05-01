import 'package:flutter/widgets.dart';

/// Designed to manage the visibility of spoiler content.
/// It provides a mechanism to toggle between an expanded (visible)
/// and collapsed (hidden) state for spoiler text.
class WxSpoilerController extends ChangeNotifier {
  /// Creates a new [WxSpoilerController] instance.
  WxSpoilerController({
    this.expanded = false,
  });

  /// Indicates text visibility (expanded or collapsed).
  bool expanded;

  /// Triggers a state change in the expanded property.
  /// It essentially flips the current visibility state
  /// - if the spoiler is currently expanded, it will be collapsed, and vice versa.
  /// The notifyListeners() method is called to notify any widgets
  /// that are listening to changes in the expanded property,
  /// allowing them to update their UI accordingly.
  void toggle() {
    expanded = !expanded;
    notifyListeners();
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
