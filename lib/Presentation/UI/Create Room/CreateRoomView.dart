import 'package:chat/Presentation/Base/BaseState.dart';
import 'package:chat/Presentation/Models/RoomCategory.dart';
import 'package:chat/Presentation/Theme/MyTheme.dart';
import 'package:chat/Presentation/UI/Create%20Room/CreateRoomNavigator.dart';
import 'package:chat/Presentation/UI/Create%20Room/CreateRoomViewModel.dart';
import 'package:chat/Presentation/UI/Create%20Room/Widgets/DropdownButtonWidget.dart';
import 'package:chat/Presentation/UI/GlobalWidgets/CustomTextFormField.dart';
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
    return CreateRoomViewModel();
  }
  @override
  void initState() {
    super.initState();
    viewModel!.selectedItem = viewModel!.categories.first;
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

                                // the title of the categories
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20 , vertical: 10),
                                  child: Row(
                                    children: [
                                      Text("Category" , style: Theme.of(context).textTheme.displayMedium!.copyWith(fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                                // the drop down to select the group type
                                Container(
                                  width: double.infinity,
                                  margin:const EdgeInsets.symmetric(horizontal: 20 , vertical: 10),
                                  decoration: BoxDecoration(
                                    color: MyTheme.white,
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(width: 1 , color: MyTheme.blue),
                                    boxShadow: [
                                      BoxShadow(
                                        color: MyTheme.gray.withOpacity(0.3),
                                        offset: const Offset(0, 5),
                                        blurRadius: 15
                                      )
                                    ]
                                  ),
                                  padding: const EdgeInsets.symmetric(horizontal: 20 , vertical: 10),
                                  child: DropdownButton<RoomCategory>(
                                    icon: Container(),
                                    underline: Container(),
                                    borderRadius: BorderRadius.circular(20),
                                    value: viewModel!.selectedItem,
                                    items: viewModel!.categories.map<DropdownMenuItem<RoomCategory>>(
                                            (category) => DropdownMenuItem<RoomCategory>(
                                                value: category,
                                                child: DropdownButtonWidget(category: category,),
                                            )).toList(),
                                    onChanged: (value) {
                                      viewModel!.changeSelectedItem(value!);
                                    },
                                  ),
                                ),
                                // the Group description
                                MyTextFormField(
                                    label: "Enter Group Description",
                                    controller: value.groupDescriptionController,
                                    inputType: TextInputType.name,
                                    validator: value.nameValidation,
                                    maxLinesNumber: 6,
                                    contained: true,
                                ),

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

  @override
  goToHomeScreen() {
    Navigator.pop(context);
  }
}
