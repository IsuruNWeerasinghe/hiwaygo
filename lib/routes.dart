import 'package:hiwaygo/features/activity_history/page_activity_history.dart';
import 'package:hiwaygo/features/auth/page_forgot_password.dart';
import 'package:hiwaygo/features/auth/page_sign_in.dart';
import 'package:hiwaygo/features/auth/page_sign_up.dart';
import 'package:hiwaygo/features/driver/manage_bookings/page_view_bookings.dart';
import 'package:hiwaygo/features/page_home.dart';
import 'package:hiwaygo/features/passenger/booking/page_add_booking_details.dart';
import 'package:hiwaygo/features/passenger/booking/page_booking_details_list.dart';
import 'package:hiwaygo/features/passenger/tracking/page_bus_tracking_map.dart';
import 'package:hiwaygo/features/passenger/tracking/page_select_tracking_details.dart';
import 'package:hiwaygo/features/time_keeper/page_add_edit_bus_schedule.dart';
import 'package:hiwaygo/features/time_keeper/page_view_bus_schedule.dart';

class Routes{
  static const String signInPage = PageSignIn.routeName;
  static const String signUpPage = PageSignUp.routeName;
  static const String forgotPasswordPage = PageForgotPassword.routeName;
  static const String selectBusTrackingDetailsPage = PageSelectBusTrackingDetails.routeName;
  static const String busTrackingMapPage = PageBusTrackingMap.routeName;
  static const String homePage = PageHome.routeName;
  static const String addBookingDetailsPage = PageAddBookingDetails.routeName;
  static const String bookingDetailsListPage = PageBookingDetailsList.routeName;
  static const String activityHistoryPage = PageActivityHistory.routeName;
  static const String viewBookingsPage = PageViewBookings.routeName;
  static const String viewAddEditBusSchedulePage = PageAddEditBusSchedule.routeName;
  static const String viewBusSchedulePage = PageViewBusSchedule.routeName;
}