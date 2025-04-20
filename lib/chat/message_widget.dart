import 'package:chat_appl_v_two/model/message.dart';
import 'package:chat_appl_v_two/provider/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MessageWidget extends StatelessWidget {
  Message message;
  MessageWidget({required this.message});
  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<UserProvider>(context);
    return provider.user!.id==message.senderId
         ? SentMessage(message: message) : RecieveMessage(message: message,);
  }
}
class SentMessage extends StatelessWidget {
  Message message;
  SentMessage({required this.message});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
      Container(
        padding: EdgeInsets.symmetric(horizontal: 8 , vertical: 24),
        decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius:
        BorderRadius.only(topRight: Radius.circular(12),
            topLeft: Radius.circular(12),
            bottomLeft: Radius.circular(12))),
        child: Text(message.content,style: TextStyle(
            color: Colors.white
        ),),
      ),
    ],);
  }
}
class RecieveMessage extends StatelessWidget {
  Message message;
  RecieveMessage({required this.message});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Container(
        padding: EdgeInsets.symmetric(horizontal: 8 , vertical: 24),
        decoration: BoxDecoration(
            color: Colors.grey.shade700,
            borderRadius:
        BorderRadius.only(topRight: Radius.circular(12),
            topLeft: Radius.circular(12),
            bottomRight: Radius.circular(12))),
        child: Text(message.content,style: TextStyle(
            color: Colors.black
                ,fontWeight: FontWeight.bold
        ),),
      ),

    ],);
  }
}

