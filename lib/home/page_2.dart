import 'package:firefriday/model/model_page.dart';
import 'package:flutter/material.dart';

class PageTwo extends StatelessWidget {
  const PageTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return const OnboardModel(
        assetName: 'assets/logo/event.jpg',
        width: 400,
        height: 360,
        title: 'On & off-campus event updates!',
        subtitle:
            ' Get the latest updates of events happening on and off-campus. Set reminders and never miss out on any event');
  }
}
