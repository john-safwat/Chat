import 'package:chat/Data/Models/Room/RoomDTO.dart';
import 'package:chat/Domain/Exception/FirebaseAuthException.dart';
import 'package:chat/Domain/Exception/FirebaseAuthTimeoutException.dart';
import 'package:chat/Domain/Models/Room/Room.dart';
import 'package:chat/Domain/UseCase/GetUserRoomsUseCase.dart';
import 'package:chat/Domain/UseCase/SignOutUseCase.dart';
import 'package:chat/Domain/UseCase/GetPublicRoomsUseCase.dart';
import 'package:chat/Presentation/Base/BaseViewModel.dart';
import 'package:chat/Presentation/UI/Home/HomeNavigator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class HomeViewModel extends BaseViewModel<HomeNavigator>{
  SignOutUseCase signOutUseCase;
  GetPublicRoomsUseCase getPublicRoomsUseCase;
  GetUserRoomsUseCase getUserRoomsUseCase;
  HomeViewModel(this.signOutUseCase , this.getPublicRoomsUseCase , this.getUserRoomsUseCase);
  TextEditingController idController = TextEditingController();

  List<Room> myRooms = [];
  List<Room> browseRooms = [];

  int comingRooms = 0;
  // to control the action and the title of the floating action button
  int selectedTabIndex = 0;
  void changeSelectedTabIndex(int index){
    selectedTabIndex = index;
    notifyListeners();
  }

  void goToSearchScreen(){
    navigator!.goToSearchScreen();
  }

  void goToCreateRoomScreen(){
    navigator!.goToCreateRoomScreen();
  }

  void onSignOutPress()async{
    navigator!.showQuestionMessage(message: "Are You Sure you want to Sign out?" , posActionTitle: "Ok" , posAction: signOut , negativeActionTitle: "Cancel");
  }
  void goToJoinRoomScreen(Room room){
    navigator!.goToJoinRoomScreen(room);
  }
  void goToChatScreen(Room room){
    navigator!.goToChatScreen(room);
  }

  void signOut()async{
    navigator!.showLoading("Logging You out");
    try{
      await signOutUseCase.invoke();
      provider!.removeUser();
      navigator!.removeContext();
      navigator!.goToLoginScreen();
    }catch (e){
      navigator!.removeContext();
      if(e is FirebaseAuthRemoteDataSourceException){
        navigator!.showFailMessage(message: e.errorMessage , posActionTitle: "Try Again");
      }else if (e is FirebaseAuthTimeoutException){
        navigator!.showFailMessage(message: e.errorMessage , posActionTitle: "Try Again");
      }else{
        navigator!.showFailMessage(message: e.toString(), posActionTitle: "Try Again");
      }
    }
  }

  Stream<QuerySnapshot<RoomDTO>> getPublicRooms(){
    return getPublicRoomsUseCase.invoke();
  }
  Stream<QuerySnapshot<RoomDTO>> getUserRooms(){
    return getUserRoomsUseCase.invoke(provider!.user!.uid);
  }

  void removeUsersJoinedRoom(){
    for(int i =0 ; i< browseRooms.length ; i++){
      if(browseRooms[i].users.contains(provider!.user!.uid)){
        browseRooms.removeWhere((element) => element.id == browseRooms[i].id);
        i--;
      }
    }
    for(int i = 0 ; i< browseRooms.length-1 ; i++){
      var swapped= false;
      for(int j = 0 ; j<browseRooms.length - i -1 ; j++ ){
        if(browseRooms[j].dateTime < browseRooms[j+1].dateTime){
          var temp = browseRooms[j];
          browseRooms[j] = browseRooms[j+1];
          browseRooms[j+1] = temp;
          swapped = true;
        }
      }
      if (swapped == false) {
        break;
      }
    }
  }

  void sortRoomsByOldRooms(){
    var rooms = browseRooms;
    for(int i = 0 ; i< rooms.length-1 ; i++){
      var swapped= false;
      for(int j = 0 ; j<rooms.length - i -1 ; j++ ){
        if(rooms[j].dateTime > rooms[j+1].dateTime){
          var temp = rooms[j];
          rooms[j] = rooms[j+1];
          rooms[j+1] = temp;
          swapped = true;
        }
      }
      if (swapped == false) {
        break;
      }
    }
    browseRooms = rooms;
    notifyListeners();
  }

  void sortRoomsByNewRooms(){
    var rooms = browseRooms;
    for(int i = 0 ; i< rooms.length-1 ; i++){
      var swapped= false;
      for(int j = 0 ; j<rooms.length - i -1 ; j++ ){
        if(rooms[j].dateTime < rooms[j+1].dateTime){
          var temp = rooms[j];
          rooms[j] = rooms[j+1];
          rooms[j+1] = temp;
          swapped = true;
        }
      }
      if (swapped == false) {
        break;
      }
    }
    browseRooms = rooms;
    notifyListeners();
  }

  void sortRoomsByNumberOfMembers(){
    var rooms = browseRooms;

    for(int i = 0 ; i< rooms.length-1 ; i++){
      var swapped= false;
      for(int j = 0 ; j<rooms.length - i -1 ; j++ ){
        if(rooms[j].users.length < rooms[j+1].users.length){
          var temp = rooms[j];
          rooms[j] = rooms[j+1];
          rooms[j+1] = temp;
          swapped = true;
        }
      }
      if (swapped == false) {
        break;
      }
    }
    browseRooms = rooms;
    notifyListeners();
  }

  String? bottomSheetIdValidation(String id){
    if(id.isEmpty){
      return "required field";
    }else{
      return null;
    }
  }
}