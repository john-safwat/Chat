class FirebaseFireStoreDatabaseException implements Exception {
  String errorMessage;
  FirebaseFireStoreDatabaseException(this.errorMessage);
}