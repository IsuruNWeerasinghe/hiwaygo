import 'package:flutter/material.dart';
import 'package:hiwaygo/features/activity_history/page_activity_history.dart';
import 'package:hiwaygo/features/auth/page_forgot_password.dart';
import 'package:hiwaygo/features/auth/page_sign_in.dart';
import 'package:hiwaygo/features/auth/page_sign_up.dart';
import 'package:hiwaygo/features/booking/page_add_booking_details.dart';
import 'package:hiwaygo/features/booking/page_booking_details_list.dart';
import 'package:hiwaygo/features/driver/manage_bookings/page_view_bookings.dart';
import 'package:hiwaygo/features/notifications/notification_service_builder.dart';
import 'package:hiwaygo/features/page_home.dart';
import 'package:hiwaygo/features/tracking/page_bus_tracking_map.dart';
import 'package:hiwaygo/features/tracking/page_select_tracking_details.dart';
import 'package:hiwaygo/routes.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().initializeNotifications();

  runApp(GestureDetector(
    onTap: () {
      FocusManager.instance.primaryFocus?.unfocus();
    },
    child: SafeArea(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const PageSignIn(),
          Routes.homePage: (context) => PageHome(),
          Routes.signInPage: (context) => const PageSignIn(),
          Routes.signUpPage: (context) => const PageSignUp(),
          Routes.forgotPasswordPage: (context) => const PageForgotPassword(),
          Routes.busTrackingMapPage: (context) => const PageBusTrackingMap(),
          Routes.selectBusTrackingDetailsPage: (context) => PageSelectBusTrackingDetails(),
          Routes.addBookingDetailsPage: (context) => PageAddBookingDetails(),
          Routes.bookingDetailsListPage: (context) => PageBookingDetailsList(),
          Routes.activityHistoryPage: (context) => PageActivityHistory(),
          Routes.viewBookingsPage: (context) => PageViewBookings(),
        },
      ),
    ),
  ));
}
