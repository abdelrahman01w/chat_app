import 'package:chat_appl_v_two/chat/chat_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/room.dart';

class RoomWidget extends StatelessWidget {
  Room room;
  RoomWidget({required this.room});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).pushNamed(ChatScreen.routeName,arguments: room);
      },
      child: Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.all(15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.blue,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              room.categoryId,
              style: TextStyle(fontSize: 30),
            ),
            Text(
              room.title,
              style: TextStyle(fontSize: 30),
            )
          ],
        ),
      ),
    );
  }
}
