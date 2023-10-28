import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

///
/// Created by Auro (auro@smarttersstudio.com) on 10/08/21 at 12:58 am
///

class WebViewPage extends StatefulWidget {
  static final routeName = '/WebViewPage';

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  bool _isLoading = true;
  String appBarName = '', url = '';

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> args = Get.arguments ?? {};
    appBarName = args['appBarName'];
    url = args['url'];
    print("url : $url");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: AppBackButton(color: Colors.white),
        title: Text('$appBarName'),
        titleSpacing: 0,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            WebView(
              javascriptMode: JavascriptMode.unrestricted,
              initialUrl: url,
              onWebViewCreated: (WebViewController webViewController) {},
              onPageStarted: (val) {
                print("$val");
                setState(() {
                  _isLoading = false;
                });
              },
            ),
            if (_isLoading)
              Positioned.fill(
                child: Center(child: CircularProgressIndicator()),
              )
          ],
        ),
      ),
    );
  }
}
