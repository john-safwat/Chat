import 'package:chat/Presentation/Theme/MyTheme.dart';
import 'package:flutter/material.dart';

class PosActionButton extends StatelessWidget {
  VoidCallback? posAction;
  String posActionTitle;
  PosActionButton({required this.posActionTitle , this.posAction , super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child:  ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(MyTheme.blue),
                shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    )
                )
            ),
            onPressed: (){
              Navigator.pop(context);
              if (posAction != null){
                posAction!();
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(posActionTitle,style: Theme.of(context).textTheme.displayMedium!.copyWith(color: Colors.white)),
            )
        )
    );
  }
}
