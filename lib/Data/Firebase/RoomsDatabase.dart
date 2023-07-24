import 'package:chat/Data/Models/Room/RoomDTO.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RoomsDatabase {

  // obtain the singleton pattern
  RoomsDatabase._();
  static RoomsDatabase? _instance ;
  static getRoomDatabase(){
    _instance ??= RoomsDatabase._();
    return _instance;
  }

  // get the collection reference from firebase
  CollectionReference<RoomDTO> getRoomCollectionReference (){
    return FirebaseFirestore.instance.collection("Rooms").withConverter(
        fromFirestore: (snapshot, options) => RoomDTO.fromFireStore(snapshot.data()!),
        toFirestore: (value, options) => value.toFireStore(),
    );
  }

  // add room to the database
  Future<void> addRoom(RoomDTO room)async{
    var ref = getRoomCollectionReference();
    var doc = ref.doc();
    room.id = doc.id;
    await doc.set(room);
    await addRoomUser(room.id, room.ownerId);
  }

  Future<void> updateRoomData(RoomDTO room)async{
    var ref = getRoomCollectionReference();
    var doc = ref.doc(room.id);
    await doc.update(room.toFireStore());
  }

  // get the data of the rooms
  Stream<QuerySnapshot<RoomDTO>> getPublicRooms(){
    var ref = getRoomCollectionReference();
    var data = ref.where("type" , isEqualTo: "Public").snapshots();
    return data;
  }

  // get the collection reference of the user in the room
  CollectionReference<String> getRoomUserCollectionReference(String roomId){
    return FirebaseFirestore.instance.collection("Rooms").doc(roomId).collection("Room").withConverter(
      fromFirestore: (snapshot, options) => snapshot.data().toString(),
      toFirestore: (value, options) => {
        'user': value,
      },
    );
  }

  // add room member function
  Future<void> addRoomUser(String roomId, String uid)async{
    var ref = getRoomUserCollectionReference(roomId);
    var doc = ref.doc(uid);
    await doc.set(uid);
  }

}