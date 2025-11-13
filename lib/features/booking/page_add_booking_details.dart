
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

class PageAddBookingDetails extends StatefulWidget{
  static const String routeName = '/page_add_booking_details';
  PageAddBookingDetails({super.key});

  @override
  State<PageAddBookingDetails> createState() => _PageAddBookingDetails();
}

class _PageAddBookingDetails extends State<PageAddBookingDetails> {
  late TextEditingController fromController, toController, dateController, timeController, seatCountController;
  late GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<String> itemsList = ['Brazil','Argentina','USA','Canada','Germany','France','Japan','Australia','India','China'];

  bool _isLoading = true;
  String _pageContent = AppStrings.loadingPleaseWait;

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
  void initState() {
    _loadData();
    fromController = TextEditingController();
    toController =  TextEditingController();
    dateController = TextEditingController();
    timeController = TextEditingController();
    seatCountController = TextEditingController();
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    fromController.dispose();
    toController.dispose();
    dateController.dispose();
    timeController.dispose();
    seatCountController.dispose();
    _formKey.currentState?.dispose();
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SearchDropdownWidget(size: size, hintText: AppStrings.from, textIcon: Icons.location_city, itemsList: itemsList, onChangedController: fromController),
            SizedBox(height: size.height * textFieldSpacing),
            SearchDropdownWidget(size: size, hintText: AppStrings.to, textIcon: Icons.location_city, itemsList: itemsList, onChangedController: toController),
            SizedBox(height: size.height * textFieldSpacing),
            DatePickerWidget(size: size, textEditingController: dateController, hintText: AppStrings.date, formKey: _formKey, textIcon: Icons.date_range,),
            SizedBox(height: size.height * textFieldSpacing),
            TimePickerWidget(size: size, textEditingController: timeController, hintText: AppStrings.time, formKey: _formKey, textIcon: Icons.access_time_rounded,),
            SizedBox(height: size.height * textFieldSpacing),
            TextFieldCommonWidget(size: size, textEditingController: seatCountController, inputValueType: AppStrings.seatCount, formKey: _formKey),
            SizedBox(height: size.height * buttonFieldSpacing),
            ButtonWidget(
              size: size,
              buttonText: AppStrings.addNewBooking,
              onTap: (){
              },
            ),
          ],
        ),
      ),
    );
  }

}