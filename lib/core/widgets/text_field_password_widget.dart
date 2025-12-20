import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hiwaygo/core/constants/app_colors.dart';
import 'package:hiwaygo/core/constants/app_strings.dart';

class CommonPasswordField extends StatelessWidget{
  final Size size;
  final TextEditingController textEditingController;
  final String inputValueType;
  final GlobalKey formKey;

  const CommonPasswordField({
    super.key,
    required this.size,
    required this.textEditingController,
    required this.inputValueType,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height / 12,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppColors.colorBlack.withOpacity(0.1), // very light shadow
              blurRadius: 6, // softness
              offset: const Offset(0, 3), // position (downward)
            ),
          ],
          borderRadius: BorderRadius.circular(40),
        ),
        child: TextFormField(
          controller: textEditingController,
          style: GoogleFonts.inter(
            fontSize: 18.0,
            color: const Color(0xFF151624),
          ),
          maxLines: 1,
          keyboardType: TextInputType.visiblePassword,
          obscureText: true,
          cursorColor: const Color(0xFF151624),
          decoration: InputDecoration(
            hintText: '$inputValueType',
            hintStyle: GoogleFonts.inter(
              fontSize: 16.0,
              color: const Color(0xFF151624).withOpacity(0.5),
            ),
            fillColor: textEditingController.text.isNotEmpty
                ? Colors.transparent
                : const Color.fromRGBO(248, 247, 251, 1),
            filled: true,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40),
                borderSide: BorderSide(
                  color: textEditingController.text.isEmpty
                      ? Colors.transparent
                      : AppColors.colorCyanPulse,
                )),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40),
                borderSide: BorderSide(
                  color: AppColors.colorCyanPulse,
                )),
            prefixIcon: Icon(
              Icons.lock_outline_rounded,
              color: textEditingController.text.isEmpty
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
              child: textEditingController.text.isEmpty
                  ? const Center()
                  : const Icon(
                Icons.check,
                color: Colors.white,
                size: 13,
              ),
            ),
          ),
          validator: (value){
            if (value == null || value.isEmpty) {
              return AppStrings.passwordCannotEmpty;
            }
            if (value.length < 6) {
              return AppStrings.passwordCannotBeShort;
            }
            return null;
          },
        ),
      ),
    );
  }
}
