
import 'package:flutter/material.dart';
import 'package:hiwaygo/core/constants/app_colors.dart';
import 'package:hiwaygo/core/constants/app_strings.dart';
import 'package:hiwaygo/core/widgets/button_widget.dart';
import 'package:hiwaygo/core/widgets/date_picker_widget.dart';
import 'package:hiwaygo/core/widgets/loader_widget.dart';
import 'package:hiwaygo/core/widgets/search_dropdown_widget.dart';
import 'package:hiwaygo/core/widgets/text_field_common_widget.dart';
import 'package:hiwaygo/core/widgets/time_picker_widget.dart';
import 'package:hiwaygo/routes.dart';
import 'data/booking_service.dart';
import 'data/bus_route_model.dart';

class PageAddBookingDetails extends StatefulWidget{
  static const String routeName = '/page_add_booking_details';
  PageAddBookingDetails({super.key});

  @override
  State<PageAddBookingDetails> createState() => _PageAddBookingDetails();
}

class _PageAddBookingDetails extends State<PageAddBookingDetails> {
  late TextEditingController fromController, toController, dateController, timeController, seatCountController, busRouteController, pickupLocationController;
  late GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<String> busRoutes = [];
  List<BusRouteModel> _routeModels = [];
  String? _selectedRouteId;

  bool _isLoading = true;
  String _pageContent = AppStrings.loadingPleaseWait;

  Future<void> _loadData() async {
    try {
      List<BusRouteModel> routes = await BookingService().getBusRoutes();
      if (mounted) {
        setState(() {
          _routeModels = routes;
          // Map the models to display strings for the dropdown
          busRoutes = routes.map((e) => e.displayText).toList();
        });
      }
    } catch (e) {
      print("Error loading routes: $e");
      // Handle error (show snackbar, etc.)
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
    super.initState();
    fromController = TextEditingController();
    toController =  TextEditingController();
    dateController = TextEditingController();
    timeController = TextEditingController();
    seatCountController = TextEditingController();
    busRouteController = TextEditingController();
    pickupLocationController = TextEditingController();

    // Listener to update the selected ID when the dropdown text changes
    busRouteController.addListener(() {
      final selectedRoute = _routeModels.where((element) => element.displayText == busRouteController.text).firstOrNull;
      if (selectedRoute != null) {
        if (mounted) {
          setState(() {
            _selectedRouteId = selectedRoute.id;
          });
        }
      }
    });

    _loadData();
  }

  @override
  void dispose() {
    fromController.dispose();
    toController.dispose();
    dateController.dispose();
    timeController.dispose();
    seatCountController.dispose();
    busRouteController.dispose();
    pickupLocationController.dispose();
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
    double textFieldSpacing = 0.02;
    double buttonFieldSpacing = 0.03;
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      width: size.width * 0.9,
      height: size.height * 0.65,
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
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Form(
          key: _formKey,
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SearchDropdownWidget(size: size, hintText: "Bus Route", textIcon: Icons.alt_route, itemsList: busRoutes, onChangedController: busRouteController),
            SizedBox(height: size.height * textFieldSpacing),
            Visibility(
              visible: false,
              child: Column(children: [
                TextFieldCommonWidget(size: size, textEditingController: fromController, formKey: _formKey, textInputType: TextInputType.text, textIcon: Icons.location_city, hintText: AppStrings.from),
                SizedBox(height: size.height * textFieldSpacing),
                TextFieldCommonWidget(size: size, textEditingController: toController, formKey: _formKey, textInputType: TextInputType.text, textIcon: Icons.location_city, hintText: AppStrings.to),
                SizedBox(height: size.height * textFieldSpacing),
              ]),
            ),
            TextFieldCommonWidget(size: size, textEditingController: pickupLocationController, formKey: _formKey, textInputType: TextInputType.text, textIcon: Icons.pin_drop, hintText: "Pickup Location"),
            SizedBox(height: size.height * textFieldSpacing),
            DatePickerWidget(size: size, textEditingController: dateController, hintText: AppStrings.date, formKey: _formKey, textIcon: Icons.date_range,),
            SizedBox(height: size.height * textFieldSpacing),
            TimePickerWidget(size: size, textEditingController: timeController, hintText: AppStrings.time, formKey: _formKey, textIcon: Icons.access_time_rounded,),
            SizedBox(height: size.height * textFieldSpacing),
            TextFieldCommonWidget(size: size, textEditingController: seatCountController, formKey: _formKey, textInputType: TextInputType.number, textIcon: Icons.event_seat, hintText: AppStrings.seatCount),
            SizedBox(height: size.height * buttonFieldSpacing),
            ButtonWidget(
              size: size,
              buttonText: AppStrings.addNewBooking,
              onTap: () async {
                if (_formKey.currentState!.validate()) {
                  if (_selectedRouteId == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please select a bus route")),
                    );
                    return;
                  }

                  setState(() => _isLoading = true);

                  // Assuming dateController.text is in a parseable format (e.g., yyyy-MM-dd)
                  // If not, use DateTime.now() or implement specific parsing.
                  DateTime bookingDate = DateTime.tryParse(dateController.text) ?? DateTime.now();

                  bool success = await BookingService().createBooking(
                    busRouteId: _selectedRouteId!,
                    pickupLocation: pickupLocationController.text,
                    noOfSeats: int.tryParse(seatCountController.text) ?? 1,
                    bookingDate: bookingDate,
                  );

                  if (!mounted) return;
                  setState(() => _isLoading = false);

                  if (success) {
                    Navigator.popAndPushNamed(context, Routes.homePage);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Booking failed. Please try again.")),
                    );
                  }
                }
              },
            ),
          ],
        ),
        ),
      ),
    );
  }

}