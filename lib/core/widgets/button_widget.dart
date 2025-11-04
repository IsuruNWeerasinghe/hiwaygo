import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hiwaygo/core/constants/app_colors.dart';

class ButtonWidget extends StatefulWidget {
  final Size size;
  final String buttonText;
  final VoidCallback onTap;

  const ButtonWidget({
    super.key,
    required this.size,
    required this.buttonText, required this.onTap
  });

  @override
  _ButtonWidget createState() {
    return _ButtonWidget();
  }
}

class _ButtonWidget extends State<ButtonWidget> {
  bool _isPressed = false;
  @override
  Widget build(BuildContext context) {
    final Color buttonColor = _isPressed
        ? AppColors.colorTealBlue.withOpacity(0.4) // Darker/Custom color when pressed
        : AppColors.colorTealBlue;

    return Material(
      color: AppColors.colorTealBlue,
      elevation: 6.0,
      type: MaterialType.transparency,
      child: InkWell(
        onTap: widget.onTap,
        onTapDown: (_) {
          setState(() {
            _isPressed = true;
          });
        },
        onTapUp: (_) {
          // Add a slight delay to ensure the color change is visible before executing onTap
          Future.delayed(const Duration(milliseconds: 150), () {
            setState(() {
              _isPressed = false;
            });
            widget.onTap(); // Execute the original onTap callback
          });
        },
        onTapCancel: () {
          setState(() {
            _isPressed = false;
          });
        },
        borderRadius: BorderRadius.circular(15.0),
        splashColor: Colors.blue.withOpacity(0.3),
        highlightColor: Colors.blue.withOpacity(0.1),
        child: Container(
          alignment: Alignment.center,
          height: widget.size.height / 13,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: buttonColor,
            boxShadow: [
              BoxShadow(
                color: AppColors.colorBlack.withOpacity(0.3), // very light shadow
                blurRadius: 6, // softness
                offset: const Offset(0, 3), // position (downward)
              ),
            ],
          ),
          child: Text(
            widget.buttonText,
            style: GoogleFonts.inter(
              fontSize: 16.0,
              color: Colors.white,
              fontWeight: FontWeight.w600,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
