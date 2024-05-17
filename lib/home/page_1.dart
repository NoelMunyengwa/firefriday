import 'package:flutter/material.dart';
import 'package:firefriday/model/model_page.dart';

class PageOne extends StatelessWidget {
  const PageOne({super.key});

  @override
  Widget build(BuildContext context) {
    return const OnboardModel(
        assetName: 'assets/logo/connect.jpg',
        width: 350,
        height: 350,
        title: 'Welcome to UZ Connect ',
        subtitle:
            'Hookup with hot varsity students and get the best of your campus life!');
  }
}
