import 'dart:async';

import 'package:chat_appl_v_two/home/home_screen.dart';
import 'package:chat_appl_v_two/model/my_user.dart';
import 'package:chat_appl_v_two/register/register_navigator.dart';
import 'package:chat_appl_v_two/register/register_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chat_appl_v_two/utils.dart' as Utils;

import '../provider/user_provider.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName="RegisterScreen";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> implements RegisterNavigator{
  String firstName="";

  String lastName="";

  String email="";

  String password="";

  String userName="";

  var formKey=GlobalKey<FormState>();

  RegisterViewModel viewModel =RegisterViewModel();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator = this;
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
              title: Text("Create Account"),
            ),
            body: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: "first name"
                        ),
                        onChanged: (text){
                          firstName=text;
                        },
                        validator: (text){
                          if(text == null || text.trim().isEmpty){
                            return "Please enter first name";
                          }else{
                            return null; /// text is validate
                          }
                        },
                      )
                      ,TextFormField(
                        decoration: InputDecoration(
                            labelText: "last name"
                        ),
                        onChanged: (text){
                          lastName=text;
                        },
                        validator: (text){
                          if(text == null || text.trim().isEmpty){
                            return "Please enter first name";
                          }else{
                            return null; /// text is validate
                          }
                        },
                      )
                      ,TextFormField(
                        decoration: InputDecoration(
                            labelText: "user name"
                        ),
                        onChanged: (text){
                          userName=text;
                        },
                        validator: (text){
                          if(text == null || text.trim().isEmpty){
                            return "Please enter first name";
                          }else{
                            return null; /// text is validate
                          }
                        },
                      )
                      ,TextFormField(
                        decoration: InputDecoration(
                            labelText: "email"
                        ),
                        onChanged: (text){
                          email=text;
                        },
                        validator: (text){
                          final bool emailValid =
                          RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(text!);
                          if(text == null || text.trim().isEmpty){
                            return "Please enter first name";
                          }if(!emailValid){
                            return "please enter Valid email";
                          }
                          return null; /// text is validate
                        },
                      )
                      ,TextFormField(
                        decoration: InputDecoration(
                            labelText: "password"
                        ),
                        onChanged: (text){
                          password=text;
                        },
                        validator: (text){
                          if(text == null || text.trim().isEmpty){
                            return "Please enter first name";
                          }if(text.length <6){
                            return "Password must be at least 6 characters";
                          }
                          return null; /// text is validate
      
                        },
                      )
                      ,SizedBox(height: MediaQuery.of(context).size.height*0.02,)
                      ,ElevatedButton(onPressed: (){
                        validateForm();
                      }, child: Text("Create account"))
                    ],),
                )),
          )
      
        ],
      ),
    );
  }

  void validateForm() async {
    if(formKey.currentState?.validate() == true){
      viewModel.registerFireBaseAuth(email, password,firstName , lastName,userName);
    }
  }

  @override
  void hideLoading() {
    Utils.hideLoading(context);
  }

  @override
  void showLoading() {
    Utils.showLoading(context,"Loading....");
  }

  @override
  void showMessage(String message) {
    Utils.showMessage(context, message, "", (context){
      Navigator.pop(context);
    });
  }
  @override
  void navigateToHome(MyUser user) {
    var userProvider =Provider.of<UserProvider>(context,listen: false);
    userProvider.user=user;
    Timer(Duration(seconds: 1),(){
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    }
    );  }
}
