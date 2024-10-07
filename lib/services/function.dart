import 'package:url_launcher/url_launcher.dart';

void launchInstagram() async {
  final Uri params = Uri(
      scheme: 'https', host: 'instagram.com', path: 'digital.educationcenter');
  if (await canLaunchUrl(params)) {
    await launchUrl(params, mode: LaunchMode.inAppWebView);
  } else {
    print('error open instagram $params');
  }
}

void launchLink(String url) async {
    final Uri params = Uri.parse(url);
    if (await canLaunchUrl(params)) {
      await launchUrl(params, mode: LaunchMode.inAppWebView);
    } else {
      print('Error opening link $params');
    }
  }

void launchTestimoni1() async {
  final Uri params = Uri(
      scheme: 'https', host: 'instagram.com', path: 'p/C--dXZ7zMny');
  if (await canLaunchUrl(params)) {
    await launchUrl(params, mode: LaunchMode.inAppWebView);
  } else {
    print('error open instagram Testimoni1 $params');
  }
}

void launchTestimoni2() async {
  final Uri params = Uri(
      scheme: 'https', host: 'instagram.com', path: 'p/C--ddoYzdvy');
  if (await canLaunchUrl(params)) {
    await launchUrl(params, mode: LaunchMode.inAppWebView);
  } else {
    print('error open instagram Testimoni2 $params');
  }
}

void launchTestimoni3() async {
  final Uri params = Uri(
      scheme: 'https', host: 'instagram.com', path: 'p/C--dm-YzA9i');
  if (await canLaunchUrl(params)) {
    await launchUrl(params, mode: LaunchMode.inAppWebView);
  } else {
    print('error open instagram Testimoni3 $params');
  }
}

void launchYoutube() async {
  final Uri params = Uri(
      scheme: 'https', host: 'youtube.com', path: '@dec.daceducationcente');
  if (await canLaunchUrl(params)) {
    await launchUrl(params, mode: LaunchMode.inAppWebView);
  } else {
    print('error open youtube $params');
  }
}

void launchLinkIn() async {
  final Uri params = Uri(
      scheme: 'https', host: 'linkedin.com', path: 'in/digital-education-center-57a2a2325');
  if (await canLaunchUrl(params)) {
    await launchUrl(params, mode: LaunchMode.inAppWebView);
  } else {
    print('error open youtube $params');
  }
}

void launchTikTok() async {
  final Uri params = Uri(
      scheme: 'https', host: 'tiktok.com', path: '@digital.educationcenter');
  if (await canLaunchUrl(params)) {
    await launchUrl(params, mode: LaunchMode.inAppWebView);
  } else {
    print('error open tiktok $params');
  }
}

void launchWhatsapp() async {
  final Uri params =
      Uri(scheme: 'https', host: 'wa.me', path: '+6287742812548');
  if (await canLaunchUrl(params)) {
    await launchUrl(params, mode: LaunchMode.inAppWebView);
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
