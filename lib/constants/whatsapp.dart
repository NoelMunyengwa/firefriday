import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

void launchWhatsApp(String number) async {
  final url = 'whatsapp://send?phone=$number&text=Hello..';
  print("URL: $url");
  final Uri _url = Uri.parse(url);
  if (await launchUrl(_url)) {
    await launchUrl(_url);
  } else {
    // Handle the case where WhatsApp is not installed
  }
}
