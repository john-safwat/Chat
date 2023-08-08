import 'package:chat/Core/Base/BaseState.dart';
import 'package:chat/Core/Theme/MyTheme.dart';
import 'package:chat/Domain/Models/Room/Room.dart';
import 'package:chat/Domain/UseCase/SearchForRoomsUseCase.dart';
import 'package:chat/Presentation/DI/di.dart';
import 'package:chat/Presentation/UI/Chat/ChatView.dart';
import 'package:chat/Presentation/UI/GlobalWidgets/CardWidget.dart';
import 'package:chat/Presentation/UI/JoinRoom/JoinRoomView.dart';
import 'package:chat/Presentation/UI/Search/SearchNavigator.dart';
import 'package:chat/Presentation/UI/Search/SearchViewModel.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});
  static const String routeName = "SearchScreen";
  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends BaseState<SearchView , SearchViewModel> implements SearchNavigator {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Consumer<SearchViewModel>(

        builder:(context, value, child) => Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              color: MyTheme.white,
            ),
            Image.asset(
              'assets/images/bgShape.png',
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Scaffold(
              appBar: AppBar(
                toolbarHeight: 80,
                leading: Container(),
                leadingWidth: 0,
                title: TextFormField(
                  onChanged: (value) {
                    viewModel!.search(value);
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(color: MyTheme.blue),
                  cursorColor: MyTheme.gray,
                  decoration: InputDecoration(
                    contentPadding:const EdgeInsets.all(10),
                    hintText: "Search",

                    suffixIcon: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Icon(EvaIcons.search , color: MyTheme.blue,),
                    ),
                    prefixIcon: InkWell(
                      borderRadius: BorderRadius.circular(100),
                      onTap: value.goToHomeScreen,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 14),
                        child: Icon(EvaIcons.arrowIosBack ,color: MyTheme.blue,),
                      ),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide:const BorderSide(
                          width: 2,
                          color: MyTheme.white,
                        )),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: const BorderSide(
                        width: 2,
                        color: MyTheme.white,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: const BorderSide(
                          width: 1,
                          color: MyTheme.blue,
                        )),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: const BorderSide(
                          width: 2,
                          color: Colors.red,
                        )),
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: const BorderSide(
                          width: 2,
                          color: Colors.red,
                        )),
                  ),
                )
              ),
              body: Consumer<SearchViewModel>(
                builder: (context, value, child) {
                  if(value.errorMessage != null){
                    return Center(
                      child: Text(value.errorMessage! ,style: Theme.of(context).textTheme.displayMedium,),
                    );
                  }else if (value.rooms.isEmpty){
                    return Center(
                      child: Text("No Rooms Appear" ,style: Theme.of(context).textTheme.displayMedium,),
                    );
                  }else {
                    return GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                          childAspectRatio: 0.77),
                      padding: const EdgeInsets.all(20),
                      itemCount: value.rooms.length,
                      itemBuilder: (context, index) => CardWidget(room: value.rooms[index], navigate: value.rooms[index].users.contains(value.uid)?value.goToChatScreen : value.goToJoinRoomScreen),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  SearchViewModel initialViewModel() {
    return SearchViewModel(SearchForRoomsUseCase(injectRoomDataRepo()));
  }

  @override
  goToChatScreen(Room room) {
    Navigator.pushNamed(context, ChatView.routeName , arguments: room);
  }

  @override
  goToJoinRoomScreen(Room room) {
    Navigator.pushNamed(context, JoinRoomScreen.routeName , arguments: room);
  }
}
