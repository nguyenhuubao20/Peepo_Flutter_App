import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class NotificationApp {
  int count = 0;
  static void show(
    BuildContext context,
    String message, {
    Color backgroundColor = Colors.blue,
    IconData icon = Icons.info,
  }) {
    toastification.show(
      context: context,
      title: Text(message),
      backgroundColor: backgroundColor,
      autoCloseDuration: const Duration(seconds: 3),
      icon: Icon(icon, color: Colors.black),
    );
  }
}
