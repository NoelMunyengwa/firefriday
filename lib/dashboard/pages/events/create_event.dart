import 'dart:io';

import 'package:firefriday/business_logic/advertisements/create_advert.dart';
import 'package:firefriday/business_logic/events/create_event.dart';
import 'package:firefriday/constants/colors.dart';
import 'package:firefriday/constants/message_dialogs.dart';
import 'package:firefriday/dashboard/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:routerino/routerino.dart';
import 'package:stylish_dialog/stylish_dialog.dart';

class CreateEventPage extends StatefulWidget {
  @override
  _CreateEventPageState createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add your Event'),
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
                  "Pick Image",
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
              DropdownButtonFormField<String>(
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
              const SizedBox(height: 16.0),
              TextField(
                keyboardType: TextInputType.text,
                controller: _nameController,
                decoration: InputDecoration(
                    hintText: "Event Name",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide.none),
                    fillColor: inputColor,
                    filled: true,
                    prefixIcon: const Icon(Icons.note_add)),
              ),
              const SizedBox(height: 16.0),
              TextField(
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
              const SizedBox(height: 16.0),
              TextField(
                keyboardType: TextInputType.text,
                controller: _timeController,
                decoration: InputDecoration(
                    hintText: "Date & Time (May 20, 17:38)",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide.none),
                    fillColor: inputColor,
                    filled: true,
                    prefixIcon: const Icon(Icons.calendar_today)),
              ),
              const SizedBox(height: 16.0),
              TextField(
                keyboardType: TextInputType.number,
                controller: _feeController,
                decoration: InputDecoration(
                    hintText: "Price (USD)",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide.none),
                    fillColor: inputColor,
                    filled: true,
                    prefixIcon: const Icon(Icons.monetization_on)),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  print("Creating event .....");
                  if (_imagePath.isNotEmpty &&
                      _nameController.text.isNotEmpty &&
                      _venueController.text.isNotEmpty &&
                      _timeController.text.isNotEmpty &&
                      _feeController.text.isNotEmpty) {
                    Future<void> _createEvent(String name, String photoPath,
                        String venue, String time, double fee) async {
                      print("Creating event ");
                      StylishDialog loading =
                          loadingBar(context, "Creating event");
                      StylishDialog success = successMessage(
                          context, "Event created successfully", LandingPage());
                      StylishDialog error = errorMessage(
                          context, "Error creating event", LandingPage());
                      loading.show();
                      await createEvent(
                              selectedEvent!, name, photoPath, venue, time, fee)
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
                        double.parse(_feeController.text));
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
                  "Continue",
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
