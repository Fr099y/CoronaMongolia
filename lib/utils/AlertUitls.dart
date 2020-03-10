import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coronamongolia/Styles.dart';
import 'package:coronamongolia/custom/RiskCircleDetail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

showCircleDetailBottomSheet(BuildContext context, DocumentSnapshot document) {
  print("showBottomSheet");
  showCustomBottomSheet(context, RiskCircleDetail(document));
}

showCustomBottomSheet(BuildContext context, Widget child, {Color bgColor = Colors.white}) {
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          width: double.infinity,
          color: Colors.transparent,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: bgColor != null ? bgColor : Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(dialogRadius)),
            ),
            child: Wrap(
              children: <Widget>[child],
            ),
          ),
        );
      });
}
