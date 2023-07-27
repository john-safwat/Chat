import 'package:chat/Presentation/Theme/MyTheme.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreenDrawer extends StatelessWidget {
  User user;
  Function onSignOutPress;

  HomeScreenDrawer({
    required this.user ,
    required this.onSignOutPress,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
          )),
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            height: 200,
            decoration: const BoxDecoration(
              color: MyTheme.blue,
            ),
            child: Text(
              user.displayName!,
              style: Theme.of(context)
                  .textTheme
                  .displayLarge!
                  .copyWith(color: MyTheme.white),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: (){onSignOutPress();},
              style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                  elevation: MaterialStateProperty.all(0),
                  backgroundColor:
                  MaterialStateProperty.all(Colors.red)),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Sign Out",
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(color: MyTheme.white),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Icon(
                      EvaIcons.logOut,
                      color: MyTheme.white,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
