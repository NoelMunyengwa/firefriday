import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

void launchLinkedIn() async {
  const url =
      'https://www.linkedin.com/in/noel-munyengwa-93326919a/?trk=public-profile-join-page';
  print("URL: $url");
  final Uri url0 = Uri.parse(url);
  if (await launchUrl(url0)) {
    await launchUrl(url0);
  } else {
    // Handle the case where WhatsApp is not installed
  }
}
