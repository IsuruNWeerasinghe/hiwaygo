
import 'package:flutter/material.dart';
import 'package:hiwaygo/core/constants/app_colors.dart';
import 'package:hiwaygo/core/constants/app_strings.dart';
import 'package:hiwaygo/core/widgets/custom_alert_dialog.dart';
import 'package:hiwaygo/core/widgets/button_widget.dart';
import 'package:hiwaygo/core/widgets/date_picker_widget.dart';
import 'package:hiwaygo/core/widgets/loader_widget.dart';
import 'package:hiwaygo/core/widgets/search_dropdown_widget.dart';
import 'package:hiwaygo/core/widgets/text_field_common_widget.dart';
import 'package:hiwaygo/core/widgets/time_picker_widget.dart';
import 'package:hiwaygo/routes.dart';
import 'data/booking_service.dart';
import 'data/booking_model.dart';

class PageBookingDetailsList extends StatefulWidget{
  static const String routeName = '/page_booking_details_list';
  PageBookingDetailsList({super.key});

  @override
  State<PageBookingDetailsList> createState() => _PageBookingDetailsList();
}

class _PageBookingDetailsList extends State<PageBookingDetailsList> {
  bool _isLoading = true;
  String _pageContent = AppStrings.loadingPleaseWait;
  List<BookingModel> _bookingList = [];

  Future<void> _loadData() async {
    try {
      List<BookingModel> bookings = await BookingService().getBookings();
      if (mounted) {
        setState(() {
          _bookingList = bookings;
        });
      }
    } catch (e) {
      print("Error loading bookings: $e");
    }

    if (mounted) {
      setState(() {
        _pageContent = AppStrings.loadingCompleted;
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return PopScope(
        canPop: true,
        child: Scaffold(
          appBar: AppBar(
            title: Text(AppStrings.busBooking),
            backgroundColor: AppColors.colorBackground,
            leading: IconButton(
              icon: Icon(
                  Icons.arrow_back,
                color: AppColors.colorFacebookButton,
              ),
              onPressed: () {
                Navigator.popAndPushNamed(context, Routes.homePage);
              },
            ),
          ),

          body: _isLoading?
              const LoaderWidget():
          Center(
              child: buildBody(size)
          ),
        )
    );
  }

  Widget buildBody(Size size) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: size.height * 0.75,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                for(var booking in _bookingList)...[
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(
                        top: 5, bottom: 5, left: 15, right: 5),
                    width: size.width * 0.9,
                    height: size.height * 0.2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: AppColors.colorTealBlue.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: const Offset(0, 3)
                        ),
                      ],
                    ),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                booking.pickupLocation,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                onPressed: (){
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return CustomAlertDialog(
                                          messageTitle: AppStrings.deleteBooking,
                                          messageBody: AppStrings.deleteBookingConfirmation,
                                          confirmButtonText: AppStrings.deleteBookingActionYes,
                                          cancelButtonText: AppStrings.deleteBookingActionNo,
                                          onConfirm: () {
                                            Navigator.of(context).pop();
                                          },
                                          onCancel: () {
                                            Navigator.of(context).pop();
                                          },
                                        );
                                      }
                                  );
                                },
                                icon: Icon(Icons.delete),
                                color: AppColors.colorGoogleButton,
                              )
                            ],
                          ),
                          Text(
                            "Bus No: ${booking.busNo ?? 'Pending'}",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "Booking ID: ${booking.busId ?? 'Pending'}", // Shortened ID
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            "Date: ${booking.bookingDate.split('T')[0]}",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            "Seats: ${booking.noOfSeats}",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ]
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                ],
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ButtonWidget(
              size: size,
              buttonText: AppStrings.addNewBooking,
              onTap: (){
                Navigator.pushNamed(context, Routes.addBookingDetailsPage);
              }
          ),
        )
      ]
    );
  }

}