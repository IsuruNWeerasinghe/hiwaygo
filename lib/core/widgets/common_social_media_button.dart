import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hiwaygo/core/constants/app_colors.dart';
import 'package:flutter_svg/svg.dart';

class CommonSocialMediaButton extends StatelessWidget{
  final Size size;
  final String buttonText;
  final String svgString;
  final Color buttonColor;
  final VoidCallback onTap;
  const CommonSocialMediaButton({
    super.key,
    required this.size,
    required this.buttonText,
    required this.svgString,
    required this.buttonColor,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: size.width / 2.8,
        height: size.height / 13,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            width: 1.0,
            color: buttonColor,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              width: 24.0,
              height: 24.0,
              color: AppColors.colorBackground,
              child: SvgPicture.string(
                // Group 59
                svgString,
                width: 22.92,
                height: 22.92,
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Text(
              buttonText,
              style: GoogleFonts.inter(
                fontSize: 14.0,
                color: buttonColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
