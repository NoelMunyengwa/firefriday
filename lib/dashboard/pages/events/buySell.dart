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
import 'package:stylish_dialog/stylish_dialog.dart';

class CreateSellPage extends StatefulWidget {
  @override
  _CreateSellPageState createState() => _CreateSellPageState();
}

class _CreateSellPageState extends State<CreateSellPage> {
  String _imagePath = "";
  String selectedCategory = "";
  TextEditingController _nameController = TextEditingController();
  TextEditingController _venueController = TextEditingController();
  TextEditingController _locationController = TextEditingController();

  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  TextEditingController _feeController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

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
        title: const Text('Advertisement'),
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
                  "Pick Images",
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
              const SizedBox(height: 8.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: DropdownButton<String>(
                  hint: const Text("Select Category"),
                  isExpanded: true,
                  items: <String>[
                    'Houses',
                    'Cars',
                    'Electronics',
                    'Food',
                    'Clothes',
                    'Other'
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (_) {
                    setState(() {
                      selectedCategory = _!;
                    });
                    print("Selected category: $_");
                  },
                ),
              ),
              Visibility(
                  visible: selectedCategory.isNotEmpty,
                  child: ElevatedButton(
                      onPressed: () {},
                      child: Text("Category: $selectedCategory"))),
              const SizedBox(
                height: 16,
              ),
              TextField(
                keyboardType: TextInputType.text,
                controller: _nameController,
                decoration: InputDecoration(
                    hintText: "Product Name",
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
                controller: _locationController,
                decoration: InputDecoration(
                    hintText: "Location/ address",
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
                controller: _descriptionController,
                decoration: InputDecoration(
                    hintText: "Product Description",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide.none),
                    fillColor: inputColor,
                    filled: true,
                    prefixIcon: const Icon(Icons.calendar_today)),
              ),
              const SizedBox(height: 16.0),
              TextField(
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
              const SizedBox(height: 16.0),
              TextField(
                keyboardType: TextInputType.text,
                controller: _phoneController,
                decoration: InputDecoration(
                    hintText: "Phone Number",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide.none),
                    fillColor: inputColor,
                    filled: true,
                    prefixIcon: const Icon(Icons.phone)),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_imagePath.isNotEmpty &&
                      _nameController.text.isNotEmpty &&
                      _locationController.text.isNotEmpty &&
                      _phoneController.text.isNotEmpty &&
                      _descriptionController.text.isNotEmpty) {
                    print(" ALL FIELDS ARE FILLED ");
                    Future<void> _createBuyAndSell(
                        String name,
                        String photoPath,
                        String venue,
                        String time,
                        double fee) async {
                      print("Creating Advertisement .....");
                      StylishDialog loading =
                          loadingBar(context, "Creating Advertisement");
                      StylishDialog success = successMessage(context,
                          "Advert created successfully", LandingPage());
                      StylishDialog error = errorMessage(
                          context, "Error creating advert", LandingPage());
                      loading.show();
                      await createBuyAndSell(
                              selectedCategory,
                              _nameController.text,
                              _imagePath,
                              _locationController.text,
                              _descriptionController.text,
                              double.parse(_feeController.text),
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

                    _createBuyAndSell(
                        _nameController.text,
                        _imagePath,
                        _locationController.text,
                        _descriptionController.text,
                        double.parse(_feeController.text));
                  } else {
                    print(" SOME FIELDS ARE EMPTY ");
                    //show error dialog
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
