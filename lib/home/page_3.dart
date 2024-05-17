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
        title: 'Rent, Buy & Sell',
        subtitle:
            'Find/Provide off campus accommodation. Buy or Advetise your stuff on campus and connect with students.');
  }
}
