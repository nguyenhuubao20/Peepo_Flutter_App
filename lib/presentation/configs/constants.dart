import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';

const kPrimaryColor = Color(0xff2ecc71);
const klightPrimaryColor = Color(0xff83f28f);
const kDarkPrimaryColor = Color(0xff1d4d4f);
const kLowTextColor = Color(0xff989da3);
const klowTextGrey = Color(0xfff4b5563);
const kbgWhiteColor = Color.fromARGB(255, 246, 242, 250);
const klighGreyColor = Color(0xffececf1);
const kErrorTextColor = Color(0xffba1c1c);
const kRedColor = Color(0xffe74c3c);
const kbgYellow = Color(0xfffffbe6);
const kYellow = Color(0xfffaad14);

//strings
const String baseURL = 'https://unibean-api.azurewebsites.net/api/v1/';

//RegExp
final RegExp emailValidationRegExp =
    RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');

final RegExp textOnlyPattern = RegExp(r'^[a-zA-Z ]+$');

final RegExp vietNameseTextOnlyPattern = RegExp(
    r'^[a-zA-ZÀÁÂÃÈÉÊÌÍÒÓÔÕÙÚĂĐĨŨƠàáâãèéêìíòóôõùúăđĩũơƯĂẠẢẤẦẨẪẬẮẰẲẴẶẸẺẼỀỀỂưăạảấầẩẫậắằẳẵặẹẻẽềềểỄỆỈỊỌỎỐỒỔỖỘỚỜỞỠỢỤỦỨỪễếệỉịọỏốồổỗộớờởỡợụủứừỬỮỰỲỴÝỶỸửữựỳỵỷỹ ]+$');

final RegExp passwordPattern = RegExp(
  r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
);

final RegExp userNamePattern = RegExp(r'^(?=.*[a-z0-9])[a-z0-9]{5,50}$');

final RegExp phoneNumberPattern = RegExp(r'^\d{9}$');

final RegExp numberRegExp = RegExp(r'^[0-9]+$');

//function
String changeFormateDate(String dateTime) {
  DateTime formatDate = DateTime.parse(dateTime);
  String formattedDate = DateFormat('dd/MM/yyyy').format(formatDate);
  return formattedDate;
}

//format
var formatter = NumberFormat.decimalPattern();

//others
final GoogleSignIn googleSignIn = GoogleSignIn();

TimeOfDay parseTimeString(String timeString) {
  // Splitting the time string by ":" and converting the parts to integers
  List<String> parts = timeString.split(":");
  int hour = int.parse(parts[0]);
  int minute = int.parse(parts[1]);

  // Creating a TimeOfDay instance
  return TimeOfDay(hour: hour, minute: minute);
}

String timeOfDayToString(TimeOfDay timeOfDay) {
  // Format the TimeOfDay object into a string
  return '${timeOfDay.hour}:${timeOfDay.minute}';
}

Color checkColorState(String stateName) {
  if (stateName == 'Đã hủy') {
    return Colors.red;
  } else {
    return kPrimaryColor;
  }
}

// String
final class Message {
  static const String appName = 'Flutter Clean Architecture';
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';

  static const String ErrorConnection = 'Error Connection';
  static const String SuccessConnection = 'Success Connection';
  static const String NoConnection = 'No Connection';
}
