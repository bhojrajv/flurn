import 'dart:io';
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewExample extends StatefulWidget {

  @override
  WebViewExampleState createState() => WebViewExampleState();
}

class WebViewExampleState extends State<WebViewExample> {
  final Completer<WebViewController> _controller =
  Completer<WebViewController>();
  String url;

  @override
  void didChangeDependencies() {
    url=ModalRoute.of(context).settings.arguments;
    super.didChangeDependencies();
  }
  @override
  void initState() {
    super.initState();

    // Enable hybrid composition.
  //  if (Platform.isAndroid) WebView.platform =SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: url==null?Center(
        child:CircularProgressIndicator(backgroundColor: Colors.blue,
          valueColor: AlwaysStoppedAnimation(Colors.green),) ,
      ):WebView(
        initialUrl:'${url}',
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated:( WebViewController webController){
          _controller.complete(webController);
        },
      )
    );
  }
}
