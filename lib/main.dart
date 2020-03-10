import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stetho/flutter_stetho.dart';
import 'home/Home.dart';
import 'Styles.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Stetho.initialize();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  await pushNotificationSetting(_firebaseMessaging);
  Firestore.instance.settings(persistenceEnabled: true);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: baseTheme,
      initialRoute: "/home",
      routes: <String, WidgetBuilder>{
        "/home": (context) => Home(),
      },
    );
  }
}

Future pushNotificationSetting(firebaseMessaging) async {
  if (Platform.isIOS) {
    firebaseMessaging.requestNotificationPermissions(const IosNotificationSettings(sound: true, badge: true, alert: true));
    firebaseMessaging.onIosSettingsRegistered.listen((IosNotificationSettings settings) {});
  }
  firebaseMessaging.getToken().then((String token) {
//      saveFCMToken(token);
  });
}
