import 'package:chat_appl_v_two/database/database_utils.dart';
import 'package:chat_appl_v_two/firebase_erroe_constant.dart';
import 'package:chat_appl_v_two/login/login_navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class LoginViewModel extends ChangeNotifier {
  late LoginNavigator loginNavigator;
  void loginFireBaseAuth(String email, String password) async {
    try {
      loginNavigator.showLoading();
      final result = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      loginNavigator.hideLoading();
      loginNavigator.showMessage("login successfully");
      var userObj = await DatabaseUtils.getUser(result.user?.uid??"");
      if(userObj == null){
        loginNavigator.hideLoading();
        loginNavigator.showMessage("Register failed please try again");
      }else{
        loginNavigator.hideLoading();
        loginNavigator.navigateToHome(userObj);
      }
    } on FirebaseAuthException catch (e) {
      //if (e.code == 'user-not-found') {
        loginNavigator.hideLoading();
        /// show message
        loginNavigator.showMessage('login is failed please check of your data');
        print(e.message.toString());
      //}
      //else if (e.code == 'wrong-password') {
      //   /// hide loading
      //   loginNavigator.hideLoading();
      //   /// show message
      //   loginNavigator.showMessage("Wrong password provided for that user");
      //   print('Wrong password provided for that user.');
      //}
    }
  }
}