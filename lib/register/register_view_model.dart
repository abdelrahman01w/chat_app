import 'package:chat_appl_v_two/database/database_utils.dart';
import 'package:chat_appl_v_two/model/my_user.dart';
import 'package:chat_appl_v_two/register/register_navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import '../firebase_erroe_constant.dart';

class RegisterViewModel extends ChangeNotifier{
  late RegisterNavigator navigator ;
  void registerFireBaseAuth( String email , String password , String userName,
      String lastName , String firstName) async {
    navigator.showLoading();
    try {
      ///show loading
      final result = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print("FireBase Auth Id : ${result.user?.uid}");
      /// hide loading
      navigator.hideLoading();
      /// save data user
      var user =MyUser(email: email,
          userName: userName,
          lastName: lastName,
          firstName: firstName,
          id: result.user?.uid??"");
      var dataUser =await DatabaseUtils.registerUSer(user);
      /// show message
      navigator.showMessage("Register successfully");
      navigator.navigateToHome(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == FireBaseErrorsConstant.weakPassword) {
        /// hide loading
        navigator.hideLoading();
        /// show error message
        navigator.showMessage("The password provided is too weak");
        print('The password provided is too weak.');
      } else if (e.code == FireBaseErrorsConstant.emailAlreadyInUse) {
        /// hide loading
        navigator.hideLoading();
        /// show message
        navigator.showMessage("The account already exists for that email");
        print('The account already exists for that email.');
      }
    } catch (e) {
      /// hide loading
      navigator.hideLoading();
      /// show message
      navigator.showMessage("Something went wrong");
      print(e);
    }
  }
}