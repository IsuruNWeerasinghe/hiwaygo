import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hiwaygo/core/constants/app_colors.dart';
import 'package:hiwaygo/core/constants/app_strings.dart';

class DatePickerWidget extends StatefulWidget {
  final Size size;
  final TextEditingController textEditingController;
  final String hintText;
  final GlobalKey formKey;
  final IconData textIcon;

  const DatePickerWidget({
    super.key,
    required this.size,
    required this.textEditingController,
    required this.hintText,
    required this.formKey,
    required this.textIcon,
  });

  @override
  _DatePickerWidget createState() => _DatePickerWidget();
}

class _DatePickerWidget extends State<DatePickerWidget> {
  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.colorCyanPulse,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        widget.textEditingController.text =
        "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
          onTap: () => _selectDate(context),
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
            fillColor: widget.textEditingController.text.isNotEmpty
                ? Colors.transparent
                : const Color.fromRGBO(248, 247, 251, 1),
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
              borderSide: BorderSide(
                color: widget.textEditingController.text.isEmpty
                    ? Colors.transparent
                    : AppColors.colorCyanPulse,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
              borderSide: const BorderSide(
                color: AppColors.colorCyanPulse,
              ),
            ),
            prefixIcon: Icon(
              widget.textIcon,
              color: widget.textEditingController.text.isEmpty
                  ? const Color(0xFF151624).withOpacity(0.5)
                  : AppColors.colorCyanPulse,
              size: 16,
            ),
            suffix: Container(
              alignment: Alignment.center,
              width: 24.0,
              height: 24.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100.0),
                color: AppColors.colorCyanPulse,
              ),
              child: widget.textEditingController.text.isEmpty
                  ? const Center()
                  : const Icon(
                Icons.check,
                color: Colors.white,
                size: 13,
              ),
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
