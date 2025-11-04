
import 'package:flutter/material.dart';
import 'package:hiwaygo/core/constants/app_colors.dart';

class MainMenuItemWidget extends StatelessWidget{
  final Size size;
  final String menuTitle;
  const MainMenuItemWidget({
    super.key,
    required this.size,
    required this.menuTitle
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      width: size.width * 0.4,
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
      child: Text(menuTitle),
    );
  }

}