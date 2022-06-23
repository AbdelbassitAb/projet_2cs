import 'package:flutter/material.dart';

const primaryColor = Color(0xFF00ACEE);
const secondaryColor = Color(0xFFFF9900);
const appGreen = Color(0xFF2EAD5D);
const appBlue = Color(0xFF2A94F4);
const appOrange = Color(0xFFF2A446);
const appRed = Color(0xFFEA625C);
const appGray = Color(0xFFCCCCCC);
const appDeepGray = Color(0xFFEFF1F5);
const cardGray = Color(0xFFFBFBFB);

const double verticalPadding = 20.0;
const double horizontalPadding = 30.0;



String? validator(String? val){
  if(val== '' || val == null){
    return "please enter a value";
  }
  return null;
}

extension extString on String {
  bool get isValidEmail {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegExp.hasMatch(this);
  }

  bool get isValidName{
    final nameRegExp = new RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$");
    return nameRegExp.hasMatch(this);
  }

  bool get isValidPassword{
    final passwordRegExp =
    RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\><*~]).{8,}/pre>');
    return passwordRegExp.hasMatch(this);
  }

  bool get isNotNull{
    return this!=null;
  }

  bool get isValidPhone{
    final phoneRegExp = RegExp(r"^\+?0[0-9]{10}$");
    return phoneRegExp.hasMatch(this);
  }

}