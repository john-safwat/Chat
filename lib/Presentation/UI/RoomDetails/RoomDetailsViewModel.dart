import 'package:chat/Domain/Models/Room/Room.dart';
import 'package:chat/Domain/Models/User/Users.dart';
import 'package:chat/Domain/UseCase/CreateAccountUseCase.dart';
import 'package:chat/Presentation/Base/BaseViewModel.dart';
import 'package:chat/Presentation/Models/RoomCategory.dart';
import 'package:chat/Presentation/UI/RoomDetails/RoomDetailsNavigator.dart';

class RoomDetailsViewModel extends BaseViewModel<RoomDetailsNavigator>{
  Room? room;
  List<RoomCategory> categories = RoomCategory.getAllCategories();
  late RoomCategory selectedCategory;
}