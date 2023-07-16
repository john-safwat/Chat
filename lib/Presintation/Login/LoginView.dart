import 'package:chat/Core/Base/BaseState.dart';
import 'package:chat/Core/DI/di.dart';
import 'package:chat/Core/Theme/MyTheme.dart';
import 'package:chat/Domain/UseCase/loginAccountUseCase.dart';
import 'package:chat/Presintation/GlobalWidgets/CustomTextFormField.dart';
import 'package:chat/Presintation/Home/HomeView.dart';
import 'package:chat/Presintation/Login/LoginNavigator.dart';
import 'package:chat/Presintation/Login/LoginViewModel.dart';
import 'package:chat/Presintation/Register/RegisterView.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'LoginScreen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseState<LoginScreen, LoginViewModel>
    implements LoginNavigator {
  @override
  LoginViewModel initialViewModel() {
    return LoginViewModel(LoginAccountUseCase(injectAuthRepo()));
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Consumer<LoginViewModel>(
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
                title: const Text("Login"),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.all(40),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(5, 5))
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Form(
                          key: value.formKey,
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                alignment: Alignment.topLeft,
                                padding: const EdgeInsets.all(20),
                                child: Text(
                                  'Welcome Back!',
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayLarge!
                                      .copyWith(color: MyTheme.blue),
                                ),
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
                              // the create account button in the end of the screen
                              Container(
                                margin: const EdgeInsets.all(20),
                                child: ElevatedButton(
                                    onPressed: value.login,
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
                                          horizontal: 30, vertical: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Log in",
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
                                    "Don't have account?",
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium,
                                  ),
                                  TextButton(
                                    onPressed: value.goToRegisterScreen,
                                    child: Text(
                                      "Register Now!",
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
                          )
                      ),
                    ),
                  ],
                ),
              ),
            )
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
  goToRegisterScreen() {
    Navigator.pushReplacementNamed(context, RegisterScreen.routeName);
  }
}
