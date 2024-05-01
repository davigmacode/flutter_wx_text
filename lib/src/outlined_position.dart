/// Representing the position of an outline in a WxText widget.
enum WxTextOutlinePosition {
  /// The outline is drawn behind the text content.
  background,

  /// The outline is drawn in front of the text content.
  foreground;

  /// determines if the outline position is behind the text.
  bool get isBackground => name == 'background';

  /// determines if the outline position is in front of the text.
  bool get isForeground => name == 'foreground';
}
