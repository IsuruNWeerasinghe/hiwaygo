
import 'package:flutter/material.dart';
import 'package:hiwaygo/core/constants/app_colors.dart';
import 'package:hiwaygo/core/constants/app_strings.dart';
import 'package:hiwaygo/core/models/bus_route_model.dart';
import 'package:hiwaygo/core/widgets/button_widget.dart';
import 'package:hiwaygo/core/widgets/date_picker_widget.dart';
import 'package:hiwaygo/core/widgets/loader_widget.dart';
import 'package:hiwaygo/core/widgets/search_dropdown_widget.dart';
import 'package:hiwaygo/core/widgets/text_field_common_widget.dart';
import 'package:hiwaygo/core/widgets/time_picker_widget.dart';
import 'package:hiwaygo/routes.dart';

class PageAddEditBusSchedule extends StatefulWidget{
  static const String routeName = '/page_add_edit_bus_schedule';
  const PageAddEditBusSchedule({super.key});

  @override
  State<PageAddEditBusSchedule> createState() => _PageAddEditBusScheduleState();
}

class _PageAddEditBusScheduleState extends State<PageAddEditBusSchedule> {
  late TextEditingController routeController, fromController, toController, dateController, timeController, busNoController;
  DateTime? selectedDate;
  late GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isLoading = true;
  String _pageContent = AppStrings.loadingPleaseWait;
  List<BusRouteModel> routeList = [
    // Gampaha - Nugegoda
    BusRouteModel(
      busRouteNo: 'EX2-138/200',
      from: 'Gampaha',
      to: 'Nugegoda',
    ),

    // Kadawatha - Nugegoda
    BusRouteModel(
      busRouteNo: 'EX2-138/200',
      from: 'Kadawatha',
      to: 'Nugegoda',
    ),

    // Panadura - Nugegoda
    BusRouteModel(
      busRouteNo: '17',
      from: 'Panadura',
      to: 'Nugegoda',
    ),

    // Galle - Makumbura
    BusRouteModel(
      busRouteNo: 'EX001',
      from: 'Galle',
      to: 'Makumbura',
    ),

    // Matara - Makumbura
    BusRouteModel(
      busRouteNo: 'EX1-1',
      from: 'Matara',
      to: 'Makumbura',
    ),

    // Katharagama - Makumbura
    BusRouteModel(
      busRouteNo: 'EX1-12/32',
      from: 'Katharagama',
      to: 'Makumbura',
    ),
  ];

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
    routeController = TextEditingController();
    fromController = TextEditingController();
    toController = TextEditingController();
    dateController = TextEditingController();
    timeController = TextEditingController();
    busNoController = TextEditingController();

    routeController.addListener(_handleRouteControllerChange);
    if (dateController.text.isEmpty) {
      DateTime today = DateTime.now();
      selectedDate = today;
      dateController.text = "${today.toLocal()}".split(' ')[0];
    }

    super.initState();
  }

  @override
  void dispose() {
    routeController.removeListener(_handleRouteControllerChange);
    routeController.dispose();
    fromController.dispose();
    toController.dispose();
    dateController.dispose();
    timeController.dispose();
    busNoController.dispose();
    super.dispose();
  }

  void _handleRouteControllerChange() {
    if (routeController.text.isNotEmpty) {
      _updateFromToFields(routeController.text);
    } else {
      setState(() {
        fromController.text = '';
        toController.text = '';
      });
    }
  }

  void _updateFromToFields(String fullRouteString) {
    String selectedRouteNo = fullRouteString.split(' - ').first.trim();
    BusRouteModel? selectedRoute = routeList.firstWhere(
          (route) => route.busRouteNo == selectedRouteNo,
      orElse: () => BusRouteModel(busRouteNo: '', from: '', to: ''),
    );
    if (selectedRoute.busRouteNo.isNotEmpty) {
      setState(() {
        fromController.text = selectedRoute.from;
        toController.text = selectedRoute.to;
      });
    } else {
      setState(() {
        fromController.text = '';
        toController.text = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return PopScope(
        canPop: true,
        child: Scaffold(
          appBar: AppBar(
            title: Text(AppStrings.busScheduleDetailsAddEdit),
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
          const LoaderWidget()
              :Center(
              child: buildBody(size)
          ),
        )
    );
  }

  Widget buildBody(Size size) {
    double textFieldSpacing = 0.02;
    double buttonFieldSpacing = 0.03;

    List<String> routeListItems = [];
    List<String> busNoList = ["NA-1234", "NA-1235", "NA-1236", "NA-1237", "NA-1238", "NA-1239"];
    //routes
    for(int i=0; i<routeList.length; i++){
      routeListItems.add("${routeList[i].busRouteNo} - (${routeList[i].from} - ${routeList[i].to})");
    }

    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      width: size.width * 0.9,
      height: size.height * 0.75,
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
            SearchDropdownWidget(size: size, hintText: AppStrings.busRoute, textIcon: Icons.location_city, itemsList: routeListItems, onChangedController: routeController),
            SizedBox(height: size.height * textFieldSpacing),
            TextFieldCommonWidget(size: size, textEditingController: fromController, formKey: _formKey, textInputType: TextInputType.text, textIcon: Icons.bus_alert_rounded, hintText: AppStrings.from),
            SizedBox(height: size.height * textFieldSpacing),
            TextFieldCommonWidget(size: size, textEditingController: toController, formKey: _formKey, textInputType: TextInputType.text, textIcon: Icons.bus_alert_rounded, hintText: AppStrings.to),
            SizedBox(height: size.height * textFieldSpacing),
            DatePickerWidget(size: size, textEditingController: dateController, hintText: AppStrings.date, formKey: _formKey, textIcon: Icons.date_range,),
            SizedBox(height: size.height * textFieldSpacing),
            TimePickerWidget(size: size, textEditingController: timeController, hintText: AppStrings.time, formKey: _formKey, textIcon: Icons.access_time_rounded,),
            SizedBox(height: size.height * textFieldSpacing),
            SearchDropdownWidget(size: size, hintText: AppStrings.busNumber, textIcon: Icons.location_city, itemsList: busNoList, onChangedController: busNoController),
            SizedBox(height: size.height * buttonFieldSpacing),
            ButtonWidget(
              size: size,
              buttonText: AppStrings.save,
              onTap: (){
              },
            ),
          ],
        ),
      ),
    );
  }

}