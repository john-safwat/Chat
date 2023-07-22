import 'package:cloud_firestore/cloud_firestore.dart';
class RoomsDatabase {


  CollectionReference<UserDTO> getCollectionReference(){
    return FirebaseFirestore.instance.collection("Users").withConverter(
      fromFirestore: (snapshot, options) => UserDTO.fromFireStore(snapshot.data()!),
      toFirestore: (value, options) => value.toFireStore(),
    );
  }


}