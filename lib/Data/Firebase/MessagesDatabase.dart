import 'package:chat/Data/Models/Message/MessageDTO.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessagesDatabase {
  MessagesDatabase._();
  static MessagesDatabase? _instance;
  static MessagesDatabase getMessagesDatabase() {
    _instance ??= MessagesDatabase._();
    return _instance!;
  }

  CollectionReference<MessageDTO> getCollectionReference(String roomId) {
    return FirebaseFirestore.instance
        .collection("Rooms")
        .doc(roomId)
        .collection("Messages")
        .withConverter(
          fromFirestore: (snapshot, options) => MessageDTO.fromFireStore(snapshot.data()!),
          toFirestore: (value, options) => value.toFireStore(),
    );
  }

  Future<void> sendMessage(MessageDTO message) async{
    var ref = getCollectionReference(message.roomId);
    var doc = ref.doc();
    message.messageId = doc.id;
    await doc.set(message);
  }

  Stream<QuerySnapshot<MessageDTO>> getRoomMessages(String roomId){
    var ref = getCollectionReference(roomId);
    return ref.snapshots();
  }

}
