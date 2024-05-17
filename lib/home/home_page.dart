import 'package:firefriday/auth/login.dart';
import 'package:firefriday/home/page_1.dart';
import 'package:firefriday/home/page_2.dart';
import 'package:firefriday/home/page_3.dart';
import 'package:flutter/material.dart';
import 'package:routerino/routerino.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../constants/linkedIn.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

PageController controller = PageController();
bool onLastPage = false;
bool visiblePage = false;

class _HomePageState extends State<HomePage> {
  List<Widget> page = [const PageOne(), const PageTwo(), const PageThree()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller,
            children: page,
            onPageChanged: (index) {
              setState(() {
                visiblePage = (index == 0);
                onLastPage = (index == 2);
                page = [const PageOne(), const PageTwo(), const PageThree()];
              });
            },
          ),
          Container(
            alignment: const Alignment(0, 0.8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Visibility(
                    visible: visiblePage,
                    child: visiblePage
                        ? GestureDetector(
                            onTap: () {
                              context.push(() => const LoginPage());
                            },
                            child: ElevatedButton(
                                onPressed: () {
                                  context.push(() => const LoginPage());
                                },
                                child: const Text('Skip')),
                          )
                        : Container()),
                SmoothPageIndicator(controller: controller, count: page.length),
                onLastPage
                    ? GestureDetector(
                        onTap: () {
                          context.push(() => const LoginPage());
                        },
                        child: ElevatedButton(
                            onPressed: () {
                              context.push(() => const LoginPage());
                            },
                            child: const Text('Done')),
                      )
                    : GestureDetector(
                        onTap: () {
                          controller.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeIn);
                        },
                        child: ElevatedButton(
                            onPressed: () {
                              controller.nextPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeIn);
                            },
                            child: const Text('Next')),
                      )
              ],
            ),
          ),
          //Put a powered by name here
          GestureDetector(
            onTap: () {
              launchLinkedIn();
            },
            child: Container(
              alignment: const Alignment(0, 0.9),
              child: const Text('Powered by Noel Munyengwa',
                  style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic)),
            ),
          )
        ],
      ),
    );
  }
}
