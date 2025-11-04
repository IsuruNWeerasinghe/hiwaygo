import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hiwaygo/core/constants/app_colors.dart';
import 'package:hiwaygo/core/constants/app_strings.dart';
import 'package:hiwaygo/core/widgets/app_name_and_logo_widget.dart';
import 'package:hiwaygo/core/widgets/main_menu_item_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';

class PageHome extends StatefulWidget{
  static const String routeName = '/page_home';
  const PageHome({super.key});

  @override
  State<PageHome> createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  int _currentIndex = 0;

  final _pages = [
  const Center(child: Text('Home')),
  const Center(child: Text('Bookings')),
  const Center(child: Text('Tracking')),
  const Center(child: Text('Profile')),
  ];


  // Function to show the exit confirmation dialog
  Future<bool> _showExitConfirmation(BuildContext context) async {
    return (await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Exit Application?'),
        content: const Text('Do you want to close the app?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false), // Stay
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true), // Close
            child: const Text('Yes'),
          ),
        ],
      ),
    )) ?? false; // Return false if the dialog is dismissed
  }

  final List<String> imageList = [
    'assets/slider/home_page_slider_1.jpg',
    'assets/slider/home_page_slider_2.jpg',
    'assets/slider/home_page_slider_3.jpg',
    'assets/slider/home_page_slider_4.jpg',
    'assets/slider/home_page_slider_5.jpg',
  ];


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return PopScope(
        canPop: false,
        onPopInvokedWithResult: (bool didPop, dynamic result) async {
          if (didPop) {
            return;
          }
          final bool shouldClose = await _showExitConfirmation(context);
          if (shouldClose) {
            if (Navigator.canPop(context)) {
              Navigator.pop(context, true);
            } else {

            }
          }
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: AppColors.colorBackground,
          appBar: AppBar(
            backgroundColor: AppColors.colorBackground,
            elevation: 0,
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SvgPicture.asset(
                  'assets/app_logo.svg',
                  height: size.height/15,
                  width: size.width/15,
                ),
                Text(
                  AppStrings.appNameHi,
                  style: TextStyle(color: AppColors.colorBlack),
                ),
                Text(" "),
                Text(
                  AppStrings.appNameWay,
                  style: TextStyle(color: AppColors.colorBlack),
                ),
                Text(" "),
                Text(
                  AppStrings.appNameGo,
                  style: TextStyle(color: AppColors.colorBlack),
                )
              ],
            )
          ),
            bottomNavigationBar: NavigationBar(
              backgroundColor: AppColors.colorBackground,
              surfaceTintColor:AppColors.colorFacebookButton,
              indicatorColor: AppColors.colorFacebookButton, // TealBlue from your color set
              labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
              selectedIndex: _currentIndex,
              onDestinationSelected: (int index) {
                setState(() => _currentIndex = index);
              },
              destinations: const [
                NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
                NavigationDestination(icon: Icon(Icons.history), selectedIcon: Icon(Icons.confirmation_number), label: 'Bookings'),
                NavigationDestination(icon: Icon(Icons.directions_bus_outlined), selectedIcon: Icon(Icons.directions_bus), label: 'Tracking'),
                NavigationDestination(icon: Icon(Icons.manage_accounts), selectedIcon: Icon(Icons.directions_bus), label: 'Tracking'),
                NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Profile'),
              ],
            ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: size.width,
                  height: size.height/3,
                  child: CarouselSlider(
                    items: imageList.map((imagePath) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                                image: AssetImage(imagePath),
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                    options: CarouselOptions(
                      autoPlay: true,
                      enlargeCenterPage: true,
                      viewportFraction: 0.9,
                      aspectRatio: 2.0,
                      initialPage: 2,
                    ),
                  ),
                ),
                SizedBox(
                  width: size.width,
                  height: size.height/3,
                  child: GridView.count(
                      primary: false,
                      padding: const EdgeInsets.all(40),
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      crossAxisCount: 3,
                      children: <Widget>[
                        MainMenuItemWidget(
                            size: size,
                            menuTitle: AppStrings.busBooking),
                        MainMenuItemWidget(
                            size: size,
                            menuTitle: AppStrings.liveBusTracing),
                        MainMenuItemWidget(
                            size: size,
                            menuTitle: AppStrings.busSchedule),
                        MainMenuItemWidget(
                            size: size,
                            menuTitle: AppStrings.activityHistory),
                        MainMenuItemWidget(
                            size: size,
                            menuTitle: AppStrings.contactUs),
                        MainMenuItemWidget(
                            size: size,
                            menuTitle: AppStrings.aboutUs),
                      ]
                  ),
                ),
                              ],
            ),
          ),
        )
    );
  }

}