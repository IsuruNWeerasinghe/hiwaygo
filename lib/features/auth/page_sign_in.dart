import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hiwaygo/core/constants/app_colors.dart';
import 'package:hiwaygo/core/constants/app_strings.dart';
import 'package:hiwaygo/core/widgets/app_name_and_logo_widget.dart';
import 'package:hiwaygo/core/widgets/button_widget.dart';
import 'package:hiwaygo/core/widgets/loader_widget.dart';
import 'package:hiwaygo/core/widgets/text_field_password_widget.dart';
import 'package:hiwaygo/core/widgets/social_media_button_widget.dart';
import 'package:hiwaygo/core/widgets/text_field_common_widget.dart';
import 'package:hiwaygo/routes.dart';
import 'package:hiwaygo/features/auth/data/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  bool _isLoading = true;
  String _pageContent = AppStrings.loadingPleaseWait;

  Future<void> _loadData() async {
    await Future.delayed(const Duration(seconds: 3));

    if (mounted) {
      setState(() {
        _pageContent = AppStrings.loadingCompleted;
        _isLoading = false;
      });
    }
  }

  // Function to show the exit confirmation dialog
  Future<bool> _showExitConfirmation(BuildContext context) async {
    return (await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Exit Application?'),
        content: const Text('Do you want to close the app?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false), // Stay
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true), // Close
            child: const Text('Yes'),
          ),
        ],
      ),
    )) ?? false; // Return false if the dialog is dismissed
  }

  @override
  void initState() {
    _loadData();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    emailKey = GlobalKey<FormState>();
    passwordKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    emailKey.currentState?.dispose();
    passwordKey.currentState?.dispose();
  }

  Future<void> _handleSignIn() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final token = await AuthService().login(emailController.text, passwordController.text);

        if (token != null) {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('jwt_token', token);

          if (mounted) {
            Navigator.popAndPushNamed(context, Routes.homePage);
          }
        } else {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Login Failed')),
            );
          }
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: $e')),
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, dynamic result) async {
        if (didPop) {
          return;
        }
        final bool shouldClose = await _showExitConfirmation(context);
        if (shouldClose) {
          if (Navigator.canPop(context)) {
            Navigator.pop(context, true);
          } else {
            // If this is the root route, the platform handles the app exit
            // when we signal the PopScope is complete.
            // Typically, you'd use SystemNavigator.pop() or let the system
            // handle the exit flow naturally after this point if it's the root.
          }
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.colorBackground ,
        body: _isLoading?
            const LoaderWidget():
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              buildBody(size),
              footerWidget(size),
            ],
          ),
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
            AppNameAndLogoWidget(size: size, pageName: AppStrings.signIn),
            SizedBox(height: size.height * textFieldSpacing),
            TextFieldCommonWidget(size: size, textEditingController: emailController, formKey: emailKey, textInputType: TextInputType.emailAddress, textIcon: Icons.email, hintText: AppStrings.email),
            SizedBox(height: size.height * textFieldSpacing),
            CommonPasswordField(size: size, textEditingController: passwordController, inputValueType: AppStrings.password, formKey: passwordKey),
            SizedBox(height: size.height * textFieldSpacing),
            buildRemember_ForgetSection(size),
            SizedBox(height: size.height * textFieldSpacing),
            ButtonWidget(
              size: size,
              buttonText: AppStrings.signIn,
              onTap: _handleSignIn,
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
        SocialMediaButtonWidget(
          size: size,
          buttonText: AppStrings.google,
          svgString: AppStrings.googleSvgIcon,
          buttonColor: AppColors.colorGoogleButton,
          onTap: (){},
        ),
        const SizedBox(width: 16),
        //facebook button
        SocialMediaButtonWidget(
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
