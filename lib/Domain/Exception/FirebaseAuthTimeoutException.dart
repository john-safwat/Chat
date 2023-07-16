class FirebaseAuthTimeoutException implements Exception{
  String errorMessage;
  FirebaseAuthTimeoutException(this.errorMessage);
}