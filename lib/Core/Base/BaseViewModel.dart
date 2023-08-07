import 'package:chat/Core/Base/BaseNavigator.dart';
import 'package:chat/Presentation/Providers/AppConfigProvider.dart';
import 'package:flutter/material.dart';

abstract class BaseViewModel<N extends BaseNavigator> extends ChangeNotifier {
  N? navigator;
  AppConfigProvider? provider;
}