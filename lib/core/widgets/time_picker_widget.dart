import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hiwaygo/core/constants/app_colors.dart';
import 'package:hiwaygo/core/constants/app_strings.dart';

class TimePickerWidget extends StatefulWidget {
  final Size size;
  final TextEditingController textEditingController;
  final String hintText;
  final GlobalKey formKey;
  final IconData textIcon;

  const TimePickerWidget({
    super.key,
    required this.size,
    required this.textEditingController,
    required this.hintText,
    required this.formKey,
    required this.textIcon,
  });

  @override
  _TimePickerWidgetState createState() => _TimePickerWidgetState();
}

class _TimePickerWidgetState extends State<TimePickerWidget> {
  TimeOfDay? selectedTime;

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.input,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.colorCyanPulse, // header background color
              onPrimary: Colors.white, // header text color
              onSurface: Colors.black, // body text color
            ),
            timePickerTheme: TimePickerThemeData(
              dialHandColor: AppColors.colorCyanPulse,
              dialBackgroundColor: Colors.grey[200],
              hourMinuteTextColor: Colors.black,
              hourMinuteColor: Colors.grey[300],
              dayPeriodTextColor: Colors.black,
              dayPeriodColor: Colors.grey[300],
              dayPeriodBorderSide: const BorderSide(color: Colors.transparent),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
        // Format TimeOfDay to HH:mm string
        final String hour = picked.hour.toString().padLeft(2, '0');
        final String minute = picked.minute.toString().padLeft(2, '0');
        widget.textEditingController.text = "$hour:$minute";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool hasText = widget.textEditingController.text.isNotEmpty;

    return SizedBox(
      height: widget.size.height / 13,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppColors.colorBlack.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
          borderRadius: BorderRadius.circular(40),
        ),
        child: TextFormField(
          controller: widget.textEditingController,
          readOnly: true,
          onTap: () => _selectTime(context),
          style: GoogleFonts.inter(
            fontSize: 18.0,
            color: const Color(0xFF151624),
          ),
          cursorColor: const Color(0xFF151624),
          decoration: InputDecoration(
            hintText: AppStrings.enterYour + widget.hintText,
            hintStyle: GoogleFonts.inter(
              fontSize: 16.0,
              color: const Color(0xFF151624).withOpacity(0.5),
            ),
            fillColor: hasText
                ? Colors.transparent
                : const Color.fromRGBO(248, 247, 251, 1),
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
              borderSide: BorderSide(
                color: !hasText ? Colors.transparent : AppColors.colorCyanPulse,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
              borderSide: const BorderSide(color: AppColors.colorCyanPulse),
            ),
            prefixIcon: Icon(
              widget.textIcon,
              color: !hasText
                  ? const Color(0xFF151624).withOpacity(0.5)
                  : AppColors.colorCyanPulse,
              size: 16,
            ),
            suffix: Container(
              margin: const EdgeInsets.only(right: 3.0),
              // Added margin for padding
              alignment: Alignment.center,
              width: 24.0,
              height: 24.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100.0),
                // Show the circle only if there is text
                color: hasText ? AppColors.colorCyanPulse : Colors.transparent,
              ),
              child: !hasText
                  ? const Center()
                  : const Icon(Icons.check, color: Colors.white, size: 13),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return widget.hintText + AppStrings.cannotEmpty;
            }
            return null;
          },
        ),
      ),
    );
  }
}
