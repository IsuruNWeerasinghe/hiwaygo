
import 'package:flutter/material.dart';
import 'package:hiwaygo/core/constants/app_colors.dart';
import 'package:hiwaygo/core/utils/make_phone_call_util.dart';

class BookingDetailsWidget extends StatelessWidget {
  final Size size;
  final String title;
  final String subtitle;
  final String detail1;
  final String detail2;
  final String detail3;
  final String phoneNo;
  final bool enableSecondaryButton;
  final IconData iconPrimaryButton;

  final IconData? iconSecondaryButton;
  final VoidCallback? onTapPrimary;
  final VoidCallback? onTapSecondary;

  BookingDetailsWidget({
    super.key,
    required this.size,

    required this.title,
    required this.subtitle,
    required this.detail1,
    required this.detail2,
    required this.detail3,
    required this.phoneNo,
    required this.iconPrimaryButton,
    required this.enableSecondaryButton,

    this.iconSecondaryButton,
    this.onTapPrimary,
    this.onTapSecondary,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(top: 5, bottom: 5, left: 15, right: 5),
      width: size.width * 0.9,
      height: size.height * 0.2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.colorTealBlue.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Text(
                  title,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (enableSecondaryButton && iconSecondaryButton != null)
                    IconButton(
                      onPressed: onTapSecondary,
                      icon: Icon(iconSecondaryButton),
                      color: AppColors.colorFacebookButton,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(minWidth: 30, minHeight: 30),
                    ),
                  IconButton(
                    onPressed: onTapPrimary,
                    icon: Icon(iconPrimaryButton),
                    color: AppColors.colorFacebookButton,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(minWidth: 30, minHeight: 30),
                  )
                ],
              ),
            ],
          ),
          Text(
            subtitle,
            textAlign: TextAlign.start,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            detail1,
            textAlign: TextAlign.start,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
          ),
          Text(
            detail2,
            textAlign: TextAlign.start,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
          ),
          Text(
            detail3,
            textAlign: TextAlign.start,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
          ),
          TextButton(
            onPressed: (){MakeAPhoneCall.makePhoneCall(phoneNo);},
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              alignment: Alignment.centerLeft,
              foregroundColor: AppColors.colorBlack,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              phoneNo,
              textAlign: TextAlign.start,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: AppColors.colorFacebookButton
              ),
            ),
          ),
        ],
      ),
    );
  }
}