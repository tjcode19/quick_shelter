import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quick_shelter/models/PaymentResponse.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../constants.dart';

class PaymentWebview extends StatefulWidget {
  final paymentData;

  PaymentWebview({Key key, this.paymentData}) : super(key: key);

  @override
  _PaymentWebviewState createState() => _PaymentWebviewState();
}

class _PaymentWebviewState extends State<PaymentWebview> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  PaymentResponse _paymentData;
  String _url;

  Future<bool> _onBackPressed() {
    Navigator.pushNamed(context, transSuccessRoute);
  }

  @override
  void initState() {
    super.initState();
    _paymentData = widget.paymentData;
    _url = _paymentData.data.data.authorizationUrl;
    print(_url);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Make Payment'),
          // This drop down menu demonstrates that Flutter widgets can be shown over the web view.
          actions: <Widget>[
            // NavigationControls(_controller.future),
            //Menu(_controller.future, () => _favorites),
          ],
        ),
        body: WebView(
          initialUrl: _url,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
          onPageFinished: (String url) {
            print('Page finished loading: $url');
          },
        ),
        // floatingActionButton: _bookmarkButton(),
      ),
    );
  }
}
