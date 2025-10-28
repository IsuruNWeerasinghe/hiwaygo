import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hiwaygo/core/constants/app_colors.dart';
import 'package:hiwaygo/core/constants/app_strings.dart';
import 'package:hiwaygo/core/widgets/app_name_and_logo_widget.dart';
import 'package:hiwaygo/core/widgets/common_button_large.dart';
import 'package:hiwaygo/core/widgets/common_password_field.dart';
import 'package:hiwaygo/core/widgets/common_social_media_button.dart';
import 'package:hiwaygo/core/widgets/common_text_field.dart';
import 'package:hiwaygo/routes.dart';

class PageSignIn extends StatefulWidget {
  static const String routeName = '/page_sign_in';
  const PageSignIn({Key? key}) : super(key: key);

  @override
  State<PageSignIn> createState() => _PageSignInState();
}

class _PageSignInState extends State<PageSignIn> {
  late TextEditingController emailController, passwordController;
  late GlobalKey emailKey, passwordKey;
  final _formKey = GlobalKey<FormState>();
  late bool isRememberMe = false;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    emailKey = GlobalKey<FormState>();
    passwordKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    emailKey.currentState?.dispose();
    passwordKey.currentState?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFF8F8F8),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            buildBody(size),
            footerWidget(size),
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
            AppNameAndLogoWidget(size: size, pageName: AppStrings.signIn),
            SizedBox(height: size.height * textFieldSpacing),
            CommonTextField(size: size, textEditingController: emailController, inputValueType: AppStrings.email, formKey: emailKey),
            SizedBox(height: size.height * textFieldSpacing),
            CommonPasswordField(size: size, textEditingController: passwordController, inputValueType: AppStrings.password, formKey: passwordKey),
            SizedBox(height: size.height * textFieldSpacing),
            buildRemember_ForgetSection(size),
            SizedBox(height: size.height * textFieldSpacing),
            CommonButtonLarge(
              size: size,
              buttonText: AppStrings.signIn,
              onTap: (){
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );
                } else {
                  print('Form is invalid.');
                }
              },
            ),
            SizedBox(height: size.height * textFieldSpacing),
            buildNoAccountText(),
            SizedBox(height: size.height * textFieldSpacing),
            socialMediaSignInWidget(size),
            SizedBox(height: size.height * textFieldSpacing),

          ],
        ),
      ),
    );
  }


  Widget buildRemember_ForgetSection(Size size) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Container(
            alignment: Alignment.center,
            width: 20.0,
            height: 20.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: AppColors.colorBackground,
            ),
            child: Checkbox(
                value: isRememberMe,
                onChanged: (bool? checkStatus){
                  setState(() {
                    isRememberMe = checkStatus ?? false;
              });
            },
              activeColor: AppColors.colorTealBlue,
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            'Remember me',
            style: GoogleFonts.inter(
              fontSize: 15.0,
              color: const Color(0xFF0C0D34),
            ),
          ),
          const Spacer(),
          TextButton(
            onPressed: () {
              Navigator.popAndPushNamed(context, Routes.forgotPasswordPage);
            },
            child: Text(
              AppStrings.forgotPassword + AppStrings.questionMark,
              style: GoogleFonts.inter(
                fontSize: 13.0,
                color: AppColors.colorTealBlue,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }


  Widget buildNoAccountText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const Expanded(
            flex: 2,
            child: Divider(
              color: Color(0xFF969AA8),
            )),
        Expanded(
          flex: 3,
          child: Text(
            'Don’t Have Account?',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 12.0,
              color: const Color(0xFF969AA8),
              fontWeight: FontWeight.w500,
              height: 1.67,
            ),
          ),
        ),
        const Expanded(
            flex: 2,
            child: Divider(
              color: Color(0xFF969AA8),
            )),
      ],
    );
  }

  Widget socialMediaSignInWidget(Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        //google button
        CommonSocialMediaButton(
          size: size,
          buttonText: AppStrings.google,
          svgString: AppStrings.googleSvgIcon,
          buttonColor: AppColors.colorGoogleButton,
          onTap: (){},
        ),
        const SizedBox(width: 16),
        //facebook button
        CommonSocialMediaButton(
          size: size,
          buttonText: AppStrings.facebook,
          svgString: AppStrings.facebookSvgIcon,
          buttonColor: AppColors.colorFacebookButton,
          onTap: (){},
        ),
      ],
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
            AppStrings.dontHaveAccount,
            style: TextStyle(
              fontWeight: FontWeight.w400,
            ),
          ),
          TextButton(
              child: Text(
                AppStrings.signUp + AppStrings.here,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: AppColors.colorTealBlue,
                ),
              ),
              onPressed: (){
                Navigator.popAndPushNamed(context, Routes.signUpPage);
              }
          ),
        ],
      ),
    );
  }
}
