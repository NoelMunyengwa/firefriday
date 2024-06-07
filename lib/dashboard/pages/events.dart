import 'package:firefriday/constants/comingSoon.dart';
import 'package:firefriday/constants/event_item.dart';
import 'package:firefriday/constants/iconButtonRow.dart';
import 'package:firefriday/dashboard/pages/events/buySell.dart';
import 'package:firefriday/dashboard/pages/events/create_event.dart';
import 'package:firefriday/dashboard/uzportal/courses/courses.dart';
import 'package:firefriday/dashboard/uzportal/courses/timetable.dart';
import 'package:flutter/material.dart';
import 'package:routerino/routerino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unicons/unicons.dart';

import '../../business_logic/events/create_event.dart';
import '../../constants/colors.dart';

class EventsPage extends StatefulWidget {
  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  var eventCategories = [
    'Java Programming',
    'Web Development',
    'Computer Security',
    'Networking',
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
          context.push(() => CoursesPage());
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
          context.push(() => TimetablePage());
        },
        "trailingWidget": const Icon(Icons.more_horiz),
      },
    ];
    return Scaffold(
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
                  itemCount: eventCategories.length,
                  itemBuilder: (context, index) {
                    var selectedCategory = eventCategories[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                        ),
                        onPressed: () {
                          // selectedCategory = eventCategories[index];
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
                  child: IconButtonRow(
                    icon: coursesData[index]['icon'],
                    text: coursesData[index]['text'],
                    onPressed: () {
                      // Your on-click functionality here
                      coursesData[index]['onPressed']();
                    },
                    trailingWidget: const Icon(Icons.arrow_forward_ios),
                  ),
                );
              },
              childCount:
                  coursesData.length, // Replace with the actual number of items
            ),
          ),
        ],
      ),
      floatingActionButton: Stack(
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
              icon:
                  const Icon(UniconsLine.file_upload_alt, color: primaryColor),
              label: const Text(
                'Assignments',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
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
