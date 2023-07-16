import 'package:chat/Core/Base/BaseState.dart';
import 'package:chat/Core/DI/di.dart';
import 'package:chat/Core/Dialogs/DialogUtils.dart';
import 'package:chat/Core/Providers/AppConfigProvider.dart';
import 'package:chat/Core/Theme/MyTheme.dart';
import 'package:chat/Domain/UseCase/CreateAccountUseCase.dart';
import 'package:chat/Presintation/GlobalWidgets/CustomTextFormField.dart';
import 'package:chat/Presintation/Home/HomeView.dart';
import 'package:chat/Presintation/Register/RegisterNavigator.dart';
import 'package:chat/Presintation/Register/RegisterViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'RegisterScreen';
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends BaseState<RegisterScreen, RegisterViewModel>
    implements RegisterNavigator {
  @override
  RegisterViewModel initialViewModel() {
    return RegisterViewModel(CreateAccountUseCase(injectAuthRepo()));
  }

  @override
  void initState() {
    super.initState();
    viewModel!.provider =
        Provider.of<AppConfigProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RegisterViewModel>(
      create: (context) => viewModel!,
      child: Consumer<RegisterViewModel>(
        builder: (context, value, child) => Stack(
          children: [
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
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                title: const Text("Create Account"),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Container(
                      margin: const EdgeInsets.all(20),
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(5, 5))
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30)),
                      child: Form(
                          key: value.fromKey,
                          child: Column(
                            children: [
                              // the text Fields
                              MyTextFormField(
                                label: "Name",
                                controller: value.nameController,
                                inputType: TextInputType.name,
                                validator: value.nameValidation,
                              ),
                              MyTextFormField(
                                label: "Email",
                                controller: value.emailController,
                                inputType: TextInputType.emailAddress,
                                validator: value.emailValidation,
                              ),
                              MyPasswordTextFormField(
                                label: "Password",
                                controller: value.passwordController,
                                inputType: TextInputType.visiblePassword,
                                validator: value.passwordValidation,
                              ),
                              MyPasswordTextFormField(
                                label: "Confirm Password",
                                controller:
                                    value.passwordConfirmationController,
                                inputType: TextInputType.visiblePassword,
                                validator: value.passwordValidation,
                              ),
                              // the create account button in the end of the screen
                              Container(
                                margin: const EdgeInsets.all(20),
                                child: ElevatedButton(
                                    onPressed: value.register,
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                MyTheme.blue),
                                        elevation: MaterialStateProperty.all(4),
                                        shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ))),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30, vertical: 15),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Create Account",
                                            style: Theme.of(context)
                                                .textTheme
                                                .displayLarge!
                                                .copyWith(color: MyTheme.white),
                                          ),
                                          const Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            color: MyTheme.white,
                                          ),
                                        ],
                                      ),
                                    )),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Don't Have Account ?",
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium,
                                  ),
                                  TextButton(
                                    onPressed: value.goToLoginScreen,
                                    child: Text(
                                      "Create One",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium!
                                          .copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: MyTheme.blue),
                                    ),
                                  )
                                ],
                              )
                            ],
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  goToHomeScreen() {
    Navigator.pushReplacementNamed(context, HomeScreen.routeName);
  }

  @override
  goToLoginScreen() {
    Navigator.pushReplacementNamed(context, HomeScreen.routeName);
  }


}
