import 'dart:async';

import 'package:logger/logger.dart';
import 'package:trakt_dart/trakt_dart.dart';
import 'package:trakt_sample/exception/authorization_expire_exception.dart';

class OAuthFlow {
  final TraktManager traktManager;

  OAuthFlow(this.traktManager);

  Future<AccessTokenResponse?> auth(
      DeviceCodeResponse deviceCodeResponse) async {
    var logger = Logger();
    // timestamp di expire
    var expireTimestamp = DateTime.now().millisecondsSinceEpoch +
        deviceCodeResponse.expiresIn * 1000;

    // ciclo finchè non scade il token o vengo autorizzato
    while (DateTime.now().millisecondsSinceEpoch <= expireTimestamp) {
      await Future.delayed(Duration(seconds: deviceCodeResponse.interval));
      try {
        logger
            .d("try ${DateTime.now()} expires ${deviceCodeResponse.expiresIn}");
        var code = await traktManager.authentication
            .getDeviceAccessToken(deviceCodeResponse.deviceCode);
        return code;
      } catch (e) {
        logger.d(
            "$e : failed ${DateTime.now()} expires ${deviceCodeResponse.expiresIn}");
      }
    }
    throw AuthorizationExpireException(cause: "tempo scaduto");
  }
}
