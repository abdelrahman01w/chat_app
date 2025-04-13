import 'package:chat_appl_v_two/add_room/add_room_navigator.dart';
import 'package:chat_appl_v_two/database/database_utils.dart';
import 'package:chat_appl_v_two/model/room.dart';
import 'package:flutter/material.dart';

class AddRoomViewModel extends ChangeNotifier{
  late AddRoomNavigator navigator;
  void addRoom(String roomTitle , String roomDescription , String categoryId)async{
    Room room =Room(roomId: "",
        title: roomTitle,
        description: roomDescription,
        categoryId: categoryId);
    try{
      navigator.showLoading();
      var createdRoom =await DatabaseUtils.addRoomToFireStore(room);
      navigator.hideLoading();
      navigator.showMessage("Room was added successfully");
      navigator.navigateToHome();
    }catch(e){
      navigator.hideLoading();
      navigator.showMessage(e.toString());
    }
  }
}