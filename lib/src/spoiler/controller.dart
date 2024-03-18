import 'package:flutter/widgets.dart';

class WxSpoilerController extends ChangeNotifier {
  WxSpoilerController({
    this.expanded = false,
  });

  /// Indicates text visibility (expanded or collapsed).
  bool expanded;

  void toggle() {
    expanded = !expanded;
    notifyListeners();
  }
}

class WxSpoilerProvider extends InheritedNotifier<WxSpoilerController> {
  const WxSpoilerProvider({
    Key? key,
    required WxSpoilerController controller,
    required Widget child,
  }) : super(key: key, notifier: controller, child: child);

  static WxSpoilerController of(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<WxSpoilerProvider>();
    assert(provider != null, 'No WxSpoilerController found in context');
    return provider!.notifier!;
  }
}
