import 'dart:async';

import 'package:logger/logger.dart';
import 'package:trakt_dart/trakt_dart.dart';
import 'package:trakt_sample/exception/authorization_expire_exception.dart';

class OAuthFlow {
  final TraktManager traktManager;

  OAuthFlow(this.traktManager);

  Future<AccessTokenResponse?> auth() async {
    var logger = Logger();
    DeviceCodeResponse deviceResponse =
        await traktManager.authentication.generateDeviceCodes(signup: true);

    while (DateTime.now().millisecondsSinceEpoch < deviceResponse.expiresIn) {
      await Future.delayed(Duration(seconds: deviceResponse.interval));
      try {
        logger.d("try ${DateTime.now()} expires ${deviceResponse.expiresIn}");
        var code = await traktManager.authentication
            .getAccessToken(deviceResponse.deviceCode);
        return code;
      } catch (e) {
        logger.d("failed ${DateTime.now()} expires ${deviceResponse.expiresIn}");
        return null;
      }
    }
  }
}
