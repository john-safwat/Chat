import 'package:chat/Data/Models/User/UserDTO.dart';

class Users {

  String name ;
  String email ;
  String password;

  Users({
    required this.name,
    required this.email,
    required this.password
  });

  UserDTO toDataSource(){
    return UserDTO(name: name, email: email, password: password);
  }

}