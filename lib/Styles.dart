import 'package:flutter/material.dart';

const Color primaryColor = const Color(0xff00afef);
const Color secondaryColor = const Color(0xffff0000);
const Color nameBackgroundColor = const Color(0xff000000);
const Color nameTextColor = const Color(0xffffffff);
const Color appBarIconColor = const Color(0xffffffff);
const Color shadowColor = const Color(0xffb3b3b3);
const Color errorColor = const Color(0xffFF8400);

const double dialogRadius = 16;
const double cardRadius = 4;
const double buttonRadius = 25;
const double cardElevation = 1;
const double homeHorizontalPadding = 3;
const double baseHorizontalPadding = 10;

final baseTheme = ThemeData(
  primaryColor: primaryColor,
  accentColor: primaryColor,
  scaffoldBackgroundColor: Colors.white,
  tabBarTheme: TabBarTheme(labelColor: Colors.white, unselectedLabelColor: Colors.white.withAlpha(85)),
  dialogTheme: DialogTheme(
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(dialogRadius)),
  ),
  cardTheme: CardTheme(
    elevation: cardElevation,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(cardRadius)),
  ),
//  fontFamily: , TODO фонт солихдоо энд зааж өгнө
  appBarTheme: AppBarTheme(
    color: Colors.white,
    brightness: Brightness.dark,
    iconTheme: IconThemeData(color: appBarIconColor),
    actionsIconTheme: IconThemeData(color: Colors.white),
    elevation: 0,
  ),
  buttonTheme: ButtonThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(buttonRadius)),
    ),
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
    buttonColor: primaryColor,
  ),
  bottomSheetTheme: BottomSheetThemeData(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(dialogRadius))),
  cardColor: Colors.white,
);
