import 'package:chat/Domain/Models/Room/Room.dart';
import 'package:chat/Domain/UseCase/CreateAccountUseCase.dart';
import 'package:chat/Domain/UseCase/GetUsersListUseCase.dart';
import 'package:chat/Domain/UseCase/UpdateRoomUseCase.dart';
import 'package:chat/Presentation/Base/BaseState.dart';
import 'package:chat/Presentation/DI/di.dart';
import 'package:chat/Presentation/Models/RoomCategory.dart';
import 'package:chat/Presentation/Models/RoomType.dart';
import 'package:chat/Presentation/Theme/MyTheme.dart';
import 'package:chat/Presentation/UI/Create%20Room/Widgets/CategoryDropdownButtonWidget.dart';
import 'package:chat/Presentation/UI/Create%20Room/Widgets/TypeDropdownButtonWidget.dart';
import 'package:chat/Presentation/UI/RoomDetails/RoomDetailsNavigator.dart';
import 'package:chat/Presentation/UI/RoomDetails/RoomDetailsViewModel.dart';
import 'package:chat/Presentation/UI/RoomDetails/Widgets/MyTextFormField.dart';
import 'package:chat/Presentation/UI/RoomDetails/Widgets/VirtecalWhiteSpace.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class RoomDetailsView extends StatefulWidget {
  static const String routeName = "RoomDetailsScreen";
  RoomDetailsView({super.key});

  @override
  State<RoomDetailsView> createState() => _RoomDetailsViewState();
}

class _RoomDetailsViewState
    extends BaseState<RoomDetailsView, RoomDetailsViewModel>
    implements RoomDetailsNavigator {
  @override
  Widget build(BuildContext context) {
    if (viewModel!.room == null) {
      viewModel!.room = ModalRoute.of(context)!.settings.arguments as Room;
      viewModel!.selectedCategory = viewModel!.categories.where((element) => element.id == viewModel!.room!.category).first;
      viewModel!.selectedType = viewModel!.types.where((element) => element.title == viewModel!.room!.type).first;
      print(viewModel!.selectedCategory.name);
      viewModel!.getUsersList();
    }
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            color: MyTheme.white,
          ),
          SizedBox(
            width: double.infinity,
            child: Image.asset(
              'assets/images/bgShape.png',
              fit: BoxFit.cover,
            ),
          ),
          Scaffold(
            appBar: AppBar(
              title: Text("${viewModel!.room!.name} - Details"),
            ),
            body: Column(
              children: [
                Expanded(
                    child: Container(
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: MyTheme.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: MyTheme.black.withOpacity(0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 5))
                      ]),
                  child: Consumer<RoomDetailsViewModel>(
                      builder: (context, value, child) {
                    if (value.errorMessage != null) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Row(),
                          Text(value.errorMessage!),
                          ElevatedButton(
                              onPressed: () {value.getUsersList();}, child: const Text("Try again"))
                        ],
                      );
                    } else if (value.users.isEmpty){
                      return const Center(
                        child: CircularProgressIndicator(
                          color: MyTheme.blue,
                        ),
                      );
                    } else {
                      return SingleChildScrollView(
                        child: Padding(
                          padding:const  EdgeInsets.all(20),
                          child: Form(
                            key: value.formKey,
                            child: Column(
                              children: [
                                Text(value.room!.name ,
                                  style: Theme.of(context).textTheme.displayLarge,
                                ),
                                VirtecalWhiteSpace(),
                                Image.asset("assets/icons/${value.selectedCategory.image}"),
                                VirtecalWhiteSpace(),
                                MyTextFormField(
                                  hintText: "Room Name",
                                  controller: value.roomNameController,
                                  validator: value.nameValidation,
                                ),
                                VirtecalWhiteSpace(),
                                MyTextFormField(
                                  hintText: "Room Description",
                                  controller: value.roomDescriptionController,
                                  validator: value.descriptionValidation,
                                ),
                                VirtecalWhiteSpace(),
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: MyTheme.white,
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(width: 1 , color: MyTheme.blue),
                                  ),
                                  padding: const EdgeInsets.symmetric(horizontal: 20 , vertical: 10),
                                  child: DropdownButton<RoomCategory>(
                                    icon: const Icon(EvaIcons.arrowDown ),
                                    iconEnabledColor: MyTheme.blue,
                                    isExpanded: true,
                                    underline: Container(),
                                    borderRadius: BorderRadius.circular(20),
                                    value: viewModel!.selectedCategory,
                                    items: viewModel!.categories.map<DropdownMenuItem<RoomCategory>>(
                                            (category) => DropdownMenuItem<RoomCategory>(
                                          value: category,
                                          child: CategoryDropdownButtonWidget(category: category,),
                                        )).toList(),
                                    onChanged: (value) {
                                      viewModel!.changeSelectedItem(value!);
                                    },
                                  ),
                                ),
                                VirtecalWhiteSpace(),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 20 , vertical: 5),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: MyTheme.white,
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(width: 1 ,color: MyTheme.blue),
                                  ),
                                  child: DropdownButton<RoomType>(
                                    isExpanded: true,
                                    underline: Container(),
                                    value: viewModel!.selectedType,
                                    borderRadius: BorderRadius.circular(20),
                                    icon: const Icon(EvaIcons.arrowDown ),
                                    iconEnabledColor: MyTheme.blue,
                                    items: viewModel!.types.map<DropdownMenuItem<RoomType>>(
                                            (e) => DropdownMenuItem<RoomType>(
                                          value: e,
                                          child: TypeDropdownButtonWidget(roomType: e,),
                                        )
                                    ).toList(),
                                    onChanged: (value) => viewModel!.changeSelectedType(value!),
                                  ),
                                ),
                                VirtecalWhiteSpace(),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                      onPressed: (){
                                          value.updateRoom();
                                      },
                                      style: ButtonStyle(
                                          backgroundColor:
                                          MaterialStateProperty.all(
                                              MyTheme.blue),
                                          elevation: MaterialStateProperty.all(4),
                                          shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(20),
                                              ))),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 20),
                                        child: Text(
                                          "Update Room Info",
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayMedium!
                                              .copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: MyTheme.white),
                                        ),
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                  }
                  ),
                )),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  RoomDetailsViewModel initialViewModel() {
    return RoomDetailsViewModel(GetUsersListUseCase(injectUserRepo()) , UpdateRoomUseCase(injectRoomDataRepo()));
  }
}
