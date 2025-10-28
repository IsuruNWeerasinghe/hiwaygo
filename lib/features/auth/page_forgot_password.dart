import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hiwaygo/core/constants/app_colors.dart';
import 'package:hiwaygo/core/constants/app_strings.dart';
import 'package:hiwaygo/core/widgets/app_name_and_logo_widget.dart';
import 'package:hiwaygo/core/widgets/common_button_large.dart';
import 'package:hiwaygo/core/widgets/common_password_field.dart';
import 'package:hiwaygo/core/widgets/common_text_field.dart';
import 'package:hiwaygo/routes.dart';

class PageForgotPassword extends StatefulWidget {
  static const String routeName = '/page_forgot_password';
  const PageForgotPassword({super.key});

  @override
  State<PageForgotPassword> createState() => _PageSignInState();
}

class _PageSignInState extends State<PageForgotPassword> {
  late TextEditingController emailController;
  final _formKey = GlobalKey<FormState>();
  final emailKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.colorBackground,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(height: size.height * 0.02),
            buildBody(size),
            footerWidget(size)
          ],
        ),
      ),
    );
  }

  Widget buildBody(Size size) {
    double textFieldSpacing = 0.02;
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      width: size.width * 0.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.colorTealBlue.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 3)
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            //logo & login text here
            AppNameAndLogoWidget(size: size, pageName: AppStrings.forgotPassword),
            SizedBox(height: size.height * textFieldSpacing,),
            //email , password textField and rememberForget text here
            CommonTextField(size: size, textEditingController: emailController, inputValueType: AppStrings.email, formKey: _formKey),
            SizedBox(height: size.height * textFieldSpacing),
            CommonButtonLarge(
              size: size,
              buttonText: AppStrings.forgotPassword,
              onTap: (){
                // 4. Trigger validation by checking the current state of the form.
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar or proceed with submission.
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );
                  // Logic to save data, call an API, etc.
                } else {
                  // If the form is invalid, the error messages defined in the validator
                  // functions will automatically appear below the TextFormFields.
                  print('Form is invalid.');
                }
              },
            ),
            SizedBox(height: size.height * textFieldSpacing)
          ],
        ),
      ),
    );
  }

  Widget footerWidget(Size size) {
    return Padding(
      padding: EdgeInsets.only(top: size.height * 0.03),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            AppStrings.backTo,
            style: TextStyle(
              fontWeight: FontWeight.w400,
            ),
          ),
          TextButton(
              child: Text(
                AppStrings.signIn,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: AppColors.colorTealBlue,
                ),
              ),
              onPressed: (){
                Navigator.popAndPushNamed(context, Routes.signInPage);
              }
          ),
        ],
      ),
    );
  }
}
