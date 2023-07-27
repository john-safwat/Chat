import 'package:animated_expandable_fab/animated_expandable_fab.dart';
import 'package:animated_expandable_fab/expandable_fab/expandable_fab.dart';
import 'package:chat/Domain/Models/Room/Room.dart';
import 'package:chat/Domain/UseCase/GetUserRoomsUseCase.dart';
import 'package:chat/Domain/UseCase/SignOutUseCase.dart';
import 'package:chat/Domain/UseCase/GetPublicRoomsUseCase.dart';
import 'package:chat/Presentation/Base/BaseState.dart';
import 'package:chat/Presentation/DI/di.dart';
import 'package:chat/Presentation/Theme/MyTheme.dart';
import 'package:chat/Presentation/UI/Chat/ChatView.dart';
import 'package:chat/Presentation/UI/Create%20Room/CreateRoomView.dart';
import 'package:chat/Presentation/UI/Home/HomeNavigator.dart';
import 'package:chat/Presentation/UI/Home/HomeViewModel.dart';
import 'package:chat/Presentation/UI/Home/Widgets/Drower.dart';
import 'package:chat/Presentation/UI/Home/Widgets/tabs.dart';
import 'package:chat/Presentation/UI/JoinRoom/JoinRoomView.dart';
import 'package:chat/Presentation/UI/Login/LoginView.dart';
import 'package:chat/Presentation/UI/Search/SearchView.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:floating_action_bubble_custom/floating_action_bubble_custom.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'HomeScreen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseState<HomeScreen, HomeViewModel> with SingleTickerProviderStateMixin
    implements HomeNavigator {
  @override
  HomeViewModel initialViewModel() {
    return HomeViewModel(
      SignOutUseCase(injectAuthRepo()),
      GetPublicRoomsUseCase(injectRoomDataRepo()),
      GetUserRoomsUseCase(injectRoomDataRepo())
    );
  }

  late Animation<double> animation;
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
    );
    final curvedAnimation = CurvedAnimation(
      curve: Curves.easeInOut,
      parent: animationController,
    );
    animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
  }

  @override
  Widget build(BuildContext context) {
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
            DefaultTabController(
              length: 2,
              child: Scaffold(
                appBar: AppBar(
                  title: Text(
                    "Home",
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(color: MyTheme.white),
                  ),
                  actions: [
                    InkWell(
                        onTap: viewModel!.goToSearchScreen,
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          child: Icon(
                            EvaIcons.search,
                            color: MyTheme.white,
                          ),
                        ))
                  ],
                ),
                drawer: HomeScreenDrawer(user: viewModel!.provider!.user! , onSignOutPress: viewModel!.onSignOutPress),
                body:ContainedTabBarView(
                  onChange: (index) {
                    viewModel!.changeSelectedTabIndex(index);
                  },
                  tabBarViewProperties:const TabBarViewProperties(
                    physics: BouncingScrollPhysics()
                  ),
                  tabBarProperties:const TabBarProperties(
                    indicatorColor: MyTheme.white,
                    indicatorPadding: EdgeInsets.symmetric(horizontal: 20),
                  ),
                  tabs: [
                    tabBarButtonWidget("My Rooms"),
                    tabBarButtonWidget("Browse"),
                  ],
                  views: [
                    Column(children: [
                      Tabs(viewModel!.getUserRooms(), viewModel!.goToChatScreen)
                    ]),
                    Column(children: [
                      Tabs(
                        viewModel!.getPublicRooms(),
                        viewModel!.goToJoinRoomScreen,
                        filterData: viewModel!.filterBrowseData,
                      )
                    ]),
                  ],
                ),
                floatingActionButton: Consumer<HomeViewModel>(
                  builder: (context, value, child) => FloatingActionBubble(
                    items: [
                      BubbleMenu(
                        title: "Crate Room",
                        style: Theme.of(context).textTheme.displayMedium!.copyWith(color: MyTheme.white),
                        iconColor: MyTheme.white,
                        bubbleColor: MyTheme.blue,
                        icon: EvaIcons.messageSquare,
                        onPressed: value.goToCreateRoomScreen
                      ),
                      BubbleMenu(
                        title: "Join Room",
                        style: Theme.of(context).textTheme.displayMedium!.copyWith(color: MyTheme.white),
                        iconColor: MyTheme.white,
                        bubbleColor: MyTheme.blue,
                        icon: EvaIcons.messageCircle,
                        onPressed: (){}
                      ),
                    ],
                    onPressed: () => animationController.isCompleted ? animationController.reverse() : animationController.forward(),
                    iconColor: MyTheme.white,
                    iconData: EvaIcons.messageCircle,
                    backgroundColor: MyTheme.blue,
                    animation: animation,
                  ),
                ),
              ),
            ),
          ],
        ),
    );
  }

  Widget tabBarButtonWidget(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: MyTheme.white),
      ),
    );
  }

  @override
  goToSearchScreen() {
    Navigator.pushNamed(context, SearchView.routeName);
  }

  @override
  goToCreateRoomScreen() {
    Navigator.pushNamed(context, CreateRoomView.routeName);
  }

  @override
  goToLoginScreen() {
    Navigator.pushReplacementNamed(context, LoginScreen.routeName);
  }

  @override
  goToJoinRoomScreen(Room room) {
    Navigator.pushNamed(context, JoinRoomScreen.routeName, arguments: room);
  }

  @override
  goToChatScreen(Room room) {
    Navigator.pushNamed(context, ChatView.routeName, arguments: room);
  }
}
