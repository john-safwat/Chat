import 'package:chat/Domain/Exception/FirebaseAuthException.dart';
import 'package:chat/Domain/Exception/FirebaseAuthTimeoutException.dart';
import 'package:chat/Domain/Models/Room/Room.dart';
import 'package:chat/Domain/Models/User/Users.dart';
import 'package:chat/Domain/UseCase/GetUsersListUseCase.dart';
import 'package:chat/Domain/UseCase/UpdateRoomUseCase.dart';
import 'package:chat/Presentation/Base/BaseViewModel.dart';
import 'package:chat/Presentation/Models/RoomCategory.dart';
import 'package:chat/Presentation/Models/RoomType.dart';
import 'package:chat/Presentation/UI/RoomDetails/RoomDetailsNavigator.dart';
import 'package:flutter/cupertino.dart';

class RoomDetailsViewModel extends BaseViewModel<RoomDetailsNavigator>{
  GetUsersListUseCase useCase;
  UpdateRoomUseCase updateRoomUseCase;
  RoomDetailsViewModel(this.useCase ,this.updateRoomUseCase);
  Room? room;
  List<Users> users= [];
  String? errorMessage;
  List<RoomCategory> categories = RoomCategory.getAllCategories();
  late RoomCategory selectedCategory;
  List<RoomType> types = RoomType.getTypesList();
  late RoomType selectedType ;
  late TextEditingController roomNameController = TextEditingController(text: room!.name);
  late TextEditingController roomDescriptionController = TextEditingController(text: room!.description);
  final formKey = GlobalKey<FormState>();

  // gets the users that are members of a specific room
  void getUsersList()async{
    users = [];
    errorMessage = null;
    try{
        users = await useCase.invoke(roomId: room!.id);
        notifyListeners();
    }catch (e){

      if(e is FirebaseAuthRemoteDataSourceException){
          errorMessage = e.errorMessage;
      }else if (e is FirebaseAuthTimeoutException){
          errorMessage = e.errorMessage;
      }else{
        errorMessage = e.toString();
      }
      notifyListeners();
    }
  }
  // changes the selected category to the new category value
  void changeSelectedItem(RoomCategory newItem){
    selectedCategory = newItem;
    notifyListeners();
  }

  // changes the type of the room with the new value
  void changeSelectedType(RoomType newType){
    selectedType = newType;
    notifyListeners();
  }
  // updates the Room Details
  void updateRoom()async{
    if(formKey.currentState!.validate()){
      if(room!.name != roomNameController.text || room!.description != roomDescriptionController.text || selectedCategory.id != room!.category || selectedType.title  != room!.type){
        navigator!.showLoading("Updating Your Data");
        try{
          room!.type = selectedType.title;
          room!.category = selectedCategory.id;
          room!.name = roomNameController.text;
          room!.description = roomDescriptionController.text;
          await updateRoomUseCase.invoke(room!);
          navigator!.removeContext();
          navigator!.showSuccessMessage(message: "Your Data Updated Successfully" , posAction: goToChatScreen , posActionTitle: "OK");
        }catch (e){
          navigator!.removeContext();
          if(e is FirebaseAuthRemoteDataSourceException){
            navigator!.showFailMessage(message: e.errorMessage , posAction: updateRoom , posActionTitle: "Try again" , negativeActionTitle: "Cancel");
          }else if (e is FirebaseAuthTimeoutException){
            navigator!.showFailMessage(message: e.errorMessage , posAction: updateRoom , posActionTitle: "Try again" , negativeActionTitle: "Cancel");
          }else{
            navigator!.showFailMessage(message: e.toString() , posAction: updateRoom , posActionTitle: "Try again" , negativeActionTitle: "Cancel");
          }
        }
      }else{
        navigator!.showSuccessMessage(message: "Your Data Updated Successfully" , posAction: goToChatScreen , posActionTitle: "OK");
      }
    }
  }

  // validate on the name if it is not empty and doesn't contain ant spacial characters
  String? nameValidation(String name){
    if (name.isEmpty){
      return "Name Can't be Empty";
    }else if (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%-]').hasMatch(name)){
      return "Invalid Name";
    }else {
      return null;
    }
  }

  // validate on the description if it is not empty and doesn't contain ant spacial characters
  String? descriptionValidation(String description){
    if (description.isEmpty){
      return "Description Can't be Empty";
    }else {
      return null;
    }
  }

  void goToChatScreen(){
    navigator!.removeContext();
  }

}