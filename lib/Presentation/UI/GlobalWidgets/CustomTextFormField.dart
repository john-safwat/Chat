import 'package:chat/Core/Theme/MyTheme.dart';
import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  String label;
  TextEditingController controller;
  TextInputType inputType;
  Function validator;
  int? maxLinesNumber;
  bool contained;
  MyTextFormField(
      {required this.label,
        required this.controller,
        required this.inputType,
        required this.validator,
        this.maxLinesNumber = 1,
        this.contained = false,
        super.key});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20 , vertical: 10),
      decoration: BoxDecoration(
        boxShadow:contained? []: [
          BoxShadow(
            color: MyTheme.gray.withOpacity(0.3),
            offset: const Offset(0, 3),
            blurRadius: 10,
          )
        ]
      ),
      child: TextFormField(
        maxLines: maxLinesNumber,
        controller: controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        style: textTheme.displayMedium,
        cursorColor: MyTheme.gray,
        keyboardType: inputType,
        validator: (value) => validator(value),
        cursorHeight: 20,
        decoration: InputDecoration(
          fillColor: MyTheme.white,
          filled: true,
          contentPadding: const EdgeInsets.all(20),
          hintText: label,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                width: 1,
                color: contained? MyTheme.blue :MyTheme.white,
              )),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              width: 1,
              color:contained? MyTheme.blue :MyTheme.white,
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
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: MyTheme.gray.withOpacity(0.3),
              offset: const Offset(0, 3),
              blurRadius: 10,
            )
          ]
      ),
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
          fillColor: MyTheme.white,
          filled: true,
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
          hintText: widget.label,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide:const BorderSide(
                width: 2,
                color: MyTheme.white,
              )),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              width: 2,
              color: MyTheme.white,
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
      ),
    );
  }
}
