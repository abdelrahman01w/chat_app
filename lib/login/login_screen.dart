import 'dart:async';

import 'package:chat_appl_v_two/home/home_screen.dart';
import 'package:chat_appl_v_two/login/login_navigator.dart';
import 'package:chat_appl_v_two/login/login_view_model.dart';
import 'package:chat_appl_v_two/model/my_user.dart';
import 'package:chat_appl_v_two/register/register_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:chat_appl_v_two/utils.dart' as Utils;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/user_provider.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName="loginScreen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> implements LoginNavigator{
  String email="";
  String password="";
  var formKey=GlobalKey<FormState>();
  LoginViewModel viewModel =LoginViewModel();
  @override
  @override
  void initState() {
    viewModel.loginNavigator = this;
    super.initState();
  }
  Widget build(BuildContext context) {
    return  Stack(
      children: [
        Container(color: Colors.white,)
        ,Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.blue,
            elevation: 0,
            centerTitle: true,
            title: Text("Login"),
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
                    }, child: Text("Login"))
                    ,SizedBox(height: MediaQuery.of(context).size.height*0.02,)
                    ,TextButton(onPressed: (){
                      Navigator.of(context).pushNamed(RegisterScreen.routeName);
                    }, child: Text("Don't have an account"))
                  ],),
              )),
        )

      ],
    );
  }

  void validateForm() {
   if(formKey.currentState?.validate()==true){
     //login
     viewModel.loginFireBaseAuth(email, password);
   }
  }

  @override
  void hideLoading() {
    Utils.hideLoading(context);
  }

  @override
  void showLoading() {
    Utils.showLoading(context,"Loading...");
  }
  @override
  void navigateToHome(MyUser user) {
    var userProvider =Provider.of<UserProvider>(context,listen: false);
    userProvider.user=user;
    Timer(Duration(seconds:   1),(){
    Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    }
    ); /// late 4 seconds
  }
  @override
  void showMessage(String message) {
    Utils.showMessage(context, message,
        "", (context){
      Navigator.of(context).pushNamed(HomeScreen.routeName);
        });
  }

}
