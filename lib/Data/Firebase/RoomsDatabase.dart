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
  CollectionReference<RoomDTO> getCollectionReference (){
    return FirebaseFirestore.instance.collection("Rooms").withConverter(
        fromFirestore: (snapshot, options) => RoomDTO.fromFireStore(snapshot.data()!),
        toFirestore: (value, options) => value.toFireStore(),
    );
  }

  // add room to the database
  Future<void> addRoom(RoomDTO room)async{
    var ref = getCollectionReference();
    var doc = ref.doc();
    room.id = doc.id;
    await doc.set(room);
  }

}