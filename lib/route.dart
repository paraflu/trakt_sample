import "dart:convert";
import "dart:core";
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trakt_dart/trakt_dart.dart';
import 'package:trakt_sample/page/home.dart';
import 'package:trakt_sample/page/auth.dart';
import 'package:flutter/foundation.dart';
import 'package:trakt_sample/page/trakt_complete_registration.dart';

GoRouter buildRouter(TraktManager traktManager) => GoRouter(
      debugLogDiagnostics: true,
      routes: <GoRoute>[
        GoRoute(
            name: "home",
            path: '/',
            builder: (BuildContext context, GoRouterState state) {
              return HomePage(traktManager: traktManager);
            },
            routes: [
              GoRoute(
                name: 'auth',
                path: 'auth-required/:code',
                builder: (BuildContext context, GoRouterState state) {
                  return AuthPage(
                    deviceCodeResponse: state.extra as DeviceCodeResponse,
                    traktManager: traktManager,
                  );
                },
              ),
              // GoRoute(
              //   name: 'oauth',
              //   path: 'trakt/oauth',
              //   builder: (BuildContext context, GoRouterState state) {
              //     if (kDebugMode) {
              //       print(jsonEncode(state));
              //     }
              //     return const TraktDeepLinkPage();
              //   },
              // ),
              GoRoute(
                name: 'completeRegistration',
                path: 'trakt/complete',
                builder: (BuildContext context, GoRouterState state) {
                  return TraktCompleteRegistration(
                      state.extra! as AccessTokenResponse);
                },
              ),
            ]),
      ],
    );
