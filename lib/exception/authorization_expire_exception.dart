/// Eccezione che avviene quando l'autorizzazione non viene data alla app in tempo
class AuthorizationExpireException implements Exception {
  String cause;

  AuthorizationExpireException({this.cause = ""});
}
