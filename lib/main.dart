import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trakt_dart/trakt_dart.dart';
import 'package:trakt_sample/page/auth.dart';
import 'package:trakt_sample/page/home.dart';
import 'package:trakt_sample/page/trakt_complete_registration.dart';
import 'package:trakt_sample/route.dart';
import 'package:trakt_sample/secret.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final secret = await SecretLoader(secretPath: "secrets.json").load();
  runApp(TraktDartApp(secret: secret));
}


// ignore: must_be_immutable
class TraktDartApp extends StatelessWidget {
  late TraktManager traktManager;
  final Secret secret;

  TraktDartApp({Key? key, required this.secret}) : super(key: key) {
    // Replace with your clientId and clientId from Trakt API.
    traktManager = TraktManager(
        clientId: secret.clientId,
        clientSecret: secret.clientSecret,
        redirectURI: "");
  }

  @override
  Widget build(BuildContext context) {
    final router = buildRouter(traktManager);
    return MaterialApp.router(
      routerConfig: router,
      title: 'Welcome to Flutter',
    );
  }
}
