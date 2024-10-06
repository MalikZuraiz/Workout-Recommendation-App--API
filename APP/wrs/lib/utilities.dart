import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';

class Utilies
{
  static void flushtoastmessage(String message,BuildContext context)
  {
    showFlushbar(context: context, flushbar: Flushbar(
      message: message,
      backgroundColor: Colors.red,
      title: 'Notification',
      messageColor: Colors.black,

      forwardAnimationCurve: Curves.decelerate,
      margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      padding: const EdgeInsets.all(25),
      titleColor: Colors.white,
      borderRadius: BorderRadius.circular(10),
      reverseAnimationCurve: Curves.easeOut,
      flushbarPosition: FlushbarPosition.TOP,

      duration: const Duration(
        seconds: 3
      ),

    )..show(context));
    
  }
}