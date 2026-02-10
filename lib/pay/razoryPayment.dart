import 'package:swiggy/domain/ApiConstants.dart';
import 'package:swiggy/domain/AppConstant.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> openPayment() async {
  final uri = Uri.parse(
    AppConstant.paymentUser,
  );

  if (!await launchUrl(
    uri,
    mode: LaunchMode.externalApplication,
  )) {
    throw Exception("Could not launch payment");
  }
}