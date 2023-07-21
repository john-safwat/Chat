import 'package:chat/Data/Models/User/UserDTO.dart';

class Users {
  String uid;
  String name ;
  String email ;
  String password;

  Users({
    required this.uid,
    required this.name,
    required this.email,
    required this.password
  });

  UserDTO toDataSource(){
    return UserDTO( uid: uid,name: name, email: email, password: password);
  }

}