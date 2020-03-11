import 'package:coronamongolia/custom/LoadingWidget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MohsWeb extends StatefulWidget {
  @override
  _MohsWebState createState() => _MohsWebState();
}

class _MohsWebState extends State<MohsWeb> {
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        children: <Widget>[
          _isLoading ? LoadingWidget() : Container(),
          Expanded(
            child: WebView(
              javascriptMode: JavascriptMode.unrestricted,
              initialUrl: "https://covid19.mohs.mn/%D0%BC%D1%8D%D0%B4%D1%8D%D1%8D%D0%BB%D1%8D%D0%BB/",
              gestureRecognizers: Set()..add(Factory<VerticalDragGestureRecognizer>(() => VerticalDragGestureRecognizer())),
              onPageFinished: (fin) {
                setState(() {
                  _isLoading = false;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
