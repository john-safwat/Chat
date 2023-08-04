import 'package:chat/Domain/UseCase/AddRoomUseCase.dart';
import 'package:chat/Presentation/Base/BaseState.dart';
import 'package:chat/Presentation/DI/di.dart';
import 'package:chat/Presentation/Models/RoomCategory.dart';
import 'package:chat/Presentation/Models/RoomType.dart';
import 'package:chat/Presentation/Theme/MyTheme.dart';
import 'package:chat/Presentation/UI/Create%20Room/CreateRoomNavigator.dart';
import 'package:chat/Presentation/UI/Create%20Room/CreateRoomViewModel.dart';
import 'package:chat/Presentation/UI/Create%20Room/Widgets/CategoryDropdownButtonWidget.dart';
import 'package:chat/Presentation/UI/Create%20Room/Widgets/TypeDropdownButtonWidget.dart';
import 'package:chat/Presentation/UI/GlobalWidgets/CustomTextFormField.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateRoomView extends StatefulWidget {
  const CreateRoomView({super.key});
  static const String routeName = "CreateRoom";
  @override
  State<CreateRoomView> createState() => _CreateRoomViewState();
}

class _CreateRoomViewState
    extends BaseState<CreateRoomView, CreateRoomViewModel>
    implements CreateRoomNavigator {
  @override
  CreateRoomViewModel initialViewModel() {
    return CreateRoomViewModel(AddRoomUseCase(injectRoomDataRepo(), injectUserRepo()));
  }
  @override
  void initState() {
    super.initState();
    viewModel!.selectedRoomCategory = viewModel!.categories.first;
    viewModel!.selectedType = viewModel!.types.first;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CreateRoomViewModel>(
      create: (context) => viewModel!,
      child: Consumer<CreateRoomViewModel>(
        builder: (context, value, child) => Stack(
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
                title: Text(
                  "Create Room",
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium!
                      .copyWith(color: MyTheme.white),
                ),
              ),
              body: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
                child: Column(
                  children: [
                    Expanded(
                        child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: MyTheme.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: MyTheme.black.withOpacity(0.3),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            )
                          ]),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30),
                          child: Form(
                            key: value.fromKey,
                            child: Column(
                              children: [
                                // the title in the top of the page
                                Text(
                                  "Create New Room",
                                  style:
                                      Theme.of(context).textTheme.displayLarge,
                                ),
                                // the image of group of people
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Image.asset(
                                    'assets/images/group.png',
                                    width: 200,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                // the text filed to enter the group name
                                MyTextFormField(
                                    label: "Enter Group Name",
                                    controller: value.groupNameController,
                                    inputType: TextInputType.name,
                                    validator: value.nameValidation,
                                    contained: true,
                                ),
                                // the Group description
                                MyTextFormField(
                                  label: "Enter Group Description",
                                  controller: value.groupDescriptionController,
                                  inputType: TextInputType.name,
                                  validator: value.descriptionValidation,
                                  maxLinesNumber: 5,
                                  contained: true,
                                ),
                                // the drop down to select the group type
                                Container(
                                  width: double.infinity,
                                  margin:const EdgeInsets.symmetric(horizontal: 20 , vertical: 10),
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
                                    value: viewModel!.selectedRoomCategory,
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
                                // the room type dropdown
                                Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 20 , vertical: 10),
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
                                Container(
                                  width: double.infinity,
                                  margin:const EdgeInsets.symmetric(horizontal: 20 , vertical: 10),
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(MyTheme.blue),
                                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ))
                                    ),
                                    onPressed: value.addRoom,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text("Create Room" , style: Theme.of(context).textTheme.displayLarge!.copyWith(color: MyTheme.white),),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
