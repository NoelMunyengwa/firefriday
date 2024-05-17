import 'package:firefriday/constants/event_item.dart';
import 'package:firefriday/dashboard/pages/events/buySell.dart';
import 'package:firefriday/dashboard/pages/events/create_event.dart';
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
    'Concerts',
    'Conferences',
    'Workshops',
    'Meetups',
    'Charity',
    'Other'
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
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: MySliverPersistentHeaderDelegate(
              // Your scrollable row content here
              child: Container(
                color: inputColor.withOpacity(0.1),
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
                          UniconsLine.shopping_bag,
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
                return CenteredEventNameContainer(
                  name: events[index]['name'],
                  imageUrl: events[index]['image'],
                  location: events[index]['location'],
                  time: events[index]['time'],
                  fee: events[index]['fee'],
                  email: events[index]['owner'],
                  id: events[index]['id'].toString(),
                );
              },
              childCount:
                  events.length, // Replace with the actual number of items
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
                if (prefEmail.isNotEmpty) {
                  context.push(() => CreateEventPage());
                } else {}
              },
              icon: const Icon(UniconsLine.schedule, color: primaryColor),
              label: const Text(
                'Create Event',
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
