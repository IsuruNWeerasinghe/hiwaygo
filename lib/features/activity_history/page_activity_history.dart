
import 'package:flutter/material.dart';
import 'package:hiwaygo/core/constants/app_colors.dart';
import 'package:hiwaygo/core/constants/app_strings.dart';
import 'package:hiwaygo/core/widgets/CustomAlertDialog.dart';
import 'package:hiwaygo/core/widgets/add_reviews_widget.dart';
import 'package:hiwaygo/core/widgets/button_widget.dart';
import 'package:hiwaygo/core/widgets/date_picker_widget.dart';
import 'package:hiwaygo/core/widgets/search_dropdown_widget.dart';
import 'package:hiwaygo/core/widgets/text_field_common_widget.dart';
import 'package:hiwaygo/core/widgets/time_picker_widget.dart';
import 'package:hiwaygo/routes.dart';

class PageActivityHistory extends StatefulWidget{
  static const String routeName = '/page_activity_history';
  PageActivityHistory({super.key});

  @override
  State<PageActivityHistory> createState() => _PageActivityHistory();
}

class _PageActivityHistory extends State<PageActivityHistory> {

  @override
  void initState() {
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
            title: Text(AppStrings.activityHistory),
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

          body: Center(
              child: buildBody(size)
          ),
        )
    );
  }

  Widget buildBody(Size size) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          for(int i = 0; i < 5; i++)...[
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
                          "Gampaha to Nugegoda",
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
                                  return AddReviewDialog(
                                    onSubmit: (overall, driver, conductor, bus, comment) {
                                    },
                                  );
                                }
                            );
                          },
                          icon: Icon(Icons.reviews),
                          color: AppColors.colorFacebookButton,
                        )
                      ],
                    ),
                    Text(
                      "Bus No: ND-1234",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Booking ID: 123456789",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Text(
                      "Date: 2025.11.11 - 12.25pm",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Text(
                      "Seats: 2",
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
    );
  }

}