import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hiwaygo/core/constants/app_colors.dart';

class CommonButtonLarge extends StatelessWidget{
  final Size size;
  final String buttonText;
  final VoidCallback onTap;
  const CommonButtonLarge({
    super.key,
    required this.size,
    required this.buttonText, required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: size.height / 13,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: AppColors.colorTealBlue,
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF4C2E84).withOpacity(0.2),
              offset: const Offset(0, 15.0),
              blurRadius: 60.0,
            ),
          ],
        ),
        child: Text(
          buttonText,
          style: GoogleFonts.inter(
            fontSize: 16.0,
            color: Colors.white,
            fontWeight: FontWeight.w600,
            height: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
