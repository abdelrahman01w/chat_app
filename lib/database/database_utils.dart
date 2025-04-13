import 'package:chat_appl_v_two/model/room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/my_user.dart';

class DatabaseUtils{
  static CollectionReference<MyUser> getUserCollection(){
    return FirebaseFirestore.instance.collection(MyUser.collectionName).withConverter(
        fromFirestore: ((snapshot , options) => MyUser.fromJson(snapshot.data()!)),
        toFirestore: (user , options ) => user.toJson());
  }
  static CollectionReference<Room> getRoomCollection(){
    return FirebaseFirestore.instance.collection(Room.collectionName).withConverter(
        fromFirestore: ((snapshot , options) => Room.fromJson(snapshot.data()!)),
        toFirestore: (room , options ) => room.toJson());
  }
  static Future<void> registerUSer(MyUser user) async {
   return getUserCollection().doc(user.id).set(user);
  }
  static Future<MyUser?> getUser(String userId) async{
   var documentSnapshot = await getUserCollection().doc(userId).get();
   return documentSnapshot.data();
  }
  static Future<void> addRoomToFireStore(Room room)async{
    var docRef= getRoomCollection().doc();
    room.roomId=docRef.id;
    return docRef.set(room);
  }
  static Stream<QuerySnapshot<Room>> getRooms(){
    return getRoomCollection().snapshots();
  }
}