import 'package:chat_appl_v_two/database/database_utils.dart';
import 'package:chat_appl_v_two/model/my_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class UserProvider extends ChangeNotifier{
  MyUser? user;
  User? firebaseUser;
  UserProvider(){
    firebaseUser=FirebaseAuth.instance.currentUser;
    initUser();
  }

  void initUser() async{
    if( firebaseUser != null){
     user= await DatabaseUtils.getUser(firebaseUser?.uid??"");
    }
  }
}