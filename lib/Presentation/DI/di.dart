import 'package:chat/Data/DataSource/FirebaseAuthRemoteDataSourceImpl.dart';
import 'package:chat/Data/Firebase/FirebaseAuth.dart';
import 'package:chat/Data/Repository/FirebaseAuthRepositoryImpl.dart';
import 'package:chat/Domain/Repository/FirebaseAuthContract.dart';

FirebaseAuthConfig getFirebaseAuthConfig(){
  return FirebaseAuthConfig.getFirebaseAuthConfig();
}

FirebaseAuthRemoteDataSource getFirebaseAuthRemoteDataSource(FirebaseAuthConfig firebaseAuthConfig){
  return FirebaseAuthRemoteDataSourceImpl(firebaseAuthConfig);
}
FirebaseAuthRepository getFirebaseAuthRepository(FirebaseAuthRemoteDataSource remoteDataSource){
  return FirebaseAuthRepositoryImpl(remoteDataSource);
}

FirebaseAuthRepository injectAuthRepo(){
  return getFirebaseAuthRepository(getFirebaseAuthRemoteDataSource(getFirebaseAuthConfig()));
}