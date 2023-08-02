import 'package:chat/Domain/Models/Room/Room.dart';
import 'package:chat/Presentation/Base/BaseState.dart';
import 'package:chat/Presentation/Models/RoomCategory.dart';
import 'package:chat/Presentation/Theme/MyTheme.dart';
import 'package:chat/Presentation/UI/RoomDetails/RoomDetailsNavigator.dart';
import 'package:chat/Presentation/UI/RoomDetails/RoomDetailsViewModel.dart';
import 'package:flutter/material.dart';
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
    if(viewModel!.room == null){
      viewModel!.room = ModalRoute.of(context)!.settings.arguments as Room;
      viewModel!.selectedCategory = RoomCategory.getRoomCategory(viewModel!.room!.category);
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
                    child:Container(
                      margin:const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: MyTheme.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: MyTheme.black.withOpacity(0.3),
                            blurRadius: 10,
                            offset:const Offset(0 , 5)
                          )
                        ]
                      ),
                      child: Consumer<RoomDetailsViewModel>(
                        builder: (context, value, child) => Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text("Room Name : ${viewModel!.room!.name}" , style: Theme.of(context).textTheme.displayLarge,),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ),
                ],
              ),
            )
          ],
      ),
    );
  }

  @override
  RoomDetailsViewModel initialViewModel() {
    return RoomDetailsViewModel();
  }
}
