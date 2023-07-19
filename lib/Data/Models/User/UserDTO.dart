import 'package:chat/Domain/Models/User/Users.dart';

class UserDTO {

  String uid;
  String name ;
  String email ;
  String password;

  UserDTO({
    required this.uid,
    required this.name,
    required this.email,
    required this.password
  });

  UserDTO.fromFirebase(Map<String , dynamic> json):this(
      uid : json['uid'],
      name : json['name'],
      email : json['email'],
      password : json['password'],
  );

  Map<String, dynamic> toFirebase(){
    return {
      'name' : name ,
      'email' : email ,
      'password' : password,
      'uid' : uid,
    };
  }
}