import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hiwaygo/core/constants/app_colors.dart';
import 'package:hiwaygo/core/constants/app_strings.dart';
import 'package:hiwaygo/core/utils/custom_validation_util.dart';

class TextFieldCommonWidget extends StatefulWidget{
  final Size size;
  final TextEditingController textEditingController;
  final GlobalKey formKey;
  final TextInputType textInputType;
  final IconData textIcon;
  final String hintText;


  const TextFieldCommonWidget({
    super.key,
    required this.size,
    required this.textEditingController,
    required this.formKey,
    required this.textInputType,
    required this.textIcon,
    required this.hintText
  });

  @override
  _TextFieldCommonWidget createState() {
    return _TextFieldCommonWidget();
  }

}

class _TextFieldCommonWidget extends State<TextFieldCommonWidget> {
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
              style: GoogleFonts.inter(
                fontSize: 18.0,
                color: const Color(0xFF151624),
              ),
              maxLines: 1,
              keyboardType: widget.textInputType,
              cursorColor: const Color(0xFF151624),
              decoration: InputDecoration(
                hintText: widget.hintText,
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
                    )),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: const BorderSide(
                      color: AppColors.colorCyanPulse,
                    )),
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
              validator: (value){
                  if (value == null || value.isEmpty) {
              return widget.hintText + AppStrings.cannotEmpty; // Error message
            }
            if(widget.hintText.contains(AppStrings.nic) && !CustomValidationUtil.validateNic(value)){
              return AppStrings.nic + AppStrings.formatInvalid;
            }
            if(widget.hintText.contains(AppStrings.phone) && !CustomValidationUtil.validatePhoneNo(value)){
              return AppStrings.phone + AppStrings.formatInvalid;
            }
            if(widget.hintText.contains(AppStrings.email) && !CustomValidationUtil.validateEmail(value)){
              return AppStrings.email + AppStrings.formatInvalid;
            }
            return null;
          },
        ),
      ),
    );
  }
}

