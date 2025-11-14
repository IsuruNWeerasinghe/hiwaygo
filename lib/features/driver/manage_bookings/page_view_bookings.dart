
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
  List<BookingData> _filteredBookings = [];

  // Filter State Variables
  DateTime? _selectedDate;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;

  final GlobalKey<State> _datePickerKey = GlobalKey();
  final GlobalKey<State> _startTimePickerKey = GlobalKey();
  final GlobalKey<State> _endTimePickerKey = GlobalKey();

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

  void _applyFilters() {
    List<BookingData> results = _allBookings;

    // 3A. Filter by Date
    if (_selectedDate != null) {
      results = results.where((booking) {
        DateTime? bookingDateTime = _extractDateTime(booking.detail2DateTime);
        if (bookingDateTime == null) return false;

        // Compare only the year, month, and day
        return bookingDateTime.year == _selectedDate!.year &&
            bookingDateTime.month == _selectedDate!.month &&
            bookingDateTime.day == _selectedDate!.day;
      }).toList();
    }

    // 3B. Filter by Time Range
    if (_startTime != null && _endTime != null) {
      results = results.where((booking) {
        DateTime? bookingDateTime = _extractDateTime(booking.detail2DateTime);
        if (bookingDateTime == null) return false;

        TimeOfDay bookingTime = TimeOfDay.fromDateTime(bookingDateTime);

        // Convert TimeOfDay to minutes since midnight for easy comparison
        int startMinutes = _startTime!.hour * 60 + _startTime!.minute;
        int endMinutes = _endTime!.hour * 60 + _endTime!.minute;
        int bookingMinutes = bookingTime.hour * 60 + bookingTime.minute;

        // Handle case where time range wraps around midnight (e.g., 10 PM to 4 AM)
        if (startMinutes > endMinutes) {
          // Check if time is after start OR before end
          return bookingMinutes >= startMinutes || bookingMinutes <= endMinutes;
        } else {
          // Check if time is simply between start and end
          return bookingMinutes >= startMinutes && bookingMinutes <= endMinutes;
        }
      }).toList();
    }

    // Update the UI list
    setState(() {
      _filteredBookings = results;
    });
  }

  DateTime? _extractDateTime(String detail2DateTime) {
    try {
      // Assuming format: 'Date: YYYY-MM-DD HH:MM AM/PM'
      // Find the date part (e.g., '2023-07-15 11:50 PM')
      String dateString = detail2DateTime.split(':').sublist(1).join(':').trim();

      // Attempt to parse the complex format: '2025-11-15 11:50 PM'
      // We must manually format the AM/PM string for DateTime.parse
      if (dateString.toUpperCase().contains('PM')) {
        dateString = dateString.replaceAll('PM', '').trim();
        List<String> parts = dateString.split(' ');
        if (parts.length == 2) {
          String timePart = parts[1];
          List<String> timeComponents = timePart.split(':');
          int hour = int.parse(timeComponents[0]);
          if (hour != 12) hour += 12;
          dateString = '${parts[0]} ${hour}:${timeComponents[1]}';
        }
      } else if (dateString.toUpperCase().contains('AM')) {
        dateString = dateString.replaceAll('AM', '').trim();
        List<String> parts = dateString.split(' ');
        if (parts.length == 2) {
          String timePart = parts[1];
          List<String> timeComponents = timePart.split(':');
          int hour = int.parse(timeComponents[0]);
          if (hour == 12) hour = 0; // Midnight 12 AM is hour 0
          dateString = '${parts[0]} ${hour}:${timeComponents[1]}';
        }
      }

      // Final simplified parsing attempt (may require date_format package for robustness)
      return DateTime.parse(dateString);

    } catch (e) {
      debugPrint('Error parsing date string: $e');
      return null;
    }
  }

  void _clearFilters() {
    setState(() {
      // Reset all filter state variables to null
      _selectedDate = null;
      _startTime = null;
      _endTime = null;

      // 💡 Reset the keys to force the pickers to rebuild and clear their display
      _datePickerKey.currentState?.setState(() {}); // Using setState() forces rebuild
      _startTimePickerKey.currentState?.setState(() {});
      _endTimePickerKey.currentState?.setState(() {});
    });

    // Re-run the filter application
    _applyFilters();
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Date Picker
                  Expanded(
                    child: FilterDatePickerWidget(
                      key: _datePickerKey,
                      size: size,
                      onDateSelected: (date) {
                        _selectedDate = date;
                        _applyFilters();
                      },
                      initialDate: _selectedDate,
                      label: "Select Date",
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Start Time Picker
                  Expanded(
                    child: FilterTimePickerWidget(
                      key: _startTimePickerKey,
                      size: size,
                      onTimeSelected: (time) {
                        _startTime = time;
                        _applyFilters();
                      },
                      initialTime: _startTime,
                      label: "Start Time",
                    ),
                  ),
                  const SizedBox(width: 8),
                  // End Time Picker
                  Expanded(
                    child: FilterTimePickerWidget(
                      key: _endTimePickerKey,
                      size: size,
                      onTimeSelected: (time) {
                        _endTime = time;
                        _applyFilters();
                      },
                      initialTime: _endTime,
                      label: "End Time",
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 8),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: _clearFilters,
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.colorTealBlue,
                    textStyle: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  child: const Text("Clear Filters"),
                ),
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
                if (_filteredBookings.isEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: Text(
                      'No bookings match the filter criteria.',
                      style: GoogleFonts.inter(fontSize: 16, color: Colors.grey.shade600),
                    ),
                  ),

                // Map list here
                ..._filteredBookings.map((booking) {
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