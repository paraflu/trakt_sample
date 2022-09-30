import 'dart:async';

import 'package:logger/logger.dart';
import 'package:trakt_dart/trakt_dart.dart';
import 'package:trakt_sample/exception/authorization_expire_exception.dart';

/// Implementazione dell'autenticazione con il device
///
/// https://trakt.docs.apiary.io/#reference/authentication-devices
///
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
      } on TraktManagerAPIError catch (e) {
        if (e.statusCode == 400) {
          // autenticazione non ancora
          logger.d(
              "$e : failed ${DateTime.now()} expires ${deviceCodeResponse.expiresIn}, retry");
        }
        rethrow;
      } catch (e) {
        logger.e(e);
        rethrow;
      }
    }
    throw AuthorizationExpireException(cause: "tempo scaduto");
  }
}
