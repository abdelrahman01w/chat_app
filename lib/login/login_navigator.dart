import 'package:chat_appl_v_two/model/my_user.dart';

abstract class LoginNavigator{
  void showLoading();
  void hideLoading();
  void showMessage(String message);
  void navigateToHome(MyUser user);
}