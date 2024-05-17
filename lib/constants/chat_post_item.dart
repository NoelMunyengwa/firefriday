import 'package:firefriday/business_logic/events/create_event.dart';
import 'package:firefriday/constants/colors.dart';
import 'package:firefriday/constants/message_dialogs.dart';
import 'package:firefriday/constants/whatsapp.dart';
import 'package:firefriday/dashboard/landing_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:routerino/routerino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stylish_dialog/stylish_dialog.dart';
import 'package:unicons/unicons.dart';

class StyledImageContainer extends StatefulWidget {
  final String imageUrl;
  final String description;
  final VoidCallback onLike;
  final int likes;
  final bool isLiked;
  final String phone;
  final String email;
  final String id;

  const StyledImageContainer({
    Key? key,
    required this.imageUrl,
    required this.description,
    required this.onLike,
    required this.likes,
    required this.isLiked,
    required this.phone,
    required this.email,
    required this.id,
  }) : super(key: key);

  @override
  State<StyledImageContainer> createState() => _StyledImageContainerState();
}

class _StyledImageContainerState extends State<StyledImageContainer> {
  //function to get email from prefs
  getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('email');
  }

  String prefEmail = '';
  String userName = '';

  //function to extract words before @ in prefEmail
  String getUserName(String email) {
    if (email.contains('@')) {
      userName = email.split('@').first;
    }
    return '@$userName';
  }

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
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2.0,
              blurRadius: 5.0,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Column(
            children: [
              Stack(
                children: [
                  // Image
                  Image.network(
                    widget.imageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 200.0, // Adjust height as needed
                  ),
                  // Like Button Row
                  Positioned(
                    bottom: 10.0,
                    right: 10.0,
                    child: Column(
                      children: [
                        //connect button
                        Visibility(
                          visible: widget.phone.isNotEmpty,
                          child: Row(
                            children: [
                              IconButton(
                                icon: const Icon(
                                  UniconsLine.whatsapp_alt,
                                  color: primaryColor,
                                ),
                                onPressed: () {
                                  print("phone: ${widget.phone}");
                                  //connect to user via whatsapp number
                                  if (widget.phone.isNotEmpty &&
                                      widget.phone != 'null') {
                                    launchWhatsApp(widget.phone);
                                  }
                                },
                              ),
                              Text(
                                'Connect',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: false,
                          child: Row(
                            children: [
                              IconButton(
                                icon: Icon(
                                  widget.isLiked
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: Colors.red,
                                ),
                                onPressed: widget.onLike,
                              ),
                              Text(
                                'Likes: ${widget.likes.toString()}',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  //description here
                  Positioned(
                    bottom: 0.0,
                    left: 10.0,
                    child: Row(
                      children: [
                        //user icon
                        // Icon(
                        //   Icons.person,
                        //   color: Colors.white,
                        // ),
                        Container(
                          //rounded border
                          padding: const EdgeInsets.only(left: 2, right: 2),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.grey.withOpacity(0.9),
                          ),

                          child: Text(
                            widget.email == prefEmail
                                ? 'You posted this'
                                : getUserName(widget.email),
                            style: TextStyle(
                              color: buttonColor,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.description,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  //Edit button
                  Visibility(
                    visible:
                        widget.email == prefEmail && prefEmail.contains("@")
                            ? true
                            : false,
                    child: GestureDetector(
                      onTap: () {
                        print("email: ${widget.email}");
                        try {
                          //delete post
                          deletePost(widget.id);
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
                                deletePost(widget.id).then((value) => {
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
            ],
          ),
        ),
      ),
    );
  }
}
