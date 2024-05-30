import 'package:firefriday/model/model_page.dart';
import 'package:flutter/material.dart';

class PageTwo extends StatelessWidget {
  const PageTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return const OnboardModel(
        assetName: 'assets/logo/uzlogo.png',
        width: 400,
        height: 360,
        title: 'Results and Course updates',
        subtitle: 'Get updates on your results and course updates on the go.');
  }
}
