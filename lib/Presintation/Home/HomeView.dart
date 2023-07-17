import 'package:chat/Core/Base/BaseState.dart';
import 'package:chat/Core/Theme/MyTheme.dart';
import 'package:chat/Presintation/Home/HomeNavigator.dart';
import 'package:chat/Presintation/Home/HomeViewModel.dart';
import 'package:chat/Presintation/Search/SearchView.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'HomeScreen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseState<HomeScreen, HomeViewModel>
    implements HomeNavigator {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Consumer<HomeViewModel>(
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
                  "Home",
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium!
                      .copyWith(color: MyTheme.white),
                ),
                actions: [
                  InkWell(
                      onTap: value.goToSearchScreen,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Icon(
                          EvaIcons.search,
                          color: MyTheme.white,
                        ),
                      ))
                ],
              ),
              drawer: const Drawer(),
              floatingActionButton: FloatingActionButton(
                onPressed: () {},
                backgroundColor: MyTheme.blue,
                child: const Icon(
                  EvaIcons.plus,
                  color: MyTheme.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  HomeViewModel initialViewModel() {
    return HomeViewModel();
  }

  @override
  goToSearchScreen() {
    Navigator.pushNamed(context, SearchView.routeName);
  }
}
