import 'package:url_launcher/url_launcher.dart';

void launchInstagram() async {
  final Uri params =
      Uri(scheme: 'https', path: 'www.instagram.com/dac.solutioninformatika');
  if (await canLaunchUrl(params)) {
    await launchUrl(params);
  } else {
    print('error open mail $params');
  }
}

void launchWhatsapp() async {
  final Uri params = Uri(scheme: 'https', path: 'wa.me/+6287742812548');
  if (await canLaunchUrl(params)) {
    await launchUrl(params);
  } else {
    print('error open whatsapp $params');
  }
}

void launchEmail() async {
  final Uri params = Uri(scheme: 'mailto', path: 'support@dac-solution.com');
  if (await canLaunchUrl(params)) {
    await launchUrl(params);
  } else {
    print('error open email $params');
  }
}
