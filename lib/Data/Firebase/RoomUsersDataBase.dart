import 'package:chat/Data/Models/User/UserDTO.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RoomUsersDatabase {

  RoomUsersDatabase._();
  static RoomUsersDatabase? _instance;
  static RoomUsersDatabase getRoomUsersDatabase(){
    _instance ??= RoomUsersDatabase._();
    return _instance!;
  }

  CollectionReference<UserDTO> getCollectionReference(String roomId) {
    return FirebaseFirestore.instance
        .collection("Rooms")
        .doc(roomId)
        .collection("Users")
        .withConverter(
      fromFirestore: (snapshot, options) => UserDTO.fromFirebase(snapshot.data()!),
      toFirestore: (value, options) => value.toFirebase(),
    );
  }

  Future<void> addRoomMember(String roomId , UserDTO user)async {
    var ref = getCollectionReference(roomId);
    await ref.doc(user.uid).set(user);
  }

  Future<void> removeRoomMember(String roomId , String userId)async {
    var ref = getCollectionReference(roomId);
    await ref.doc(userId).delete();
  }

  Future<List<UserDTO>> getRoomUsersList(String roomId)async{
    var ref = getCollectionReference(roomId);
    var data = await ref.get();
    return data.docs.map((e) => e.data()).toList();
  }

}