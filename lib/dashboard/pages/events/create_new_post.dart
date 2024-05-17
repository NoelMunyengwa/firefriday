import 'dart:io';

import 'package:firefriday/business_logic/advertisements/create_advert.dart';
import 'package:firefriday/business_logic/events/create_event.dart';
import 'package:firefriday/constants/colors.dart';
import 'package:firefriday/constants/message_dialogs.dart';
import 'package:firefriday/dashboard/landing_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:routerino/routerino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stylish_dialog/stylish_dialog.dart';

class CreatePostPage extends StatefulWidget {
  @override
  _CreatePostPageState createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  String selected_category = "";
  List<String> eventCategories = [
    'Concerts',
    'Conferences',
    'Workshops',
    'Meetups',
    'Charity',
  ];
  String? selectedEvent;
  String _imagePath = "";
  TextEditingController _nameController = TextEditingController();
  TextEditingController _venueController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  TextEditingController _feeController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  String prefEmail = '';

  Future<void> _pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      setState(() {
        _imagePath = result.files.single.path!;
      });
    }
  }

  //Get email from shared prefs
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
    return Scaffold(
      appBar: AppBar(
        //for a new post
        title: const Text('New Campus vibes post'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () => _pickImage(),
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  // padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: buttonColor,
                ),
                child: const Text(
                  "Select Image",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
              const SizedBox(height: 16.0),
              Visibility(
                visible: _imagePath.isNotEmpty,
                child: Image.file(
                  File(_imagePath),
                  height: 200,
                  width: 200,
                ),
              ),
              const SizedBox(height: 16.0),
              //Drop down to choose event category
              Visibility(
                visible: false,
                child: DropdownButtonFormField<String>(
                  value: selectedEvent,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedEvent = newValue;
                    });
                  },
                  items: eventCategories.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    hintText: 'Choose Event',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none,
                    ),
                    fillColor: inputColor,
                    filled: true,
                    prefixIcon: Icon(Icons.event),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                keyboardType: TextInputType.text,
                controller: _descriptionController,
                decoration: InputDecoration(
                    hintText: "Post Description or #tags",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide.none),
                    fillColor: inputColor,
                    filled: true,
                    prefixIcon: const Icon(Icons.description)),
              ),
              // const SizedBox(height: 16.0),
              Visibility(
                visible: false,
                child: TextField(
                  keyboardType: TextInputType.text,
                  controller: _venueController,
                  decoration: InputDecoration(
                      hintText: "Venue",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none),
                      fillColor: inputColor,
                      filled: true,
                      prefixIcon: const Icon(Icons.location_on)),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                keyboardType: TextInputType.text,
                controller: _phoneController,
                decoration: InputDecoration(
                    hintText: "Linkup phone (e.g +263782678233)",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide.none),
                    fillColor: inputColor,
                    filled: true,
                    prefixIcon: const Icon(Icons.phone)),
              ),
              const SizedBox(height: 16.0),
              Visibility(
                visible: false,
                child: TextField(
                  keyboardType: TextInputType.text,
                  controller: _feeController,
                  decoration: InputDecoration(
                      hintText: "Price",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none),
                      fillColor: inputColor,
                      filled: true,
                      prefixIcon: const Icon(Icons.monetization_on)),
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  print("Creating post .....");
                  if (_imagePath.isNotEmpty) {
                    if (_phoneController.text.isNotEmpty &&
                        !_phoneController.text.contains("+")) {
                      return;
                    }
                    Future<void> _createEvent(String name, String photoPath,
                        String venue, String time, double fee) async {
                      print("Creating post ");
                      StylishDialog loading =
                          loadingBar(context, "Creating post");
                      StylishDialog success = successMessage(
                          context, "Post created successfully", LandingPage());
                      StylishDialog error = errorMessage(
                          context, "Error creating post", LandingPage());
                      loading.show();
                      await createPost(
                              prefEmail,
                              photoPath,
                              _descriptionController.text,
                              _phoneController.text)
                          .then((value) => {
                                loading.dismiss(),
                                context.pushRoot(() => LandingPage()),
                                // if (value == "success")
                                //   {success.show()}
                                // else
                                //   {
                                //     error.show(),
                                //   }
                              });
                    }

                    print(" ALL FIELDS ARE FILLED ");

                    _createEvent(
                        _nameController.text,
                        _imagePath,
                        _venueController.text,
                        _timeController.text,
                        double.parse('20'));
                  } else {
                    print(" SOME FIELDS ARE EMPTY ");
                    //return error
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  backgroundColor: buttonColor,
                  // padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  "Post",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
