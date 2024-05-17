import 'package:firefriday/business_logic/events/create_event.dart';
import 'package:firefriday/constants/colors.dart';
import 'package:firefriday/constants/message_dialogs.dart';
import 'package:firefriday/constants/whatsapp.dart';
import 'package:firefriday/dashboard/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:routerino/routerino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stylish_dialog/stylish_dialog.dart';
import 'package:unicons/unicons.dart';

class ProductDetailsContainer extends StatefulWidget {
  final String imageUrl;
  final String name;
  final String location;
  final String description;
  final double price;
  final String phoneNumber;
  final String email;
  final String id;

  const ProductDetailsContainer({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.location,
    required this.description,
    required this.price,
    required this.phoneNumber,
    required this.email,
    required this.id,
  }) : super(key: key);

  @override
  State<ProductDetailsContainer> createState() =>
      _ProductDetailsContainerState();
}

class _ProductDetailsContainerState extends State<ProductDetailsContainer> {
  String prefEmail = '';
  //function to get email from prefs
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
          // Name
          Text(
            widget.name,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
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

          // Location Row
          Row(
            children: [
              const Text(
                'Location: ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(widget.location,
                  style: const TextStyle(
                      fontStyle: FontStyle.italic,
                      color: primaryColor,
                      fontWeight: FontWeight.bold)),
            ],
          ),

          // Description

          Row(
            children: [
              const Text(
                'Details: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(widget.description),
            ],
          ),
          const SizedBox(height: 8.0),
          // Price Row
          Row(
            children: [
              const Text(
                'Price: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                '\$${widget.price.toStringAsFixed(2)}',
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          // Phone Number Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  print("phone: ${widget.phoneNumber}");
                  //connect to user via whatsapp number
                  if (widget.phoneNumber.isNotEmpty &&
                      widget.phoneNumber != 'null') {
                    launchWhatsApp(widget.phoneNumber);
                  }
                },
                child: Row(
                  children: [
                    //Icon
                    const Icon(
                      UniconsLine.whatsapp_alt,
                      color: primaryColor,
                    ),
                    Text(widget.phoneNumber),
                  ],
                ),
              ),
              //Delete product details
              //Edit button
              Visibility(
                visible: widget.email == prefEmail && prefEmail.contains("@")
                    ? true
                    : false,
                child: GestureDetector(
                  onTap: () {
                    print("email: ${widget.email}");
                    try {
                      //delete product details
                      deleteBuyAndSell(widget.id);
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
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.delete_forever,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          print("email: ${widget.email}");
                          try {
                            StylishDialog loading =
                                loadingBar(context, "Creating Advertisement");

                            loading.show();
                            //delete post
                            deleteBuyAndSell(widget.id).then((value) => {
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
    );
  }
}
