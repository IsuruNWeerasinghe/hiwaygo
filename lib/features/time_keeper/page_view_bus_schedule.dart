
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PageViewBusSchedule extends StatefulWidget {
  static const String routeName = '/page_view_bus_schedule';
  const PageViewBusSchedule({super.key});

  @override
  State<PageViewBusSchedule> createState() => _PageViewBusScheduleState();
}

class _PageViewBusScheduleState extends State<PageViewBusSchedule> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page View Bus Schedule'),
      )
    );
  }

}