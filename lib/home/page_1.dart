import 'package:flutter/material.dart';
import 'package:firefriday/model/model_page.dart';

class PageOne extends StatelessWidget {
  const PageOne({super.key});

  @override
  Widget build(BuildContext context) {
    return const OnboardModel(
        assetName: 'assets/logo/uzlogo.png',
        width: 350,
        height: 350,
        title: 'Welcome to UZ Student Portal ',
        subtitle:
            'Get access to all the information you need to succeed in your academic journey.');
  }
}
