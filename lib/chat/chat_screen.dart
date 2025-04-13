import 'package:chat_appl_v_two/chat/chat_navigator.dart';
import 'package:chat_appl_v_two/chat/chat_view_model.dart';
import 'package:chat_appl_v_two/model/room.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  static const String routeName = "chat screen";

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> implements ChatNavigator {
  @override
  ChatViewModel viewModel = ChatViewModel();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator = this;
  }

  Widget build(BuildContext context) {
    var args=ModalRoute.of(context)?.settings.arguments as Room;
    return ChangeNotifierProvider(
        create: (context) => viewModel,
        child: Stack(children: [
          Container(
            color: Colors.white,
          ),
          Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colors.blue,
                elevation: 0,
                centerTitle: true,
                title: Text(args.title),
              ),
          body: Container(
            margin: EdgeInsets.symmetric(horizontal: 18 , vertical: 32 ),
            padding: EdgeInsets.all(12),
            width: double.infinity,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: 0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.circular(18)
                ,color: Colors.white
            ),
            child: Column(
              children: [
                Expanded(child: Container()),
                Row(
                  children: [
                    Expanded(child: TextField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(4),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.only(topRight: Radius.circular(12))
                        ),
                        hintText: "Type a message",
                      ),
                    ))
                    ,SizedBox(width: 12)
                    ,ElevatedButton(onPressed: (){}, child: Row(
                      children: [
                      Text("send"),
                      SizedBox(width: 10,),
                      Icon(Icons.send)
                    ],))
                  ],
                )
              ],
            ),
          ),
          ),
        ]));
  }
}
