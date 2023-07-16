import 'package:chat/Core/Theme/MyTheme.dart';
import 'package:flutter/material.dart';

class NegativeActionButton extends StatelessWidget {
  VoidCallback? negativeAction;
  String negativeActionTitle;
  NegativeActionButton({required this.negativeActionTitle , this.negativeAction , super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(MyTheme.white),
            shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side:const BorderSide(width: 2, color: MyTheme.blue),
                )
            )
        ),
        onPressed: (){
          Navigator.pop(context);
          if (negativeAction != null){
            negativeAction!();
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(negativeActionTitle,style: Theme.of(context).textTheme.displayMedium!.copyWith(color: Colors.blue)),
        ),
      )
    );
  }
}
