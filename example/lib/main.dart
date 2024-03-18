/* spell-checker: disable */

import 'package:flutter/material.dart';
import 'package:wx_text/wx_text.dart';

void main() {
  runApp(const MyApp());
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 500,
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const ColoredBox(
                  color: Colors.black12,
                  child: WxText.headlineMedium(
                    'Text with a minimum of 3 lines',
                    minLines: 3,
                  ),
                ),
                const SizedBox(height: 20),
                WxSpoilerText(
                  'Highlighted text, Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum',
                  highlight: 'dolor',
                  trimLines: 4,
                  textAlign: TextAlign.justify,
                  overflow: TextOverflow.ellipsis,
                  variant: WxTextVariant.labelLarge,
                  builder: (context, text, toggle) {
                    return InkWell(
                      splashFactory: NoSplash.splashFactory,
                      onTap: toggle,
                      child: text,
                    );
                  },
                ),
                const SizedBox(height: 20),
                const WxTextStyler(
                  variant: WxTextVariant.headlineLarge,
                  child: Wrap(
                    spacing: 5,
                    children: [
                      WxText('Apply'),
                      WxText('styles'),
                      WxText('to multiple'),
                      WxText('text'),
                      WxText('widgets'),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                WxText.bodyLarge(
                  'Highlighted text, Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut https://github.com/davigmacode/flutter_text labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in my@email.com voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum',
                  highlight: 'de',
                  filter: [
                    WxTextFilter.email(onTap: (_) {}),
                    WxTextFilter.url(onTap: (_) {}),
                  ],
                  // filterDisabled: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
