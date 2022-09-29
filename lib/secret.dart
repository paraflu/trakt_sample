import 'dart:convert';

import 'package:flutter/services.dart';

class Secret {
  final String clientId;
  final String clientSecret;

  Secret({required this.clientId, required this.clientSecret});

  factory Secret.fromJson(Map<String, dynamic> jsonMap) {
    return Secret(
        clientId: jsonMap["client_id"], clientSecret: jsonMap["client_secret"]);
  }
}

class SecretLoader {
  final String secretPath;

  SecretLoader({required this.secretPath});
  Future<Secret> load() {
    return rootBundle.loadStructuredData<Secret>(secretPath, (jsonStr) async {
      final secret = Secret.fromJson(json.decode(jsonStr));
      return secret;
    });
  }
}
