import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:trakt_dart/trakt_dart.dart';
import 'package:go_router/go_router.dart';
import 'package:trakt_sample/service/storage.dart';

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
  void initState() {
    super.initState();

    Storage().save(widget.accessTokenResponse);
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
        body: Column(children: [
          Text(
            "Autenticazione completata, adesso puoi sincronizzare lo stato della serie tv con l'applicazione!",
          )
        ]));
  }
}
