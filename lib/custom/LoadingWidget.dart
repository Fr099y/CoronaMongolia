import 'package:coronamongolia/Styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatefulWidget {
  @override
  _LoadingWidgetState createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          height: 32,
          width: 32,
          child: CircularProgressIndicator(
//        backgroundColor: primaryColor,
              ),
        ),
      ],
    );
  }
}
