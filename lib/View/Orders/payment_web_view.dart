import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:salonic/Custom_Widgets/export_file.dart';
import 'package:salonic/View/More/contact_us.dart';

class PaymentWebView extends StatefulWidget {
  final String url;
  final String token;
  final int user_id;
  final int order_id;
  PaymentWebView({this.url, this.token, this.user_id, this.order_id});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PaymentWebViewState();
  }
}

class PaymentWebViewState extends State<PaymentWebView> {
  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  StreamSubscription _onDestroy;
  StreamSubscription<String> _onUrlChanged;
  StreamSubscription<WebViewStateChanged> _onStateChanged;

  String status;
  List<String> url_list;
  @override
  void dispose() {
    _onDestroy.cancel();
    _onUrlChanged.cancel();
    _onStateChanged.cancel();
    flutterWebviewPlugin.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    url_list = new List();
    flutterWebviewPlugin.close();

    _onDestroy = flutterWebviewPlugin.onDestroy.listen((_) {
    });

    _onStateChanged =
        flutterWebviewPlugin.onStateChanged.listen((WebViewStateChanged state) {
    });

    // Add a listener to on url changed
    _onUrlChanged = flutterWebviewPlugin.onUrlChanged.listen(
      (String url) {
        url_list.add(url);
        var params = url.split("?")[1].split("&");
        List result = params[3].split("=");
        if (result[1] == 'Successful') {
          flutterWebviewPlugin.close();
          ApiProvider.getPaymentResponse(widget.token, url_list.last,
              widget.user_id, widget.order_id, context);
        } else {
          // errorDialog(context: context,text: 'توجد مشكلة تعوق عملية الدفع');
          flutterWebviewPlugin.close();
          ApiProvider.getPaymentResponse(widget.token, url_list.last,
              widget.user_id, widget.order_id, context);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primary_color,
      ),
      body: new WebviewScaffold(
        url: widget.url,
      ),
    );
  }
}
