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
                toolbarHeight: 80,
                leading: Container(),
                leadingWidth: 0,
                title: TextFormField(
                  onChanged: (value) {

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

  @override
  goToHomeScreen() {
    Navigator.pop(context);
  }
}
