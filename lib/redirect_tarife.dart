import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:webview_flutter/webview_flutter.dart';

String url = 'https://unident.ro/onorarii/';
final _drawerController = ZoomDrawerController();

class RedirectTarif extends StatefulWidget {
  const RedirectTarif({super.key});

  @override
  State<RedirectTarif> createState() => _RedirectTarifState();
}

class _RedirectTarifState extends State<RedirectTarif> {
  final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers = {Factory(() => EagerGestureRecognizer())};
  final UniqueKey _key = UniqueKey();

  var controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.disabled)
    ..setBackgroundColor(const Color(0x00000000))
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
      ),
    )
    ..loadRequest(Uri.parse(url));

  @override
  void initState() {
    super.initState();
    pageScroll();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              ZoomDrawer.of(context)!.toggle();
            },
            icon: const Icon(Icons.menu),
          ),
          title: const Text('TARIFE'),
          centerTitle: true,
          backgroundColor: Color.fromRGBO(57, 52, 118, 1),
        ),
        body: SizedBox(
          child: WebViewWidget(
            key: _key,
            controller: controller,
            gestureRecognizers: gestureRecognizers,
          ),
        ),
      ),
    );
  }

  Future<void> openUrl(String url) async {
    final _url = Uri.parse(url);
    if (!await launchUrl(_url, mode: LaunchMode.inAppWebView)) {
      // <--
      throw Exception('Could not launch $_url');
    }
  }

  void pageScroll() async {
    Future.delayed(const Duration(milliseconds: 500), () {
      controller.scrollTo(0, 800);
    });
  }
}
