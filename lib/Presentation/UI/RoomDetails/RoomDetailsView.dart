import 'package:chat/Domain/Models/Room/Room.dart';
import 'package:chat/Domain/UseCase/CreateAccountUseCase.dart';
import 'package:chat/Domain/UseCase/GetUsersListUseCase.dart';
import 'package:chat/Presentation/Base/BaseState.dart';
import 'package:chat/Presentation/DI/di.dart';
import 'package:chat/Presentation/Models/RoomCategory.dart';
import 'package:chat/Presentation/Theme/MyTheme.dart';
import 'package:chat/Presentation/UI/RoomDetails/RoomDetailsNavigator.dart';
import 'package:chat/Presentation/UI/RoomDetails/RoomDetailsViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class RoomDetailsView extends StatefulWidget {
  static const String routeName = "RoomDetailsScreen";
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
      viewModel!.selectedCategory =
          RoomCategory.getRoomCategory(viewModel!.room!.category);
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
                      return Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Room Name : ${viewModel!.room!.name}",
                                style: Theme.of(context)
                                    .textTheme
                                    .displayLarge!
                                    .copyWith(color: MyTheme.black),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 10),
                              child: Text(
                                "${viewModel!.room!.type} . ${viewModel!.room!.users.length} Participants ",
                                style: Theme.of(context)
                                    .textTheme
                                    .displayLarge!
                                    .copyWith(color: MyTheme.black),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 10),
                              child: Text(
                                "Room Type : ${viewModel!.room!.category}",
                                style: Theme.of(context)
                                    .textTheme
                                    .displayLarge!
                                    .copyWith(color: MyTheme.black),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 10),
                              child: Text(
                                "Room Description : ${viewModel!.room!.description}",
                                style: Theme.of(context)
                                    .textTheme
                                    .displayLarge!
                                    .copyWith(color: MyTheme.black),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12 ,horizontal: 10),
                              child: Text("Members" ,
                                style: Theme.of(context).textTheme.displayLarge!.copyWith(color: MyTheme.black.withOpacity(0.5)),
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemBuilder: (context, index) => Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10 , vertical: 12),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text("${viewModel!.users[index].name} " ,
                                            style: Theme.of(context).textTheme.displayMedium!.copyWith(fontWeight: FontWeight.bold ,color: MyTheme.blue),
                                            maxLines: 1,
                                          ),
                                          SelectableText(
                                            onTap: (){
                                              Clipboard.setData(ClipboardData(text: value.users[index].uid));
                                            },
                                            ": ${value.users[index].uid}",
                                            style: Theme.of(context).textTheme.displaySmall!.copyWith(fontWeight: FontWeight.bold),
                                            maxLines: 1,

                                          ),
                                        ],
                                      ),

                                    ],
                                  ),
                                ),
                                itemCount: value.users.length,
                              ),
                            )
                          ],
                        ),
                      );
                    }
                  }),
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
    return RoomDetailsViewModel(GetUsersListUseCase(injectUserRepo()));
  }
}
