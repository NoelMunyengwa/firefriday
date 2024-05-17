import 'package:firefriday/business_logic/events/create_event.dart';
import 'package:firefriday/constants/message_dialogs.dart';
import 'package:firefriday/dashboard/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:routerino/routerino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stylish_dialog/stylish_dialog.dart';

class CenteredEventNameContainer extends StatefulWidget {
  final String name;
  final String imageUrl;
  final String location;
  final String time;
  final double fee;
  final String email;
  final String id;

  const CenteredEventNameContainer({
    Key? key,
    required this.name,
    required this.imageUrl,
    required this.location,
    required this.time,
    required this.fee,
    required this.email,
    required this.id,
  }) : super(key: key);

  @override
  State<CenteredEventNameContainer> createState() =>
      _CenteredEventNameContainerState();
}

class _CenteredEventNameContainerState
    extends State<CenteredEventNameContainer> {
  //function to get email from prefs
  getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('email');
  }

  String prefEmail = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getEmail().then((value) => setState(() {
          prefEmail = value!;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2.0,
            blurRadius: 5.0,
          ),
        ],
      ),
      child: Column(
        children: [
          // Centered Event Name
          Text(
            widget.name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              // Center the text
            ),
          ),
          const SizedBox(height: 8.0),
          // Image
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.network(
              widget.imageUrl,
              width: double.infinity, // Fills available width
              height: 200.0, // Adjust height as needed
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 16.0),
          // Details Column
          Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Left-align details
            children: [
              // Location
              Row(
                children: [
                  const Icon(Icons.place, size: 16.0),
                  const SizedBox(width: 5.0),
                  Text(widget.location),
                ],
              ),
              const SizedBox(height: 8.0),
              // Time
              Row(
                children: [
                  const Icon(Icons.access_time, size: 16.0),
                  const SizedBox(width: 5.0),
                  Text(widget.time),
                ],
              ),
              // const SizedBox(height: 4.0),
              // Fee
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Fee: ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '\$${widget.fee.toStringAsFixed(2)}',
                      ),
                    ],
                  ),
                  Visibility(
                    visible:
                        widget.email == prefEmail && prefEmail.contains("@")
                            ? true
                            : false,
                    child: GestureDetector(
                      onTap: () {
                        print("email: ${widget.email}");
                        try {
                          //delete event
                          deleteEvent(widget.id);

                          setState(() {
                            //refresh page
                            context.push(() => LandingPage());
                          });
                          //refresh page
                        } catch (e) {
                          print(e);
                        }

                        //edit post
                      },
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.delete_forever,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              print("email: ${widget.email}");
                              try {
                                StylishDialog loading = loadingBar(
                                    context, "Creating Advertisement");

                                loading.show();
                                //delete post
                                deleteEvent(widget.id).then((value) => {
                                      loading.dismiss(),
                                      // context.push(() => LandingPage()),
                                    });
                                setState(() {
                                  //refresh page
                                });
                                //refresh page
                              } catch (e) {
                                print(e);
                              }

                              //edit post
                            },
                          ),
                          const Text(
                            'Delete',
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              //Edit button
            ],
          ),
        ],
      ),
    );
  }
}
