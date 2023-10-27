import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:unident_app/home.dart';
import 'package:webview_flutter/webview_flutter.dart';

String url =
    'https://www.google.com/maps/place/Unident+-+Clinic%C4%83+Dentar%C4%83+Premium/@45.6726035,24.3914533,9z/data=!4m12!1m2!2m1!1s+unident!3m8!1s0x40b35b966a8e7ca7:0x849a1195f8f15429!8m2!3d45.6726035!4d25.6109357!9m1!1b1!15sCgd1bmlkZW50WgkiB3VuaWRlbnSSAQ1kZW50YWxfY2xpbmljmgEkQ2hkRFNVaE5NRzluUzBWSlEwRm5TVU5TY2twUVNHOUJSUkFC4AEA!16s%2Fg%2F11qrqt3d5p?entry=ttu';

class RedirectFeedback extends StatefulWidget {
  const RedirectFeedback({super.key});

  @override
  State<RedirectFeedback> createState() => _RedirectFeedbackState();
}

class _RedirectFeedbackState extends State<RedirectFeedback> {
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
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
          ),
          title: const Text('Recenzii'),
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
