import 'package:chat/Data/DataSource/FirebaseAuthRemoteDataSourceImpl.dart';
import 'package:chat/Data/DataSource/RoomDataRemoteDataSourceImpl.dart';
import 'package:chat/Data/Firebase/ErrorHandeler.dart';
import 'package:chat/Data/Firebase/FirebaseAuth.dart';
import 'package:chat/Data/Firebase/RoomsDatabase.dart';
import 'package:chat/Data/Repository/FirebaseAuthRepositoryImpl.dart';
import 'package:chat/Data/Repository/RoomDataRepositoryImpl.dart';
import 'package:chat/Domain/Repository/FirebaseAuthContract.dart';
import 'package:chat/Domain/Repository/RoomsRepositoryContract.dart';


// get error handler
ErrorHandler getErrorHandler(){
  return ErrorHandler.getErrorHandler();
}

// the dependency injection of the Firebase Auth Repository
FirebaseAuthConfig getFirebaseAuthConfig(){
  return FirebaseAuthConfig.getFirebaseAuthConfig();
}

FirebaseAuthRemoteDataSource getFirebaseAuthRemoteDataSource(FirebaseAuthConfig firebaseAuthConfig, ErrorHandler errorHandler){
  return FirebaseAuthRemoteDataSourceImpl(firebaseAuthConfig , errorHandler);
}
FirebaseAuthRepository getFirebaseAuthRepository(FirebaseAuthRemoteDataSource remoteDataSource){
  return FirebaseAuthRepositoryImpl(remoteDataSource);
}

FirebaseAuthRepository injectAuthRepo(){
  return getFirebaseAuthRepository(getFirebaseAuthRemoteDataSource(getFirebaseAuthConfig() , getErrorHandler()));
}

// the dependency injection of the Rooms Database
RoomsDatabase getRoomsDatabase(){
  return RoomsDatabase.getRoomDatabase();
}

RoomDataRemoteDataSource getRoomDataRemoteDataSource(RoomsDatabase database , ErrorHandler errorHandler){
  return RoomDataRemoteDataSourceImpl(database , errorHandler);
}

RoomDataRepository getRoomDataRepository(RoomDataRemoteDataSource dataSource){
  return RoomDataRepositoryImpl(dataSource);
}

RoomDataRepository injectRoomDataRepo(){
  return getRoomDataRepository(getRoomDataRemoteDataSource(getRoomsDatabase(), getErrorHandler()));
}