/* spell-checker: disable */

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wx_text/wx_text.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

Future<void> openURL(String url) async {
  final Uri uri = Uri.parse(url);
  if (!await launchUrl(uri)) {
    throw Exception('Could not launch $uri');
  }
}

Future<void> sendMail(String address) async {
  final Uri uri = Uri.parse('mailto:$address');
  if (!await launchUrl(uri)) {
    throw Exception('Could not send mail $uri');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wx Text Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Wx Text Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Wrapper(
      children: <Widget>[
        ListTile(
          title: const WxText.displayLarge(
            'WxText',
            fontWeight: FontWeight.bold,
            outlineColor: Colors.white,
            outlineWidth: kIsWeb ? 0.1 : 2,
            shadows: [
              Shadow(
                color: Colors.green,
                blurRadius: 3,
              ),
            ],
            gradient: LinearGradient(
              colors: [
                Colors.green,
                Colors.blue,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          subtitle: WxAnimatedText(
            duration: const Duration(milliseconds: 2500),
            transition: WxAnimatedText.shimmer(
              colors: [
                Colors.black87,
                Colors.red,
                Colors.amber,
                Colors.black87,
                Colors.black87,
              ],
              stops: [0.0, 0.35, 0.5, 0.65, 1.0],
            ),
            child: const WxText.bodyLarge(
              'A powerful widget that builds upon the familiar Flutter Text widget',
            ),
          ),
          contentPadding: EdgeInsets.zero,
        ),
        const SizedBox(height: 20),
        const Example(
          title: 'Typography with Ease',
          child: WxTextStyler(
            variant: WxTextVariant.bodyLarge,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                WxText(
                    'This text inherits its formatting from its WxStyler parent widget.'),
                SizedBox(height: 20),
                WxText.titleMedium(
                    'The WxText.titleMedium constructor defines the style of this text.'),
                SizedBox(height: 20),
                WxText(
                  'This text uses a large label style by setting the variant parameter to WxTextVariant.labelLarge.',
                  variant: WxTextVariant.labelLarge,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        Example(
          title: 'Min Lines',
          child: WxText.labelLarge(
            'Text with a minimum of 3 lines',
            minLines: 3,
            minLinesDebugColor: Colors.yellow.shade200,
          ),
        ),
        const SizedBox(height: 20),
        const Example(
          title: 'Gradient Text',
          child: WxText.headlineSmall(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
            gradient: LinearGradient(colors: [
              Colors.green,
              Colors.blue,
              Colors.red,
            ]),
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        const Example(
          title: 'Outlined Text',
          child: WxText.headlineSmall(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
            color: Colors.white,
            fontWeight: FontWeight.bold,
            outlineColor: Colors.black87,
            outlineWidth: kIsWeb ? .3 : 1.5,
            letterSpacing: 1.1,
          ),
        ),
        const SizedBox(height: 20),
        Example(
          title: 'Parse Special Text',
          child: WxText(
            'Enhanced text processing with email and URL converted to clickable links, and  highlighted text\n\n'
            'https://pub.dev/packages/wx_text\n'
            'https://pub.dev/publishers/widgetarian.com\n'
            'davigmacode@gmail.com',
            highlight: 'highlighted',
            textAlign: TextAlign.justify,
            filter: [
              WxTextFilter.highlight(
                search: 'email',
                style: TextStyle(
                  backgroundColor: Colors.lightBlue.shade200,
                ),
              ),
              WxTextFilter.highlight(
                search: 'url',
                style: TextStyle(
                  backgroundColor: Colors.red.shade200,
                ),
              ),
              WxTextFilter.highlight(
                search: 'clickable',
                style: TextStyle(
                  backgroundColor: Colors.green.shade200,
                ),
              ),
              WxTextFilter.email(onTap: sendMail),
              WxTextFilter.url(onTap: openURL),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Example(
          title: 'Text expansion/collapse',
          child: WxSpoilerText(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.\n\n'
            'https://pub.dev/packages/wx_text\n'
            'https://pub.dev/publishers/widgetarian.com\n'
            'davigmacode@gmail.com',
            highlight: 'do',
            maxLines: 5,
            textAlign: TextAlign.justify,
            filterDisabledOnCollapsed: true,
            filter: [
              WxTextFilter.email(onTap: sendMail),
              WxTextFilter.url(onTap: openURL),
            ],
            wrapper: (context, text, toggle) {
              return InkWell(
                splashFactory: NoSplash.splashFactory,
                onTap: toggle,
                child: text,
              );
            },
          ),
        ),
        const SizedBox(height: 20),
        Example(
          title: 'Animated Text',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const WxAnimatedText(
                curve: Curves.bounceOut,
                delay: Duration(milliseconds: 300),
                duration: Duration(milliseconds: 1000),
                transition: WxAnimatedText.shakeX,
                child: Text(
                  'Lorem ipsum dolor sit amet',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              WxAnimatedText(
                curve: Curves.linear,
                delay: const Duration(milliseconds: 300),
                duration: const Duration(milliseconds: 1000),
                transition: WxAnimatedText.shimmer(colors: [
                  Colors.black87,
                  Colors.white,
                  Colors.black87,
                  Colors.black87,
                ]),
                child: const WxText.titleMedium(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua',
                ),
              ),
              const SizedBox(height: 20),
              const TypingText(),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

class TypingText extends StatefulWidget {
  const TypingText({super.key});

  @override
  State<TypingText> createState() => _TypingTextState();
}

class _TypingTextState extends State<TypingText> {
  final key = GlobalKey<WxAnimatedTextState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        WxAnimatedText(
          key: key,
          repeat: 0,
          mirror: true,
          reverse: true,
          curve: Curves.linear,
          delay: const Duration(milliseconds: 300),
          duration: const Duration(milliseconds: 1000),
          reverseDelay: const Duration(milliseconds: 300),
          reverseDuration: const Duration(milliseconds: 7000),
          transition: WxAnimatedText.typing(trails: '_'),
          child: const WxText(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua',
            variant: WxTextVariant.titleLarge,
            gradient: LinearGradient(colors: [
              Colors.blue,
              Colors.red,
              Colors.amber,
            ]),
          ),
        ),
        const SizedBox(height: 20),
        OutlinedButton(
          onPressed: () => key.currentState?.play(reset: true),
          child: const WxText('ReTyping Text'),
        ),
      ],
    );
  }
}

class Wrapper extends StatelessWidget {
  const Wrapper({
    super.key,
    required this.children,
  });

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: children,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Example extends StatelessWidget {
  const Example({
    super.key,
    required this.title,
    required this.child,
  });

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
          child: WxText.labelLarge(title),
        ),
        Card.outlined(
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: child,
            ),
          ),
        ),
      ],
    );
  }
}
