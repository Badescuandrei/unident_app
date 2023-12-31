import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:unident_app/home.dart';
import 'package:webview_flutter/webview_flutter.dart';

String url = 'https://unident.ro/pachete/';
final _drawerController = ZoomDrawerController();

class RedirectPromotiiLunare extends StatefulWidget {
  const RedirectPromotiiLunare({super.key});

  @override
  State<RedirectPromotiiLunare> createState() => _RedirectPromotiiLunareState();
}

class _RedirectPromotiiLunareState extends State<RedirectPromotiiLunare> {
  final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers = {Factory(() => EagerGestureRecognizer())};
  final UniqueKey _key = UniqueKey();

  var controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
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

  // @override
  // void initState() {
  //   super.initState();
  //   // pageScroll();
  // }

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
          title: const Text('Oferte'),
          centerTitle: true,
          backgroundColor: Color.fromRGBO(57, 52, 118, 1),
        ),
        body: SizedBox(
          child: Column(
            children: [
              Expanded(
                child: WebViewWidget(
                  key: _key,
                  controller: controller,
                  gestureRecognizers: gestureRecognizers,
                ),
              ),
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    )),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                  IconButton(
                      onPressed: arrowBack,
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                      )),
                  IconButton(
                    onPressed: arrowForward,
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black,
                    ),
                  ),
                  IconButton(
                    onPressed: reload,
                    icon: Icon(
                      Icons.refresh,
                      color: Colors.black,
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  reload() async {
    controller.reload();
  }

  arrowBack() async {
    if (await controller.canGoBack()) {
      controller.goBack();
    } else {
      return;
    }
  }

  arrowForward() async {
    if (await controller.canGoForward()) {
      controller.goForward();
    } else {
      return;
    }
  }

  Future<void> openUrl(String url) async {
    final _url = Uri.parse(url);
    if (!await launchUrl(_url, mode: LaunchMode.inAppWebView)) {
      // <--
      throw Exception('Could not launch $_url');
    }
  }

  // void pageScroll() async {
  //   Future.delayed(const Duration(milliseconds: 500), () {
  //     controller.scrollTo(0, 800);
  //   });
  // }
}
