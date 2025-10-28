import 'dart:core';
import 'package:hiwaygo/core/constants/app_strings.dart';

class CustomValidationUtil{
  static bool validateNic(String nic) {
    if(AppStrings.newNicRegex.hasMatch(nic)){
      return true;
    } else if(AppStrings.oldNicRegex.hasMatch(nic)){
      return true;
    } else{
      return false;
    }
  }

  static bool validatePhoneNo(String phoneNo) {
    if(AppStrings.phoneRegex.hasMatch(phoneNo)){
      return true;
    } else{
      return false;
    }
  }

  static bool validateEmail(String email) {
    if(AppStrings.emailRegex.hasMatch(email)){
      return true;
    } else{
      return false;
    }
  }

}