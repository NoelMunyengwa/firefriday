import 'package:flutter/material.dart';
import 'package:firefriday/model/model_page.dart';

class PageThree extends StatelessWidget {
  const PageThree({super.key});

  @override
  Widget build(BuildContext context) {
    return const OnboardModel(
        assetName: 'assets/logo/rent.jpg',
        width: 400,
        height: 360,
        title: 'Accommodation and Tuition Services',
        subtitle:
            'Get access to accommodation and tuition services to make your stay in UZ comfortable.');
  }
}
