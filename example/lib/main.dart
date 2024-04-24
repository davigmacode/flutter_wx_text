/* spell-checker: disable */

import 'dart:math';

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
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 400,
            ),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: WxTextStyler(
                  variant: WxTextVariant.bodyLarge,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      ListTile(
                        title: const WxText.displayLarge(
                          'WxText',
                          style: TextStyle(
                            color: Colors.amber,
                            fontWeight: FontWeight.bold,
                          ),
                          borderColor: Colors.blue,
                          borderWidth: 2,
                        ),
                        subtitle: const WxText(
                          'A powerful widget that builds upon the familiar Flutter Text widget',
                        ),
                        trailing: Transform.translate(
                          offset: const Offset(10, 0),
                          child: Transform.rotate(
                            angle: -90 * pi / 180,
                            child: const FlutterLogo(size: 70),
                          ),
                        ),
                        contentPadding: EdgeInsets.zero,
                      ),
                      const SizedBox(height: 20),
                      WxSpoilerText(
                        'Enhanced text processing with email and URL converted to clickable links, highlighted text, and dynamic text expansion/collapse\n\n'
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.\n\n'
                        'https://pub.dev/packages/wx_text\n'
                        'https://pub.dev/publishers/widgetarian.com\n'
                        'davigmacode@gmail.com\n',
                        highlight: 'do',
                        trimLines: 5,
                        textAlign: TextAlign.justify,
                        overflow: TextOverflow.ellipsis,
                        filterDisabledOnCollapsed: true,
                        filter: [
                          WxTextFilter.email(onTap: sendMail),
                          WxTextFilter.url(onTap: openURL),
                        ],
                        builder: (context, text, toggle) {
                          return InkWell(
                            splashFactory: NoSplash.splashFactory,
                            onTap: toggle,
                            child: text,
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      ColoredBox(
                        color: Colors.amber.shade100,
                        child: const WxText.labelLarge(
                          'Text with a minimum of 3 lines',
                          minLines: 3,
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
