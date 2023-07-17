import 'package:chat/Core/Base/BaseState.dart';
import 'package:chat/Core/Theme/MyTheme.dart';
import 'package:chat/Presintation/Search/SearchNavigator.dart';
import 'package:chat/Presintation/Search/SearchViewModel.dart';
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
            SizedBox(
              width: double.infinity,
              child: Image.asset(
                'assets/images/bgShape.png',
                fit: BoxFit.cover,
              ),
            ),
            Scaffold(
              appBar: AppBar(
                title: Text("Search" , style: Theme.of(context).textTheme.displayMedium!.copyWith(color: MyTheme.white),),
              ),

            ),
          ],
        ),
      ),
    );
  }

  @override
  SearchViewModel initialViewModel() {
    return SearchViewModel();
  }
}
