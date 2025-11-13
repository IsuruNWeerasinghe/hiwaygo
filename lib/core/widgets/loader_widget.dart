import 'package:flutter/material.dart';
import 'package:hiwaygo/core/constants/app_colors.dart';

class LoaderWidget extends StatelessWidget {
  const LoaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 75.0,
        height: 75.0,
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: AppColors.colorBackground,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.colorBlack.withOpacity(0.3),
              blurRadius: 5,
              offset: const Offset(1, 5),
            ),
          ],
        ),
        child: const CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.colorTealBlue),
          strokeWidth: 4.0,
        ),
      ),
    );
  }
}