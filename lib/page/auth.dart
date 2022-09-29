import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  final String code;
  final String url;

  const AuthPage({required this.code, required this.url, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('AuthPage'),
        ),
        body: Column(
          children: [
            const Text("Verifica login"),
            Text("Codice: $code"),
            Text("Vai alla pagina $url"),
          ],
        ));
  }
}
