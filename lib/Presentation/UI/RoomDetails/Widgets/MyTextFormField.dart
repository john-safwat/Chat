import 'package:chat/Presentation/Theme/MyTheme.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class MyTextFormField extends StatefulWidget {
  String hintText;
  TextEditingController controller;
  Function validator;
  int? maxLines;

  MyTextFormField({required this.hintText,required this.controller,required this.validator, this.maxLines = 1});

  @override
  State<MyTextFormField> createState() => _MyTextFormFieldState();
}

class _MyTextFormFieldState extends State<MyTextFormField> {
  bool readonly = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 20 ,horizontal: 20),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20)
        ),
        hintText: widget.hintText,
        hintStyle: Theme.of(context).textTheme.displaySmall!.copyWith(color: MyTheme.black.withOpacity(0.7)),
        suffixIcon: InkWell(
            onTap: (){
              setState(() {
                readonly = !readonly;
              });
            },
            child: const Icon(EvaIcons.edit2Outline)
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            width: 1,
            color: MyTheme.gray ,
          ),
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              width: 1,
              color: MyTheme.blue,
            )),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              width: 2,
              color: Colors.red,
            )),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              width: 2,
              color: Colors.red,
            )),
      ),
      controller: widget.controller,
      maxLines: widget.maxLines,
      validator: (value) => widget.validator(value),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: Theme.of(context).textTheme.displayMedium!.copyWith(color: MyTheme.black),
      readOnly: readonly,
    );
  }
}
