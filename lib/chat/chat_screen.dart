import 'package:chat_appl_v_two/chat/chat_navigator.dart';
import 'package:chat_appl_v_two/chat/chat_view_model.dart';
import 'package:chat_appl_v_two/chat/message_widget.dart';
import 'package:chat_appl_v_two/model/message.dart';
import 'package:chat_appl_v_two/model/room.dart';
import 'package:chat_appl_v_two/provider/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chat_appl_v_two/utils.dart'as Utils;

class ChatScreen extends StatefulWidget {
  static const String routeName = "chat screen";

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> implements ChatNavigator {
  @override
  ChatViewModel viewModel = ChatViewModel();
  String messageContent="";
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator = this;
  }

  Widget build(BuildContext context) {
    var args=ModalRoute.of(context)?.settings.arguments as Room;
    var provider =Provider.of<UserProvider>(context);
    viewModel.room=args;
    viewModel.cuurentUser=provider.user!;
    viewModel.lisitenForUpdateRoomMessages();
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
                Expanded(child:StreamBuilder<QuerySnapshot<Message>>(
                    stream: viewModel.streemMessage,
                    builder: (context,asyncSnapshot){
                      if(asyncSnapshot.connectionState==ConnectionState.waiting){
                        return Center(child: CircularProgressIndicator(),);
                      }else if(asyncSnapshot.hasError){
                        return Text(asyncSnapshot.error.toString());
                      }else{
                        var messagesList=asyncSnapshot.data?.docs.map((doc)=>doc.data()).toList()??[];
                       return ListView.builder(
                            itemBuilder: (context,index){
                              return MessageWidget(message:messagesList[index]);
                            }
                            ,itemCount: messagesList.length,);
                      }
                    })),
                Row(
                  children: [
                    Expanded(child: TextField(
                      controller: controller,
                      onChanged: (text){
                        messageContent = text;
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(4),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.only(topRight: Radius.circular(12))
                        ),
                        hintText: "Type a message",
                      ),
                    ))
                    ,SizedBox(width: 12)
                    ,ElevatedButton(onPressed: (){
                      viewModel.sendMessage(messageContent);
                    }, child: Row(
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

  @override
  void showMessage(String message) {
    Utils.showMessage(context, message, "ok", (context){
      Navigator.pop(context);
    });
  }

  @override
  void clearMessage(){
    controller.clear();
  }
}
