
import 'package:url_launcher/url_launcher.dart';

class MakeAPhoneCall{
  static Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      // Handle the case where the phone app cannot be launched
      throw 'Could not launch $phoneNumber';
    }
  }
}