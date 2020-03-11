import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stetho/flutter_stetho.dart';
import 'home/Home.dart';
import 'Styles.dart';

//export PATH="$PATH:/Volumes/Work/sdk/flutter/bin"
//flutter build appbundle --target-platform android-arm,android-arm64,android-x64

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Stetho.initialize();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  await pushNotificationSetting(_firebaseMessaging);
  Firestore.instance.settings(persistenceEnabled: true);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
//      debugShowCheckedModeBanner: false,
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
