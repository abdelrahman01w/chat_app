import 'package:chat_appl_v_two/chat/chat_navigator.dart';
import 'package:chat_appl_v_two/database/database_utils.dart';
import 'package:chat_appl_v_two/model/message.dart';
import 'package:chat_appl_v_two/model/my_user.dart';
import 'package:chat_appl_v_two/model/room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatViewModel extends ChangeNotifier{
 late ChatNavigator navigator;
 late MyUser cuurentUser;
 late Room room;
 late Stream<QuerySnapshot<Message>> streemMessage;
 void sendMessage(String content)async{
  Message  message=Message(
      roomId: room.roomId,
      content: content,
      dateTime: DateTime.now().microsecondsSinceEpoch,
      senderId: cuurentUser.id,
      senderName: cuurentUser.userName);
  try{
   var result = await DatabaseUtils.insertMessage(message);
   // clear message
   navigator.clearMessage();
  }catch(error){
   navigator.showMessage(error.toString());
  }
 }
void lisitenForUpdateRoomMessages(){
  streemMessage =DatabaseUtils.getMessage(room.roomId);
 }
}