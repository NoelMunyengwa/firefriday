import 'package:firefriday/auth/login.dart';
import 'package:firefriday/business_logic/auth/logout.dart';
import 'package:firefriday/business_logic/events/create_event.dart';
import 'package:firefriday/constants/colors.dart';
import 'package:firefriday/constants/comingSoon.dart';
import 'package:firefriday/constants/event_item.dart';
import 'package:firefriday/constants/greeting.dart';
import 'package:firefriday/constants/iconButtonRow.dart';
import 'package:firefriday/constants/selectedItemsList.dart';
import 'package:firefriday/dashboard/pages/events/buySell.dart';
import 'package:firefriday/dashboard/pages/events/create_event.dart';
import 'package:flutter/material.dart';
import 'package:routerino/routerino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unicons/unicons.dart';

class CoursesPage extends StatefulWidget {
  @override
  State<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  var coursesData = [];
  var departmentCategories = [
    //departments
    'All',
    'Computer Science',
    'Information Technology',
    'Software Engineering',
    'Computer Engineering',
  ];
  List<Map<String, dynamic>> events = [];

  //Function to filter events by category
  void filterEvents(String category) {
    List<Map<String, dynamic>> filteredEvents = [];
    events.forEach((event) {
      if (event['event_category'] == category) {
        filteredEvents.add(event);
      }
    });
    setState(() {
      events = filteredEvents;
    });
  }

  String prefEmail = '';

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
    getEvents().then((value) {
      setState(() {
        events = value!;
      });
      print(events);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> coursesData = [
      {
        "icon": UniconsLine.book_open,
        "text": "Courses and Timetabling",
        "onPressed": () {
          // Implement your "Add to Cart" functionality here
        },
      },
      {
        "icon": UniconsLine.check_circle,
        "text": "Course Confirmation",
        "onPressed": () {
          // Implement your "Add to Favorites" functionality here
          context.push(() => const ComingSoonPage());
        },
      },
      {
        "icon": UniconsLine.file_question_alt,
        "text": "Courses On Offer",
        "onPressed": () {
          // Implement your "Share" functionality here
          context.push(() => const ComingSoonPage());
        },
        "trailingWidget": const Icon(Icons.more_horiz),
      },
      {
        "icon": UniconsLine.save,
        "text": "Course Registration",
        "onPressed": () {
          // Implement your "Share" functionality here
          context.push(() => const ComingSoonPage());
        },
        "trailingWidget": const Icon(Icons.more_horiz),
      },
      {
        "icon": UniconsLine.history_alt,
        "text": "Registration History",
        "onPressed": () {
          // Implement your "Share" functionality here
          context.push(() => const ComingSoonPage());
        },
        "trailingWidget": const Icon(Icons.more_horiz),
      },
      {
        "icon": UniconsLine.table,
        "text": "Timetable",
        "onPressed": () {
          // Implement your "Share" functionality here
        },
        "trailingWidget": const Icon(Icons.more_horiz),
      },
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Courses",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              UniconsLine.sign_out_alt,
              color: Colors.red,
            ),
            onPressed: () {
              signOut()
                  .then((value) => context.pushRoot(() => const LoginPage()));
            },
          ),
        ],
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: MySliverPersistentHeaderDelegate(
              // Your scrollable row content here
              child: Container(
                color: secondaryColor,
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: departmentCategories.length,
                  itemBuilder: (context, index) {
                    var selectedCategory = departmentCategories[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                        ),
                        onPressed: () {
                          // selectedCategory = departmentCategories[index];
                          // filterEvents(selectedCategory);
                        },
                        icon: const Icon(
                          UniconsLine.bookmark,
                          color: primaryColor,
                        ),
                        label: Text(selectedCategory),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                // Generate a random color for each container
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 6.0),
                  child: SelectedItemList(
                    text: coursesData[index]['text'],
                    onPressed: () {
                      // Your on-click functionality here
                    },
                    onCheckboxChanged: (value) {
                      // Your on-change functionality here
                    },
                  ),
                );
              },
              childCount:
                  coursesData.length, // Replace with the actual number of items
            ),
          ),
        ],
      ),
      floatingActionButton: Visibility(
        visible: true,
        child: Stack(
          children: [
            Positioned(
              bottom: 20.0, // Adjust for desired bottom spacing
              right: 5.0, // Adjust for desired right spacing
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                ),
                onPressed: () {
                  context.push(() => const ComingSoonPage());
                },
                icon: const Icon(UniconsLine.table, color: primaryColor),
                label: const Text(
                  'Auto Create TimeTable',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            // Positioned(
            //   bottom: 20.0, // Adjust for desired bottom spacing
            //   right: 5.0, // Adjust for desired right spacing
            //   child: ElevatedButton.icon(
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor: Colors.transparent,
            //       shape: const StadiumBorder(),
            //     ),
            //     onPressed: () => context.push(() => CreateEventPage()),
            //     icon: const Icon(UniconsLine.edit_alt, color: primaryColor),
            //     label: const Text(
            //       'Manage Event',
            //       style:
            //           TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

class MySliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  MySliverPersistentHeaderDelegate({required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 50; // Set the maximum height of the header

  @override
  double get minExtent => 50; // Set the minimum height of the header

  @override
  bool shouldRebuild(covariant MySliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
