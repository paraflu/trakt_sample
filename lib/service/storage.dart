import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:trakt_dart/trakt_dart.dart';

class Storage {
  late FlutterSecureStorage storage;
  Storage() {
    storage = const FlutterSecureStorage();
  }

  Future<void> save(AccessTokenResponse accessTokenResponse) async {
    await storage.write(
      key: "accessTokenResponse",
      value: jsonEncode({
        "access_token": accessTokenResponse.accessToken,
        "refresh_token": accessTokenResponse.refreshToken,
        "expires_in":
            accessTokenResponse.createdAt + accessTokenResponse.expiresIn,
      }),
    );
  }
}
