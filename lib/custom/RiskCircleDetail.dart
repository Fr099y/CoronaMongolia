import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RiskCircleDetail extends StatefulWidget {
  final DocumentSnapshot document;

  RiskCircleDetail(this.document);

  @override
  _RiskCircleDetailState createState() => _RiskCircleDetailState();
}

class _RiskCircleDetailState extends State<RiskCircleDetail> {
  bool _isClean = false;

  @override
  Widget build(BuildContext context) {
    _isClean = widget.document.data['isClean'] == true;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 20),
      child: Column(
        children: <Widget>[
          Text(
            widget.document.data['address'] ?? "-",
            style: TextStyle(fontSize: 19),
          ),
          Divider(),
          Text(
            _isClean ? "Ариутгал хийгдсэн" : "Эрсдлийн зэрэг : ${getRiskText()}",
            style: TextStyle(
              color: getRiskColor(),
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Color getRiskColor() {
    if (_isClean) return Colors.green;
    switch (int.parse("${widget.document.data['risk'] ?? 7}")) {
      case 1:
        return Colors.yellowAccent;
      case 2:
        return Colors.yellow;
      case 3:
        return Colors.yellow;
      case 4:
        return Colors.orangeAccent;
      case 5:
        return Colors.orangeAccent;
      case 6:
        return Colors.orange;
      case 7:
        return Colors.deepOrangeAccent;
      case 8:
        return Colors.deepOrange;
      case 9:
        return Colors.redAccent;
      case 10:
        return Colors.red;
    }
    return Colors.red;
  }

  String getRiskText() {
    switch (int.parse("${widget.document.data['risk'] ?? 7}")) {
      case 1:
        return "Маш бага";
      case 2:
        return "Бага";
      case 3:
        return "Бага";
      case 4:
        return "Дунд";
      case 5:
        return "Дунд";
      case 6:
        return "Дунд";
      case 7:
        return "Өндөр";
      case 8:
        return "Өндөр";
      case 9:
        return "Өндөр";
      case 10:
        return "Маш өндөр";
    }
    return "Тодорхойгүй";
  }
}
