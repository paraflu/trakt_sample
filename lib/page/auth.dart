import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:trakt_dart/trakt_dart.dart';
import 'package:trakt_sample/service/oauth_flow.dart';
import 'package:url_launcher/url_launcher_string.dart';

/// Pagina di autenticazione, indica l'url da aprire e il codice da inserire
class AuthPage extends StatefulWidget {
  final String code;
  final String url;
  final TraktManager traktManager;

  const AuthPage({
    required this.code,
    required this.url,
    required this.traktManager,
    Key? key,
  }) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  Widget showError(err) {
    return Text("$err");
  }

  @override
  Widget build(BuildContext context) {
    var service = OAuthFlow(widget.traktManager);
    var logger = Logger();
    var hasError = false;
    Exception? exception;

    // mi metto in ascolto dell'evento di completamento autorizzazione
    service
        .auth()
        .then((value) => context.goNamed("completeRegistration", extra: value))
        .catchError((err) {
      logger.e("Errore durante l'autenticazione $err");
      setState(() {
        hasError = true;
        exception = err;
      });
    });

    return Scaffold(
        appBar: AppBar(
          title: const Text('AuthPage'),
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  "Verifica login",
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 24),
                ),
              ),
              const Text("Codice: "),
              SelectableText(
                widget.code,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              RichText(
                text: TextSpan(
                    style: Theme.of(context).textTheme.bodyText1,
                    text: widget.url,
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async => await launchUrlString(widget.url)),
              ),
              ...(hasError ? [showError(exception)] : [])
            ],
          ),
        ));
  }
}
