import 'package:chat/Domain/Exception/FirebaseFireStoreDatabaseTimeoutException.dart';
import 'package:chat/Domain/Exception/FirebaseFirestoreDatabaseException.dart';
import 'package:chat/Domain/UseCase/AddRoomUseCase.dart';
import 'package:chat/Presentation/Base/BaseViewModel.dart';
import 'package:chat/Presentation/Models/RoomCategory.dart';
import 'package:chat/Presentation/Models/RoomType.dart';
import 'package:chat/Presentation/UI/Create%20Room/CreateRoomNavigator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateRoomViewModel extends BaseViewModel<CreateRoomNavigator>{
  AddRoomUseCase addRoomUseCase ;
  CreateRoomViewModel(this.addRoomUseCase);

  final fromKey = GlobalKey<FormState>();
  TextEditingController groupNameController = TextEditingController();
  TextEditingController groupDescriptionController = TextEditingController();


  // the categories
  List<RoomCategory> categories = RoomCategory.getAllCategories();
  // the initial item
  late RoomCategory selectedRoomCategory ;
  // function to change the dropdown selected item
  void changeSelectedItem(RoomCategory newItem){
    selectedRoomCategory = newItem;
    notifyListeners();
  }

  // list of rooms type
  List<RoomType> types = RoomType.getTypesList();
  // the initial type
  late RoomType selectedType ;
  // function to change the room type
  void changeSelectedType(RoomType newType){
    selectedType = newType;
    notifyListeners();
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

  void addRoom()async {
    if(fromKey.currentState!.validate()){
      navigator!.showLoading("Creating Room...");
      try{
        var response = await addRoomUseCase.invoke(
            "",
            groupNameController.text,
            groupDescriptionController.text,
            selectedRoomCategory.id,
            selectedType.title,
            provider!.user!.uid,
            DateTime.now().millisecondsSinceEpoch,
            provider!.user!);
        navigator!.removeContext();
        navigator!.showSuccessMessage(message: response , posActionTitle: "Ok" , posAction: goToHomeScreen);
      }catch(e){
        navigator!.removeContext();
        if (e is FirebaseFireStoreDatabaseTimeoutException){
          navigator!.showFailMessage(message: e.errorMessage , posActionTitle: "Try Again" , posAction: addRoom);
        }else if (e is FirebaseFireStoreDatabaseException){
          navigator!.showFailMessage(message: e.errorMessage , posActionTitle: "Try Again" , posAction: addRoom);
        }else {
          navigator!.showFailMessage(message: e.toString() , posActionTitle: "Try Again" , posAction: addRoom);
        }
      }
    }
  }

  void goToHomeScreen(){
    navigator!.removeContext();
  }

}