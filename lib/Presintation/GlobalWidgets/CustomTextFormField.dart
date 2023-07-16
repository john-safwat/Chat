import 'package:chat/Core/Theme/MyTheme.dart';
import 'package:flutter/material.dart';

class MyTextFormFiled extends StatelessWidget {
  String label;
  TextEditingController controller;
  TextInputType inputType;
  Function validator;
  MyTextFormFiled(
      {required this.label,
        required this.controller,
        required this.inputType,
        required this.validator,
        super.key});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20 , vertical: 10),
      child: TextFormField(
        controller: controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        style: textTheme.displayMedium,
        cursorColor: MyTheme.gray,
        keyboardType: inputType,
        validator: (value) => validator(value),
        cursorHeight: 20,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
          label: Text(
            label,
            style: textTheme.displayMedium,
          ),
          border: const UnderlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: MyTheme.gray,
              )),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: MyTheme.gray,
            ),
          ),
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                width: 3,
                color: MyTheme.blue,
              )),
          errorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                width: 2,
                color: Colors.red,
              )),
          focusedErrorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                width: 2,
                color: Colors.red,
              )),
        ),
      ),
    );
  }
}

class MyPasswordTextFormFiled extends StatefulWidget {
  String label;
  TextEditingController controller;
  TextInputType inputType;
  Function validator;
  MyPasswordTextFormFiled(
      {required this.label,
        required this.controller,
        required this.inputType,
        required this.validator,
        super.key});

  @override
  State<MyPasswordTextFormFiled> createState() =>
      _MyPasswordTextFormFiledState();
}

class _MyPasswordTextFormFiledState extends State<MyPasswordTextFormFiled> {
  bool visiabel = false;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20 , vertical: 10),

      child: TextFormField(
        controller: widget.controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        style: textTheme.displayMedium,
        cursorColor: MyTheme.gray,
        keyboardType: widget.inputType,
        obscureText: !visiabel,
        validator: (value) => widget.validator(value),
        cursorHeight: 20,
        decoration: InputDecoration(
          suffixIcon: InkWell(
            onTap: () {
              setState(() {
                visiabel = !visiabel;
              });
            },
            child: visiabel
                ? const Icon(
              Icons.visibility_outlined,
              color: MyTheme.blue,
            )
                : const Icon(
              Icons.visibility_off_outlined,
              color: MyTheme.blue,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
          label: Text(
            widget.label,
            style: textTheme.displayMedium,
          ),
          border: const UnderlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: MyTheme.gray,
              )),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: MyTheme.gray,
            ),
          ),
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                width: 3,
                color: MyTheme.blue,
              )),
          errorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                width: 2,
                color: Colors.red,
              )),
          focusedErrorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                width: 2,
                color: Colors.red,
              )),
        ),
      ),
    );
  }
}
