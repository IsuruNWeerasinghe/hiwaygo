import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hiwaygo/core/constants/app_colors.dart';
import 'package:hiwaygo/core/constants/app_strings.dart';
import 'package:hiwaygo/core/widgets/app_name_and_logo_widget.dart';
import 'package:hiwaygo/core/widgets/button_widget.dart';
import 'package:hiwaygo/core/widgets/text_field_password_widget.dart';
import 'package:hiwaygo/core/widgets/text_field_common_widget.dart';
import 'package:hiwaygo/routes.dart';

class PageSignUp extends StatefulWidget {
  static const String routeName = '/page_sign_up';
  const PageSignUp({super.key});

  @override
  State<PageSignUp> createState() => _PageSignInState();
}

class _PageSignInState extends State<PageSignUp> {
  late TextEditingController firstNameController, lastNameController, nicController, phoneNoController,
      emailController, rePasswordController, passwordController;
  final _formKey = GlobalKey<FormState>();
  final firstNameKey = GlobalKey<FormState>();
  final lastNameKey = GlobalKey<FormState>();
  final nicKey = GlobalKey<FormState>();
  final phoneNoKey = GlobalKey<FormState>();
  final emailKey = GlobalKey<FormState>();
  final passwordKey = GlobalKey<FormState>();
  final rePasswordKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    nicController = TextEditingController();
    phoneNoController = TextEditingController();
    emailController = TextEditingController();
    rePasswordController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.colorBackground,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
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
      ),
    );
  }

  Widget buildBody(Size size) {
    double textFieldSpacing = 0.01;
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      width: size.width * 0.9,
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
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            //logo & login text here
            AppNameAndLogoWidget(size: size, pageName: AppStrings.signUp),
            SizedBox(height: size.height * textFieldSpacing,),
            //email , password textField and rememberForget text here
            TextFieldCommonWidget(size: size, textEditingController: firstNameController, inputValueType: AppStrings.firstName, formKey: firstNameKey),
            SizedBox(height: size.height * textFieldSpacing),
            TextFieldCommonWidget(size: size, textEditingController: lastNameController, inputValueType: AppStrings.lastName, formKey: lastNameKey),
            SizedBox(height: size.height * textFieldSpacing),
            TextFieldCommonWidget(size: size, textEditingController: nicController, inputValueType: AppStrings.nic, formKey: nicKey),
            SizedBox(height: size.height * textFieldSpacing),
            TextFieldCommonWidget(size: size, textEditingController: phoneNoController, inputValueType: AppStrings.phone, formKey: phoneNoKey),
            SizedBox(height: size.height * textFieldSpacing),
            TextFieldCommonWidget(size: size, textEditingController: emailController, inputValueType: AppStrings.email, formKey: _formKey),
            SizedBox(height: size.height * textFieldSpacing),
            CommonPasswordField(size: size, textEditingController: passwordController, inputValueType: AppStrings.password, formKey: _formKey),
            SizedBox(height: size.height * textFieldSpacing),
            CommonPasswordField(size: size, textEditingController: rePasswordController, inputValueType: AppStrings.rePassword, formKey: _formKey),
            SizedBox(height: size.height * textFieldSpacing,),
            ButtonWidget(
              size: size,
              buttonText: AppStrings.signUp,
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
