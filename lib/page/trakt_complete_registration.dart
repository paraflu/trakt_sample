import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:trakt_dart/trakt_dart.dart';
import 'package:go_router/go_router.dart';

class TraktCompleteRegistration extends StatefulWidget {
  final AccessTokenResponse accessTokenResponse;
  const TraktCompleteRegistration(this.accessTokenResponse, {Key? key})
      : super(key: key);

  @override
  State<TraktCompleteRegistration> createState() =>
      _TraktCompleteRegistrationState();
}

class _TraktCompleteRegistrationState extends State<TraktCompleteRegistration> {
  @override
  void initState() async {
    super.initState();
    const storage = FlutterSecureStorage();
    await storage.write(
        key: "accessTokenResponse",
        value: jsonEncode(widget.accessTokenResponse));
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
