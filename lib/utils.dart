import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showLoading(BuildContext context ,String text){
  showDialog(context: context, builder: (context){
    return AlertDialog(
      content: Row(children: [CircularProgressIndicator(), Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(text),
      )],),
    );
  }
  );
}
void hideLoading(BuildContext context ){
  Navigator.pop(context);
}
void showMessage(BuildContext context , String message
    ,String positiveActionText , Function positiveAction
,{String? negativeActionText , Function? negativeAction}){
  showDialog(context: context, builder: (context){
    return AlertDialog(
      content: Text(message),
      actions: [
        TextButton(onPressed: (){
          positiveAction(context);
        }, child: Text(positiveActionText))
      ],
    );
  });
}