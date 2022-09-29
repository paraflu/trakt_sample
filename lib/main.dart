import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trakt_dart/trakt_dart.dart';
import 'package:trakt_sample/page/auth.dart';
import 'package:trakt_sample/page/home.dart';
import 'package:trakt_sample/page/traktdeeplink.dart';
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
    return MaterialApp.router(
      routerConfig: GoRouter(
        routes: <GoRoute>[
          GoRoute(
            path: '/',
            builder: (BuildContext context, GoRouterState state) {
              return HomePage(traktManager: traktManager);
            },
          ),
          GoRoute(
            name: 'auth',
            path: '/auth-required/:code',
            builder: (BuildContext context, GoRouterState state) {
              if (kDebugMode) {
                print(state.params['code']!);
              }
              return AuthPage(
                code: state.params["code"]!,
                url: state.queryParams["url"]!,
              );
            },
          ),
          GoRoute(
            name: 'oauth',
            path: '/trakt/oauth',
            builder: (BuildContext context, GoRouterState state) {
              if (kDebugMode) {
                print(jsonEncode(state));
              }
              return const TraktDeepLinkPage();
            },
          ),
        ],
      ),
      title: 'Welcome to Flutter',
    );
  }
}
