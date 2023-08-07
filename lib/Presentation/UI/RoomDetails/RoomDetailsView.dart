import 'package:chat/Core/Base/BaseState.dart';
import 'package:chat/Core/Theme/MyTheme.dart';
import 'package:chat/Domain/Models/Room/Room.dart';
import 'package:chat/Domain/Models/User/Users.dart';
import 'package:chat/Domain/UseCase/GetUsersListUseCase.dart';
import 'package:chat/Presentation/DI/di.dart';
import 'package:chat/Presentation/Models/RoomCategory.dart';
import 'package:chat/Presentation/Models/RoomType.dart';
import 'package:chat/Presentation/UI/RoomDetails/RoomDetailsNavigator.dart';
import 'package:chat/Presentation/UI/RoomDetails/RoomDetailsViewModel.dart';
import 'package:chat/Presentation/UI/RoomDetails/Widgets/MyBottomSheatWidget.dart';
import 'package:chat/Presentation/UI/RoomDetails/Widgets/WhiteSpaceWidget.dart';
import 'package:chat/Presentation/UI/UpdateRoomDetails/UpdateRoomDetailsView.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/arrays.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class RoomDetailsView extends StatefulWidget {
  static const String routeName = 'RoomDetailsScreen';
  const RoomDetailsView({super.key});

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
      viewModel!.category = RoomCategory.getRoomCategory(viewModel!.room!.category);
      viewModel!.type = RoomType.getRoomType(viewModel!.room!.type);
      viewModel!.getUsersList();
    }
    return ChangeNotifierProvider(
      create: (context) => viewModel!,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            color: MyTheme.white,
          ),
          Image.asset(
            'assets/images/bgShape.png',
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Scaffold(
            appBar: AppBar(
              title: Text(viewModel!.room!.name),
            ),
            body: Consumer<RoomDetailsViewModel>(
              builder: (context, value, child) {
                if (value.errorMessage != null){
                  return Column(
                    children: [
                      const Row(),
                      Text(value.errorMessage! , style: Theme.of(context).textTheme.displayMedium,),
                      ElevatedButton(
                        onPressed: value.getUsersList,
                        child:const Text("Try Again"),
                      )
                    ],
                  );
                }else if (value.users.isEmpty){
                  return const Center(
                    child: CircularProgressIndicator(
                      color: MyTheme.blue,
                    ),
                  );
                }else {
                  return Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Column(
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
                                        offset: const Offset(0, 5),
                                      )
                                    ]),
                                width: double.infinity,
                                child: SingleChildScrollView(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20.0, horizontal: 15),
                                    child: Column(
                                      children: [
                                        // the image of the Room
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                                "assets/icons/${value.room!.category}.png"),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        // the Room Name
                                        Text(
                                          value.room!.name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayLarge!
                                              .copyWith(fontSize: 30, color: MyTheme.blue),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        // The Room Description
                                        Text(
                                          value.room!.description,
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayMedium!
                                              .copyWith(fontSize: 24, color: MyTheme.black),
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        // the Room Id And it's copy button
                                        Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  "Room ID",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .displayMedium!
                                                      .copyWith(color: MyTheme.blue),
                                                ),
                                                InkWell(
                                                  onTap: value.onCopyIconPress,
                                                  child: const Icon(
                                                    EvaIcons.copy,
                                                    color: MyTheme.blue,
                                                    size: 25,
                                                  ),
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: SelectableText(
                                                    value.room!.id,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .displayMedium,
                                                    maxLines: 1,
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        const WhiteSpaceWidget(),
                                        // the room category
                                        Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  "Room Category",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .displayMedium!
                                                      .copyWith(color: MyTheme.blue),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: [
                                                Image.asset(
                                                  "assets/icons/${value.category.image}",
                                                  height: 40,
                                                ),
                                                const SizedBox(
                                                  width: 15,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    value.category.name,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .displayMedium,
                                                    maxLines: 1,
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        const WhiteSpaceWidget(),
                                        // the room type
                                        Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  "Room Type",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .displayMedium!
                                                      .copyWith(color: MyTheme.blue),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  value.type.icon,
                                                  color: MyTheme.blue,
                                                  size: 25,
                                                ),
                                                const SizedBox(
                                                  width: 15,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    value.type.title,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .displayMedium,
                                                    maxLines: 1,
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        const SizedBox(height: 10,),
                                        // the edit details button
                                        viewModel!.provider!.user!.uid == viewModel!.room!.ownerId?
                                          TextButton(
                                              onPressed: value.onGoToUpdateRoomDetailsScreenPress,
                                              child:const Text("Edit Room Details")
                                          ):const SizedBox(),
                                      ],
                                    ),
                                  ),
                                ),
                              ))
                        ],
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                        child: ElevatedButton(
                            onPressed: value.onGroupMembersPress,
                            child: const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Icon(
                                EvaIcons.people,
                              ),
                            )),
                      )
                    ],
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  RoomDetailsViewModel initialViewModel() {
    return RoomDetailsViewModel(GetUsersListUseCase(injectUserRepo()));
  }

  @override
  showMyModalBottomSheetWidget(List<Users> users) {
    showModalBottomSheet(
      context: context,
      builder: (context) => MyBottomSheetWidget(users: users),
      backgroundColor: Colors.transparent,
    );
  }

  @override
  goToUpdateRoomDetailsScreen(Room room) {
    Navigator.pushNamed(context, UpdateRoomDetailsView.routeName , arguments: room);
  }
}
