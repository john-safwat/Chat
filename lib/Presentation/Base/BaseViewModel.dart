import 'package:chat/Presentation/Base/BaseNavigator.dart';
import 'package:flutter/material.dart';

abstract class BaseViewModel<N extends BaseNavigator> extends ChangeNotifier {
  N? navigator;
}