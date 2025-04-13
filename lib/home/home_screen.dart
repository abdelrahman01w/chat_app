import 'package:chat_appl_v_two/add_room/add_room_screen.dart';
import 'package:chat_appl_v_two/add_room/room_widget.dart';
import 'package:chat_appl_v_two/database/database_utils.dart';
import 'package:chat_appl_v_two/home/home_navigator.dart';
import 'package:chat_appl_v_two/home/home_view_midel.dart';
import 'package:chat_appl_v_two/model/room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName="homeScreen";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> implements HomeNavigator{
  @override
  void initState() {
    // TODO: implement initState
    viewModel.navigator=this;
  }
  HomeViewModel viewModel = HomeViewModel();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=>viewModel,
      child: Stack(
        children: [
        Container(color: Colors.white,)
      ,Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
      backgroundColor: Colors.blue,
      elevation: 0,
      centerTitle: true,
      title: Text("Home Screen"),
      ),
            floatingActionButton: FloatingActionButton(
              onPressed: (){
                Navigator.of(context).pushNamed(AddRoomScreen.routeName);
              },
              child: Icon(Icons.add),
            ),
            body: StreamBuilder<QuerySnapshot<Room>>(
              stream: DatabaseUtils.getRooms(),
              builder: (context,asyncSnapshot){
                if(asyncSnapshot.connectionState==ConnectionState.waiting){
                  return Center(
                    child: CircularProgressIndicator(color: Colors.blue,),
                  );
                }else if(asyncSnapshot.hasError){
                  return Text(asyncSnapshot.hasError.toString());
                }else{
                  //has data
                  var roomList=asyncSnapshot.data?.docs.map((doc)=>doc.data()).toList() ??[];
                  return GridView.builder(
                      itemBuilder: (context,index){
                        return RoomWidget(room: roomList[index]);
                      }, 
                      itemCount: roomList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        mainAxisSpacing: 8
                          ,crossAxisSpacing: 8
                      ));
                }
              },
            ),
          )
        ]
      ),
    );
  }
}
