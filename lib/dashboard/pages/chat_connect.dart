import 'package:firefriday/business_logic/events/create_event.dart';
import 'package:firefriday/constants/chat_post_item.dart';
import 'package:firefriday/constants/colors.dart';
import 'package:firefriday/constants/iconButtonRow.dart';
import 'package:firefriday/dashboard/pages/events/create_new_post.dart';
import 'package:flutter/material.dart';
import 'package:routerino/routerino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unicons/unicons.dart';

class ChatConnectPage extends StatefulWidget {
  @override
  State<ChatConnectPage> createState() => _ChatConnectPageState();
}

class _ChatConnectPageState extends State<ChatConnectPage> {
  List<Map<String, dynamic>> posts = [];
  List<int> likedPosts = [];

  List<Map<String, dynamic>> paymentsData = [
    {
      "icon": UniconsLine.user_plus,
      "text": "Manage Users",
      "onPressed": () {
        // Implement your "Add to Cart" functionality here
      },
    },
    {
      "icon": Icons.monetization_on_outlined,
      "text": "Ecocash Payments",
      "onPressed": () {
        // Implement your "Add to Cart" functionality here
      },
    },
    {
      "icon": UniconsLine.credit_card,
      "text": "Paynow Payments",
      "onPressed": () {
        // Implement your "Add to Favorites" functionality here
      },
    },
    {
      "icon": UniconsLine.file_question_alt,
      "text": "Quotation",
      "onPressed": () {
        // Implement your "Share" functionality here
      },
      "trailingWidget": const Icon(Icons.more_horiz),
    },
    {
      "icon": UniconsLine.invoice,
      "text": "Invoice",
      "onPressed": () {
        // Implement your "Share" functionality here
      },
      "trailingWidget": const Icon(Icons.more_horiz),
    },
    {
      "icon": UniconsLine.file_alt,
      "text": "Statement",
      "onPressed": () {
        // Implement your "Share" functionality here
      },
      "trailingWidget": const Icon(Icons.more_horiz),
    },
  ];

  //Order posts  by most likes
  // void hotStudents(int index) {
  //   setState(() {
  //     posts.sort((a, b) => b['likes'].compareTo(a['likes']));
  //   });
  // }

  String prefEmail = '';
  bool liked_already = false;

  List<Map<String, dynamic>> liked_posts = [];

  //get email from shared prefs
  getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('email');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getEmail().then((value) => setState(() {
          prefEmail = value!;
        }));
    getPosts().then((value) => setState(() {
          posts = value!;
        }));
    print(posts);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: paymentsData
            .length, // Replace with the actual number of containers you want to display
        itemBuilder: (context, index) {
          // Generate a random color for each container
          final color = Color((index * 0x11111111) % 0xFFFFFFFF);
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
            child: IconButtonRow(
              icon: paymentsData[index]['icon'],
              text: paymentsData[index]['text'],
              onPressed: () {
                // Your on-click functionality here
                paymentsData[index]['onPressed']();
              },
              trailingWidget: const Icon(Icons.arrow_forward_ios),
            ),
          );
        },
      ),
      floatingActionButton: Stack(
        children: [
          Positioned(
            bottom: 20.0, // Adjust for desired bottom spacing
            right: 5.0, // Adjust for desired right spacing
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                shape: StadiumBorder(),
              ),
              onPressed: () {
                if (prefEmail.isNotEmpty) {
                  context.push(() => CreatePostPage());
                } else {}
              },
              icon: const Icon(
                UniconsLine.graduation_cap,
                color: primaryColor,
              ),
              label: const Text(
                'Profile',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          // Positioned(
          //   bottom: 20.0, // Adjust for desired bottom spacing
          //   right: 5.0, // Adjust for desired right spacing
          //   child: ElevatedButton.icon(
          //     style: ElevatedButton.styleFrom(
          //       shape: StadiumBorder(),
          //     ),
          //     onPressed: () {},
          //     icon: const Icon(
          //       UniconsLine.edit_alt,
          //       color: primaryColor,
          //     ),
          //     label: const Text(
          //       'Manage Posts',
          //       style: TextStyle(color: Colors.black),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
