import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:trakt_dart/trakt_dart.dart';
import 'package:go_router/go_router.dart';

class TraktCompleteRegistration extends StatelessWidget {
  TraktCompleteRegistration(AccessTokenResponse extra, {Key? key})
      : super(key: key) {
    const storage = FlutterSecureStorage();
    storage.write(key: "accessTokenResponse", value: jsonEncode(extra));
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 5)).then((value) {
      context.goNamed("home");
    });
    return Scaffold(
        appBar: AppBar(
          title: const Text('Trending Movies'),
        ),
        body: const Center(
            child: Text(
          "Autenticazione completata, adesso puoi sincronizzare lo stato della serie tv con l'applicazione!",
        )));
  }
}
