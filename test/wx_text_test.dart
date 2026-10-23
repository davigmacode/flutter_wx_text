import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wx_text/wx_text.dart';

void main() {
  group('WxText basic & variants', () {
    testWidgets('renders basic text with custom style shortcuts', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: WxText(
              'Hello Flutter',
              color: Colors.red,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
        ),
      );

      final textFinder = find.text('Hello Flutter');
      expect(textFinder, findsOneWidget);

      final richText = tester.widget<RichText>(find.byType(RichText).first);
      expect(richText.text.style?.color, Colors.red);
      expect(richText.text.style?.fontSize, 24);
      expect(richText.text.style?.fontWeight, FontWeight.bold);
      expect(richText.text.style?.letterSpacing, 1.5);
    });

    testWidgets('renders displayLarge variant with text theme', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            textTheme: const TextTheme(
              displayLarge: TextStyle(fontSize: 57, color: Colors.blue),
            ),
          ),
          home: const Scaffold(
            body: WxText.displayLarge('Display Title'),
          ),
        ),
      );

      expect(find.text('Display Title'), findsOneWidget);
    });

    testWidgets('WxText.from copies and overrides properties correctly', (tester) async {
      const original = WxText(
        'Original',
        color: Colors.amber,
        fontSize: 16,
        maxLines: 2,
      );

      final derived = WxText.from(
        original,
        text: 'Derived',
        maxLines: 4,
      );

      expect(derived.text, 'Derived');
      expect(derived.color, Colors.amber);
      expect(derived.fontSize, 16);
      expect(derived.maxLines, 4);
    });

    testWidgets('WxText.copyWith copies and overrides properties correctly', (tester) async {
      const original = WxText(
        'Original',
        color: Colors.red,
        fontSize: 14,
        maxLines: 1,
        outlineWidth: 1.0,
      );

      final copy = original.copyWith(
        text: 'Copied',
        color: Colors.blue,
        fontSize: 20,
        outlineWidth: 2.5,
      );

      expect(copy.text, 'Copied');
      expect(copy.color, Colors.blue);
      expect(copy.fontSize, 20);
      expect(copy.maxLines, 1);
      expect(copy.outlineWidth, 2.5);
    });
  });

  group('WxTextStyler', () {
    testWidgets('applies typography variant to descendants', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: WxTextStyler(
              variant: WxTextVariant.titleLarge,
              child: WxText('Styled via Styler'),
            ),
          ),
        ),
      );

      expect(find.text('Styled via Styler'), findsOneWidget);
    });
  });

  group('ConstrainedText', () {
    testWidgets('enforces minimum height when minLines > 0', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Align(
              alignment: Alignment.topLeft,
              child: WxText(
                'Short',
                fontSize: 20,
                minLines: 3,
                minLinesDebugColor: Colors.grey,
              ),
            ),
          ),
        ),
      );

      expect(find.text('Short'), findsOneWidget);
      expect(find.byType(ConstrainedBox), findsWidgets);
      expect(find.byType(ColoredBox), findsWidgets);

      final size = tester.getSize(find.byType(WxText));
      expect(size.height, greaterThanOrEqualTo(50));
    });
  });

  group('GradientText and OutlinedText', () {
    testWidgets('applies ShaderMask when gradient is present', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: WxText(
              'Gradient Text',
              gradient: LinearGradient(
                colors: [Colors.red, Colors.blue],
              ),
            ),
          ),
        ),
      );

      expect(find.byType(ShaderMask), findsOneWidget);
      expect(find.text('Gradient Text'), findsOneWidget);
    });

    testWidgets('renders outline stack when outlineWidth > 0', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: WxText(
              'Outlined Text',
              outlineWidth: 2,
              outlineColor: Colors.black,
            ),
          ),
        ),
      );

      expect(find.text('Outlined Text'), findsWidgets);
    });

    testWidgets('renders outline with preserved spans when highlight is present', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: WxText(
              'Outlined with highlight',
              highlight: 'highlight',
              outlineWidth: 2,
              outlineColor: Colors.black,
            ),
          ),
        ),
      );

      expect(
        find.descendant(
          of: find.byType(WxText),
          matching: find.byType(Stack),
        ),
        findsOneWidget,
      );
      expect(find.byType(RichText), findsWidgets);
    });

    testWidgets('handles WidgetSpan inside outline gracefully without errors', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WxText(
              'Prefix [icon] suffix',
              outlineWidth: 2,
              outlineColor: Colors.black,
              filter: [
                WxTextFilter(
                  pattern: r'\[icon\]',
                  builder: (match) => const WidgetSpan(
                    child: Icon(Icons.star, size: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      expect(
        find.descendant(
          of: find.byType(WxText),
          matching: find.byType(Stack),
        ),
        findsOneWidget,
      );
      // Both outline layer and content layer render WidgetSpan (maintainSize Visibility)
      expect(find.byType(Icon), findsNWidgets(2));
    });
  });

  group('ParsedText and WxTextFilter', () {
    testWidgets('renders highlighted search span', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: WxText(
              'Quick brown fox',
              highlight: 'brown',
              highlightStyle: TextStyle(backgroundColor: Colors.yellow),
            ),
          ),
        ),
      );

      final richText = tester.widget<RichText>(find.byType(RichText).first);
      final outerSpan = richText.text as TextSpan;
      final innerSpan = outerSpan.children!.first as TextSpan;
      expect(innerSpan.children, isNotNull);
      expect(innerSpan.children!.length, 3);
      final highlightSpan = innerSpan.children![1] as TextSpan;
      expect(highlightSpan.text, 'brown');
      expect(highlightSpan.style?.backgroundColor, Colors.yellow);
    });

    testWidgets('custom WxTextFilter with tap handler works', (tester) async {
      String? tappedMatch;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WxText(
              'Contact user@example.com for help',
              filter: [
                WxTextFilter.email(
                  onTap: (match) => tappedMatch = match,
                ),
              ],
            ),
          ),
        ),
      );

      final richText = tester.widget<RichText>(find.byType(RichText).first);
      final outerSpan = richText.text as TextSpan;
      final innerSpan = outerSpan.children!.first as TextSpan;
      expect(innerSpan.children, isNotNull);

      // Find the email TextSpan and trigger recognizer
      final emailSpan = innerSpan.children!.firstWhere(
        (span) => span is TextSpan && span.text == 'user@example.com',
      ) as TextSpan;
      expect(emailSpan.recognizer, isNotNull);

      // ignore: avoid_dynamic_calls
      (emailSpan.recognizer as dynamic).onTap();
      expect(tappedMatch, 'user@example.com');
    });

    testWidgets('matches mention and hashtag filters', (tester) async {
      String? tappedMention;
      String? tappedHashtag;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WxText(
              'Hello @davigma check out #flutter today',
              filter: [
                WxTextFilter.mention(onTap: (match) => tappedMention = match),
                WxTextFilter.hashtag(onTap: (match) => tappedHashtag = match),
              ],
            ),
          ),
        ),
      );

      final richText = tester.widget<RichText>(find.byType(RichText).first);
      final outerSpan = richText.text as TextSpan;
      final innerSpan = outerSpan.children!.first as TextSpan;

      final mentionSpan = innerSpan.children!.firstWhere(
        (span) => span is TextSpan && span.text == '@davigma',
      ) as TextSpan;
      // ignore: avoid_dynamic_calls
      (mentionSpan.recognizer as dynamic).onTap();
      expect(tappedMention, '@davigma');

      final hashtagSpan = innerSpan.children!.firstWhere(
        (span) => span is TextSpan && span.text == '#flutter',
      ) as TextSpan;
      // ignore: avoid_dynamic_calls
      (hashtagSpan.recognizer as dynamic).onTap();
      expect(tappedHashtag, '#flutter');
    });

    testWidgets('matches phone filter and executes onTap', (tester) async {
      String? tappedPhone;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WxText(
              'Call me at +62 812-3456-7890 tomorrow',
              filter: [
                WxTextFilter.phone(
                  onTap: (match) => tappedPhone = match,
                ),
              ],
            ),
          ),
        ),
      );

      final richText = tester.widget<RichText>(find.byType(RichText).first);
      final outerSpan = richText.text as TextSpan;
      final innerSpan = outerSpan.children!.first as TextSpan;

      final phoneSpan = innerSpan.children!.firstWhere(
        (span) => span is TextSpan && span.text!.contains('812-3456-7890'),
      ) as TextSpan;

      expect(phoneSpan.recognizer, isNotNull);
      // ignore: avoid_dynamic_calls
      (phoneSpan.recognizer as dynamic).onTap();
      expect(tappedPhone, '+62 812-3456-7890');
    });

    testWidgets('applies click mouseCursor on tap and defer when non-interactive', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WxText(
              'Clickable @davigma and non-clickable #flutter',
              filter: [
                WxTextFilter.mention(onTap: (match) {}),
                WxTextFilter.hashtag(),
              ],
            ),
          ),
        ),
      );

      final richText = tester.widget<RichText>(find.byType(RichText).first);
      final outerSpan = richText.text as TextSpan;
      final innerSpan = outerSpan.children!.first as TextSpan;

      final mentionSpan = innerSpan.children!.firstWhere(
        (span) => span is TextSpan && span.text == '@davigma',
      ) as TextSpan;
      expect(mentionSpan.mouseCursor, SystemMouseCursors.click);

      final hashtagSpan = innerSpan.children!.firstWhere(
        (span) => span is TextSpan && span.text == '#flutter',
      ) as TextSpan;
      expect(hashtagSpan.mouseCursor, MouseCursor.defer);
    });

    testWidgets('filterDisabled disables parsing', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: WxText(
              'Plain text with no highlight',
              highlight: 'Plain',
              filterDisabled: true,
            ),
          ),
        ),
      );

      final richText = tester.widget<RichText>(find.byType(RichText).first);
      final outerSpan = richText.text as TextSpan;
      final innerSpan = outerSpan.children!.first as TextSpan;
      expect(innerSpan.children, isNull);
      expect(innerSpan.text, 'Plain text with no highlight');
    });
  });

  group('WxSpoilerText', () {
    testWidgets('toggles visibility and fires onExpanded callback', (tester) async {
      bool? isExpandedResult;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WxSpoilerText(
              'This is a long spoiler text that should be collapsible',
              maxLines: 1,
              expanded: false,
              onExpanded: (value) {
                isExpandedResult = value as bool;
              },
            ),
          ),
        ),
      );

      expect(find.byType(AnimatedCrossFade), findsOneWidget);
      expect(isExpandedResult, isNull);

      // Tap to toggle expanded
      await tester.tap(find.byType(WxSpoilerText));
      await tester.pumpAndSettle();

      expect(isExpandedResult, isTrue);

      // Tap again to toggle collapsed
      await tester.tap(find.byType(WxSpoilerText));
      await tester.pumpAndSettle();

      expect(isExpandedResult, isFalse);
    });

    testWidgets('preserves expanded state when parent rebuilds', (tester) async {
      final valueNotifier = ValueNotifier<int>(0);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ValueListenableBuilder<int>(
              valueListenable: valueNotifier,
              builder: (context, val, child) {
                return WxSpoilerText(
                  'Persistent spoiler text counter: $val',
                  maxLines: 1,
                  expanded: false,
                );
              },
            ),
          ),
        ),
      );

      // Tap spoiler to expand
      await tester.tap(find.byType(WxSpoilerText));
      await tester.pumpAndSettle();

      final crossFadeBefore = tester.widget<AnimatedCrossFade>(find.byType(AnimatedCrossFade));
      expect(crossFadeBefore.crossFadeState, CrossFadeState.showSecond);

      // Rebuild parent by changing valueNotifier
      valueNotifier.value = 1;
      await tester.pumpAndSettle();

      // State must remain expanded
      final crossFadeAfter = tester.widget<AnimatedCrossFade>(find.byType(AnimatedCrossFade));
      expect(crossFadeAfter.crossFadeState, CrossFadeState.showSecond);
    });
  });

  group('WxAnimatedText', () {
    testWidgets('renders child text and supports disableAnimations', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: WxAnimatedText(
              disableAnimations: true,
              transition: WxAnimatedText.fade,
              child: WxText('Static animated text'),
            ),
          ),
        ),
      );

      expect(find.text('Static animated text'), findsOneWidget);
    });
  });
}
