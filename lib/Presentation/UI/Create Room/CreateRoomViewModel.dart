import 'package:chat/Presentation/Base/BaseViewModel.dart';
import 'package:chat/Presentation/Models/RoomCategory.dart';
import 'package:chat/Presentation/UI/Create%20Room/CreateRoomNavigator.dart';
import 'package:chat/Presentation/UI/Create%20Room/Widgets/DropdownButtonWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class CreateRoomViewModel extends BaseViewModel<CreateRoomNavigator>{

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
  List<String> types = ["Public" , "Private"];
  // the initial type
  String selectedType = 'Public' ;
  // function to change the room type
  void changeSelectedType(String newType){
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

}