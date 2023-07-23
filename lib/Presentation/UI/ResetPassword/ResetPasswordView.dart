import 'package:chat/Domain/UseCase/ResetPasswordUseCase.dart';
import 'package:chat/Presentation/Base/BaseState.dart';
import 'package:chat/Presentation/DI/di.dart';
import 'package:chat/Presentation/Theme/MyTheme.dart';
import 'package:chat/Presentation/UI/GlobalWidgets/CustomTextFormField.dart';
import 'package:chat/Presentation/UI/ResetPassword/ResetPasswordNavigator.dart';
import 'package:chat/Presentation/UI/ResetPassword/ResetPasswordViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ResetPasswordScreen extends StatefulWidget {
  static const String routeName = 'resetScreen';

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState
    extends BaseState<ResetPasswordScreen, ResetPasswordViewModel>
    implements ResetPasswordNavigator {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
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
          title: const Text(
            "Reset Password",
            style: TextStyle(color: MyTheme.white),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SvgPicture.asset(
                "assets/SVG/Forgot password.svg",
                width: 300,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Forgot Password?",
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge!
                      .copyWith(color: MyTheme.blue),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
                child: Text(
                  textAlign: TextAlign.center,
                  "Don't worry! it happens \nPlease Enter the email associated with your account ",
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium!
                      .copyWith(color: MyTheme.black),
                ),
              ),
              MyTextFormField(
                controller: viewModel!.emailResetController,
                inputType: TextInputType.emailAddress,
                label: "Email Address",
                validator: viewModel!.emailValidation,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                child: ElevatedButton(
                    onPressed: viewModel!.resetPassword,
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(MyTheme.blue),
                        elevation: MaterialStateProperty.all(4),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 20),
                      child: Text(
                        "Send Code",
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(
                                fontWeight: FontWeight.bold,
                                color: MyTheme.white
                        ),

                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    ]);
  }

  @override
  ResetPasswordViewModel initialViewModel() {
    return ResetPasswordViewModel(ResetPasswordUseCase(injectAuthRepo()));
  }
}
