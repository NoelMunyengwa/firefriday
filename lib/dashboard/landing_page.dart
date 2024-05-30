import 'package:firefriday/auth/login.dart';
import 'package:firefriday/business_logic/auth/logout.dart';
import 'package:firefriday/constants/CustomCircleAvatar.dart';
import 'package:firefriday/dashboard/pages/buy_sell.dart';
import 'package:firefriday/dashboard/pages/chat_connect.dart';
import 'package:firefriday/dashboard/pages/events.dart';
import 'package:flutter/material.dart';
import 'package:routerino/routerino.dart';
import 'package:unicons/unicons.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            // leading: const Padding(
            //   padding: EdgeInsets.only(left: 5.0),
            //   child: Text(
            //     "Hi, Noel!",
            //     style: TextStyle(
            //       fontSize: 18,
            //       fontWeight: FontWeight.bold,
            //     ),
            //   ),
            // ),
            title: const Text('UZ Portal'),
            actions: [
              IconButton(
                icon: const Icon(
                  UniconsLine.bell,
                  color: Color.fromARGB(255, 1, 17, 44),
                ),
                onPressed: () {
                  signOut().then(
                      (value) => context.pushRoot(() => const LoginPage()));
                },
              ),
              IconButton(
                icon: const Icon(
                  UniconsLine.sign_out_alt,
                  color: Colors.red,
                ),
                onPressed: () {
                  signOut().then(
                      (value) => context.pushRoot(() => const LoginPage()));
                },
              ),
            ],
            centerTitle: true,
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(UniconsLine.home_alt), text: "Home"),
                Tab(icon: Icon(UniconsLine.book_reader), text: "Courses"),
                Tab(
                    icon: Icon(UniconsLine.file_question_alt),
                    text: "Exams/Results"),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              ChatConnectPage(),
              EventsPage(),
              BuyAndSellPage(),
            ],
          ),
        ),
      ),
    );
  }
}
