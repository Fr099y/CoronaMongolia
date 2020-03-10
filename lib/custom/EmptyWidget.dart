import 'package:coronamongolia/Styles.dart';
import 'package:flutter/material.dart';

class EmptyWidget extends StatefulWidget {
  @override
  _EmptyWidgetState createState() => _EmptyWidgetState();
}

class _EmptyWidgetState extends State<EmptyWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.do_not_disturb,
            size: 48,
            color: errorColor,
          ),
          Text(
            "Мэдээлэл олдсонгүй",
            style: TextStyle(fontSize: 21),
          ),
        ],
      ),
    );
  }
}
