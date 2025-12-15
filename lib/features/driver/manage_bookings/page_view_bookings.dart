
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hiwaygo/core/constants/app_colors.dart';
import 'package:hiwaygo/core/constants/app_strings.dart';
import 'package:hiwaygo/core/widgets/booking_details_widget.dart';
import 'package:hiwaygo/core/widgets/custom_alert_dialog.dart';
import 'package:hiwaygo/core/widgets/add_reviews_widget.dart';
import 'package:hiwaygo/core/widgets/button_widget.dart';
import 'package:hiwaygo/core/widgets/date_picker_widget.dart';
import 'package:hiwaygo/core/widgets/filters_date_picker_widget.dart';
import 'package:hiwaygo/core/widgets/loader_widget.dart';
import 'package:hiwaygo/core/widgets/search_dropdown_widget.dart';
import 'package:hiwaygo/core/widgets/text_field_common_widget.dart';
import 'package:hiwaygo/core/widgets/filters_time_picker_widget.dart';
import 'package:hiwaygo/core/widgets/time_picker_widget.dart';
import 'package:hiwaygo/routes.dart';

class BookingData {
  final String title;
  final String subtitle;
  final String detail1;
  final String detail2DateTime; // Holds the string: 'Date: 2023-07-15 11.50PM'
  final String detail3Seats;
  final String phoneNo;
  final IconData iconPrimaryButton;
  final IconData iconSecondaryButton;

  BookingData({
    required this.title,
    required this.subtitle,
    required this.detail1,
    required this.detail2DateTime,
    required this.detail3Seats,
    required this.phoneNo,
    required this.iconPrimaryButton,
    required this.iconSecondaryButton,
  });
}

class PageViewBookings extends StatefulWidget{
  static const String routeName = '/page_view_bookings';
  PageViewBookings({super.key});

  @override
  State<PageViewBookings> createState() => _PageViewBookings();
}

class _PageViewBookings extends State<PageViewBookings> {
  bool _isLoading = true;
  String _pageContent = AppStrings.loadingPleaseWait;

  late List<BookingData> _allBookings;


  Future<void> _loadData() async {
    await Future.delayed(const Duration(seconds: 3));

    if (mounted) {
      setState(() {
        _pageContent = AppStrings.loadingCompleted;
        _isLoading = false;
      });
    }
  }

  @override
  initState() {
    super.initState();
    _allBookings = _generateDummyData();
    _loadData();
  }

  List<BookingData> _generateDummyData() {
    return [
      BookingData(
        title: 'Pickup: Miriswatta (Bus 1)',
        subtitle: 'Booking ID: 123456',
        detail1: 'Kamal Perera',
        detail2DateTime: 'Date: 2025-11-15 11:50 PM', // Today's date, 11:50 PM
        detail3Seats: 'Seats: 3',
        phoneNo: '0712345678',
        iconPrimaryButton: Icons.delete_forever,
        iconSecondaryButton: Icons.check_circle,
      ),
      BookingData(
        title: 'Pickup: Kadawatha (Bus 2)',
        subtitle: 'Booking ID: 123457',
        detail1: 'Nimal Silva',
        detail2DateTime: 'Date: 2025-11-14 07:30 AM', // Yesterday, 7:30 AM
        detail3Seats: 'Seats: 1',
        phoneNo: '0778899000',
        iconPrimaryButton: Icons.delete_forever,
        iconSecondaryButton: Icons.check_circle,
      ),
      BookingData(
        title: 'Pickup: Kottawa (Bus 3)',
        subtitle: 'Booking ID: 123458',
        detail1: 'Sunil Fernando',
        detail2DateTime: 'Date: 2025-11-15 09:00 AM', // Today, 9:00 AM
        detail3Seats: 'Seats: 4',
        phoneNo: '0701122334',
        iconPrimaryButton: Icons.delete_forever,
        iconSecondaryButton: Icons.check_circle,
      ),
      BookingData(
        title: 'Pickup: Kadawatha (Bus 1)',
        subtitle: 'Booking ID: 123457',
        detail1: 'Nimal Silva',
        detail2DateTime: 'Date: 2025-11-14 07:30 AM', // Yesterday, 7:30 AM
        detail3Seats: 'Seats: 1',
        phoneNo: '0778899000',
        iconPrimaryButton: Icons.delete_forever,
        iconSecondaryButton: Icons.check_circle,
      ),
      BookingData(
        title: 'Pickup: Kottawa (Bus 5)',
        subtitle: 'Booking ID: 123458',
        detail1: 'Sunil Fernando',
        detail2DateTime: 'Date: 2025-11-15 09:00 AM', // Today, 9:00 AM
        detail3Seats: 'Seats: 4',
        phoneNo: '0701122334',
        iconPrimaryButton: Icons.delete_forever,
        iconSecondaryButton: Icons.check_circle,
      ),
    ];
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
          // ... AppBar remains the same ...
          appBar: AppBar(
            title: Text(AppStrings.bookingDetails),
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
          // 💡 The body now returns buildBody directly, no Center needed
          body: _isLoading ? const LoaderWidget() : buildBody(size),
        )
    );
  }


  Widget buildBody(Size size) {
    // 💡 Main Column must take up the full available height of the Scaffold body.
    //    It is constrained by the Scaffold, so Expanded can work here.
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max, // Default is max, ensuring it fills the screen
      children: [
        // 1. Fixed Height Filter Inputs (Padding is fixed height and fine)
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextButton.icon(
                    onPressed: (){},
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.colorBlack,
                      backgroundColor: AppColors.colorFacebookButton,
                      iconColor: AppColors.colorBlack,
                      padding: EdgeInsets.symmetric(horizontal: size.width * 0.01)
                    ),
                    icon: Icon(Icons.date_range),
                    label: const Text(
                      "Fiter by Date",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: AppColors.colorBlack
                      ),),
                  ),
                  TextButton.icon(
                    onPressed: (){},
                    style: TextButton.styleFrom(
                        foregroundColor: AppColors.colorBlack,
                        backgroundColor: AppColors.colorFacebookButton,
                        iconColor: AppColors.colorBlack,
                        padding: EdgeInsets.symmetric(horizontal: size.width * 0.01)
                    ),
                    icon: Icon(Icons.access_time_rounded),
                    label: const Text(
                      "Fiter by Time",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: AppColors.colorBlack
                      ),),
                  ),

                  TextButton.icon(
                    onPressed: (){},
                    style: TextButton.styleFrom(
                        foregroundColor: AppColors.colorBlack,
                        backgroundColor: AppColors.colorFacebookButton,
                        iconColor: AppColors.colorBlack,
                        padding: EdgeInsets.symmetric(horizontal: size.width * 0.01)
                    ),
                    icon: Icon(Icons.clear),
                    label: const Text(
                      "Clear Filters",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: AppColors.colorBlack
                      ),),
                  ),

                ],
              ),
            ],
          ),
        ),

        // 2. 💡 Expanded View for Scrollable List Content
        //    This widget takes ALL remaining vertical space.
        Expanded(
          child: SingleChildScrollView( // 💡 This is fine here because the Expanded parent provides a fixed BOUNDED height.
            scrollDirection: Axis.vertical,
            // The content inside the SingleChildScrollView's Column is now constrained.
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min, // Essential: Column inside SCV must be min size
              children: [
                if (_allBookings.isEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: Text(
                      'No bookings match the filter criteria.',
                      style: GoogleFonts.inter(fontSize: 16, color: Colors.grey.shade600),
                    ),
                  ),

                // Map list here
                ..._allBookings.map((booking) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: size.height * 0.02),
                    child: BookingDetailsWidget(
                      size: size,
                      title: booking.title,
                      subtitle: booking.subtitle,
                      detail1: booking.detail1,
                      detail2: booking.detail2DateTime,
                      detail3: booking.detail3Seats,
                      phoneNo: 'Phone: ${booking.phoneNo}',
                      iconPrimaryButton: booking.iconPrimaryButton,
                      enableSecondaryButton: true,
                      iconSecondaryButton: booking.iconSecondaryButton,
                      onTapPrimary: () {},
                      onTapSecondary: () {},
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ],
    );
  }
}