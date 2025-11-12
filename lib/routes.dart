import 'package:hiwaygo/features/auth/page_forgot_password.dart';
import 'package:hiwaygo/features/auth/page_sign_in.dart';
import 'package:hiwaygo/features/auth/page_sign_up.dart';
import 'package:hiwaygo/features/booking/page_add_booking_details.dart';
import 'package:hiwaygo/features/booking/page_booking_details_list.dart';
import 'package:hiwaygo/features/page_home.dart';
import 'package:hiwaygo/features/tracking/page_bus_tracking_map.dart';
import 'package:hiwaygo/features/tracking/page_select_tracking_details.dart';

class Routes{
  static const String signInPage = PageSignIn.routeName;
  static const String signUpPage = PageSignUp.routeName;
  static const String forgotPasswordPage = PageForgotPassword.routeName;
  static const String selectBusTrackingDetailsPage = PageSelectBusTrackingDetails.routeName;
  static const String busTrackingMapPage = PageBusTrackingMap.routeName;
  static const String homePage = PageHome.routeName;
  static const String addBookingDetailsPage = PageAddBookingDetails.routeName;
  static const String bookingDetailsListPage = PageBookingDetailsList.routeName;
}