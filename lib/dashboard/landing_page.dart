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
            leading: CustomeCirleAvatar(
              imageUrl: 'assets/logo/firefriday.jpg',
            ),
            title: const Text('UZ Connect'),
            actions: [
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
                Tab(icon: Icon(UniconsLine.comment_heart)),
                Tab(icon: Icon(UniconsLine.location_arrow)),
                Tab(icon: Icon(UniconsLine.shopping_cart)),
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
