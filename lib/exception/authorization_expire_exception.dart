class AuthorizationExpireException implements Exception {
  String cause;

  AuthorizationExpireException({this.cause = ""});
}
