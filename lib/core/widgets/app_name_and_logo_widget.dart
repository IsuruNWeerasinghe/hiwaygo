import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hiwaygo/core/constants/app_colors.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hiwaygo/core/constants/app_strings.dart';

class AppNameAndLogoWidget extends StatelessWidget{
  final Size size;
  final String pageName;

  const AppNameAndLogoWidget({
    super.key,
    required this.size,
    required this.pageName
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        appLogo(size.height / 5, size.height / 5),
        appName(24),
        Text(
          pageName,
          style: TextStyle(
            color: AppColors.colorBlack,
            fontWeight: FontWeight.w600,
            fontSize: 16
          ),
        ),
      ],
    );
  }

  Widget appLogo(double height_, double width_) {
    return SvgPicture.asset(
      'assets/app_logo.svg',
      height: height_,
      width: width_,
    );
  }

  Widget appName(double fontSize) {
    return Text.rich(
      TextSpan(
        style: GoogleFonts.inter(
          fontSize: fontSize,
          letterSpacing: 2.000000061035156,
        ),
        children: const [
          TextSpan(
            text: AppStrings.appNameHi,
            style: TextStyle(
              color: AppColors.colorTealBlue,
              fontWeight: FontWeight.w800,
            ),
          ),
          TextSpan(
            text: AppStrings.appNameWay,
            style: TextStyle(
              color: AppColors.colorCyanPulse,
              fontWeight: FontWeight.w800,
            ),
          ),
          TextSpan(
            text: AppStrings.appNameGo,
            style: TextStyle(
              color: AppColors.colorCoralBlush,
              fontWeight: FontWeight.w800,
            ),
          )
        ],
      ),
    );
  }

}