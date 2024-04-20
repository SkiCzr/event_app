import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../classes/event.dart';
import '../main_pages/map.dart' as map;
import 'package:google_maps_webservice/places.dart';

class EventCreationPage extends StatefulWidget {
  @override
  _EventRegistrationPageState createState() => _EventRegistrationPageState();
}

class _EventRegistrationPageState extends State<EventCreationPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  static List<File> selectedImages = [];


  List<String> to64Convert(){
    List<String> images64 = [];
    selectedImages.forEach((img) {
      Uint8List imagebytes = img.readAsBytes() as Uint8List;
      images64.add(base64Encode(imagebytes));
    });
    selectedImages= [];
    return images64;
  }

  void _addEvent() {
    final String name = nameController.text;
    final String description = descriptionController.text;
    final double price = double.tryParse(priceController.text) ?? 0;
    final String address = addressController.text;

    if (name.isNotEmpty && description.isNotEmpty && price >= 0 && address.isNotEmpty) {
      final Event newEvent = Event(
        name: name,
        description: description,
        price: price,
        address: address,
        date: selectedDate,
        location: const LatLng(0,0),
        images: to64Convert(),
      );

      setState(() {
        postEvent(newEvent);
      });

      Navigator.pop(context);
      print("All events:${map.MapPage.events.getRange(0, map.MapPage.events.length).}");// Go back to the previous page
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        selectedImages.add(File(image.path));
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Registration'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
                items: selectedImages.map(
                    (img){
                      return Builder(
                        builder: (BuildContext context) {
                          return Image.file(
                            img,
                            fit: BoxFit.fitWidth,
                          );
                        },
                      );

                    }
                ).toList(),
                options: CarouselOptions(
                  aspectRatio: 16 / 19, // Customize aspect ratio if needed
                  autoPlay: false, // Enable auto-play
                  enlargeCenterPage: true,
                  enableInfiniteScroll: true,

                ),

            ),
            SizedBox(height: 16),
            ElevatedButton(
                onPressed: _pickImage,
                style: ElevatedButton.styleFrom(
                  primary: Colors.purple,
                ),
                child: Text(
                  'Add Picture',
                  style: TextStyle(color: Colors.white),
                ),
            ),
            Text(
              'Event Details',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 8),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 8),
            TextField(
              controller: priceController,
              decoration: InputDecoration(
                labelText: 'Price',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            SizedBox(height: 8),
            TextField(
              controller: addressController,
              decoration: InputDecoration(
                labelText: 'Address',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Date',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Text(
                    '${selectedDate.toLocal()}'.split(' ')[0],
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => _selectDate(context),
                  child: Text(
                    'Select Date',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: _addEvent,
                  child: Text('Add Event'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}