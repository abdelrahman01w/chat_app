import 'package:chat_appl_v_two/add_room/add_room_screen.dart';
import 'package:chat_appl_v_two/chat/chat_screen.dart';
import 'package:chat_appl_v_two/provider/user_provider.dart';
import 'package:chat_appl_v_two/register/register_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home/home_screen.dart';
import 'login/login_screen.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider(
      create : (context)=> UserProvider(),
      child: MyApp()));
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var userProvider =Provider.of<UserProvider>(context);
    return MaterialApp(
      initialRoute: userProvider.firebaseUser == null ?
      LoginScreen.routeName :HomeScreen.routeName,
      routes: {
        RegisterScreen.routeName: (context) => RegisterScreen()
        ,LoginScreen.routeName: (context) => LoginScreen()
        ,HomeScreen.routeName: (context) => HomeScreen()
        ,AddRoomScreen.routeName: (context)=> AddRoomScreen()
        ,ChatScreen.routeName: (context)=>ChatScreen()
      },
    );
  }
}
