class UserDTO {

  String name ;
  String email ;
  String password;

  UserDTO({
    required this.name,
    required this.email,
    required this.password
  });

  UserDTO.fromFirebase(Map<String , dynamic> json):this(
      name : json['name'],
      email : json['email'],
      password : json['password'],
  );

  Map<String, dynamic> toFirebase(){
    return {
      'name' : name ,
      'email' : email ,
      'password' : password
    };
  }

}