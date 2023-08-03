import 'package:chat/Presentation/Theme/MyTheme.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreenDrawer extends StatelessWidget {
  User user;
  Function onSignOutPress;
  Function onCopyIdPress;


  HomeScreenDrawer({
    required this.user ,
    required this.onSignOutPress,
    required this.onCopyIdPress
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  user.displayName!,
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge!
                      .copyWith(color: MyTheme.white),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20,),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20 ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Your Id" , style: TextStyle(fontSize: 18 , fontWeight: FontWeight.bold),)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SelectableText(
                    maxLines: 1,
                    user.uid,
                    style: Theme.of(context).textTheme.bodyMedium!,
                    onTap: (){
                      Clipboard.setData(ClipboardData(text: user.uid));
                      onCopyIdPress();
                    },
                  ),
                ),
                IconButton(icon: const Icon(EvaIcons.copyOutline) , color: MyTheme.blue ,
                  onPressed: (){
                    Clipboard.setData(ClipboardData(text: user.uid));
                    onCopyIdPress();
                  },
                )
              ],
            ),
          ),
          const Spacer(),
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
