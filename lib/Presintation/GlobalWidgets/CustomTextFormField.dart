import 'package:chat/Core/Theme/MyTheme.dart';
import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  String label;
  TextEditingController controller;
  TextInputType inputType;
  Function validator;
  MyTextFormField(
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
          contentPadding: const EdgeInsets.all(20),
          label: Text(
            label,
            style: textTheme.displayMedium,
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide:const BorderSide(
                width: 2,
                color: MyTheme.gray,
              )),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              width: 2,
              color: MyTheme.gray,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                width: 2,
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
      ),
    );
  }
}

class MyPasswordTextFormField extends StatefulWidget {
  String label;
  TextEditingController controller;
  TextInputType inputType;
  Function validator;
  MyPasswordTextFormField(
      {required this.label,
        required this.controller,
        required this.inputType,
        required this.validator,
        super.key});

  @override
  State<MyPasswordTextFormField> createState() =>
      _MyPasswordTextFormFieldState();
}

class _MyPasswordTextFormFieldState extends State<MyPasswordTextFormField> {
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
          contentPadding: const EdgeInsets.all(20),
          label: Text(
            widget.label,
            style: textTheme.displayMedium,
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide:const BorderSide(
                width: 2,
                color: MyTheme.gray,
              )),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              width: 2,
              color: MyTheme.gray,
            ),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                width: 2,
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
      ),
    );
  }
}
