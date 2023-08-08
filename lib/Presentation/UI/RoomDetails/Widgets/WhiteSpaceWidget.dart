import 'package:chat/Core/Theme/MyTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WhiteSpaceWidget extends StatelessWidget {
  const WhiteSpaceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0 , vertical: 15),
      child: Divider(
        thickness: 1,
        color: MyTheme.gray,
      ),
    );
  }
}
