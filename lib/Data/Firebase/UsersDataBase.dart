import 'package:chat/Data/Models/User/UserDTO.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UsersDataBase{

  UsersDataBase._();
  static UsersDataBase? _instance;
  static getUserDatabaseInstance(){
    _instance ??= UsersDataBase._();
    return _instance;
  }

  CollectionReference<UserDTO> getCollectionReference(){
    return FirebaseFirestore.instance.collection("Users").withConverter(
        fromFirestore: (snapshot, options) => UserDTO.fromFirebase(snapshot.data()!),
        toFirestore: (value, options) => value.toFirebase(),
    );
  }

  Future<void> addUser(UserDTO user)async{
    var ref = getCollectionReference();
    var doc = ref.doc(user.uid);
    await doc.set(user);
  }
  Future<bool> userExist(String uid)async{
    var ref = getCollectionReference();
    var doc = await ref.doc(uid).get();
    return doc.exists;
  }
}