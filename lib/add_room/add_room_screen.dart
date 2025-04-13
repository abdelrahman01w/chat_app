import 'dart:async';

import 'package:chat_appl_v_two/add_room/add_room_navigator.dart';
import 'package:chat_appl_v_two/add_room/add_room_view_model.dart';
import 'package:chat_appl_v_two/model/category.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chat_appl_v_two/utils.dart' as Utils;

class AddRoomScreen extends StatefulWidget {
  static const String routeName="AddRoomScreen";
  const AddRoomScreen({super.key});

  @override
  State<AddRoomScreen> createState() => _AddRoomScreenState();
}

class _AddRoomScreenState extends State<AddRoomScreen> implements AddRoomNavigator{
  AddRoomViewModel viewModel = AddRoomViewModel();
  String roomTitle="";
  String roomDescription="";
  var formKey= GlobalKey<FormState>();
  var categoryList=Category.getCategory();
  late Category selectedItem;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator=this;
    selectedItem=categoryList[0];
  }
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
                title: Text("Add new room"),
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
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                      Text("create new room",style: TextStyle(
                        fontSize: 18 ,color: Colors.black
                      ),textAlign: TextAlign.center,)
                      ,TextFormField(
                        decoration: InputDecoration(
                          hintText: "Enter room title"
                        ),
                        onChanged: (text){
                          roomTitle=text;
                        },
                        validator: (text){
                          if(text==null || text.trim().isEmpty){
                            return 'Please enter room title';
                          }
                        },
                      ),
                      SizedBox(height: 12,)
                      ,TextFormField(
                        decoration: InputDecoration(
                            hintText: "Enter room description"
                        ),
                        onChanged: (text){
                          roomDescription=text;
                        },
                        validator: (text){
                          if(text==null || text.trim().isEmpty){
                            return 'Please enter room description';
                          }
                        },
                        maxLines: 4,
                      ),
                      SizedBox(height: 12,),
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButton<Category>(
                              value:selectedItem ,
                                items: categoryList.map((category)=>
                                DropdownMenuItem<Category>(
                                  value: category,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                    Text(category.title)
                                  ],),
                                )).toList()
                                , onChanged: (newCategory){
                                if(newCategory==null){
                                  return;
                                }
                                selectedItem=newCategory;
                                setState(() {

                                });
                            }),
                          ),
                        ],
                      )
                      ,SizedBox(height: 20,),
                      ElevatedButton(
                          onPressed: (){
                            validateForm();
                          },
                          child: Text("add room"))

                    ],),
                  ),
                ),
              ),
            )
          ]
      ),
    );
  }

  void validateForm() {
    if(formKey.currentState?.validate()==true){
      // add room
      viewModel.addRoom(roomTitle, roomDescription, selectedItem.id);
    }
  }

  @override
  void hideLoading() {
    // TODO: implement hideLoading
    Utils.hideLoading(context);
  }

  @override
  void navigateToHome() {
    // TODO: implement navigateToHome
    Timer(Duration(seconds: 2),(){
      Navigator.pop(context);
    });

  }

  @override
  void showLoading() {
    // TODO: implement showLoading
    Utils.showLoading(context, "Loading...");
  }

  @override
  void showMessage(String message) {
    // TODO: implement showMessage
    Utils.showMessage(context, message, "ok", (context){
      Navigator.pop(context);
    });
  }
}
