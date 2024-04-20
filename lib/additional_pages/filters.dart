import 'package:flutter/material.dart';

class FiltersPage extends StatelessWidget {

 static String? selectedGenre = 'Any';
  static String? selectedPartyType = 'Any';
  static double maxPrice = 0; // Default max price value
  static double radius = 25; // Default radius
  static void onGenreChanged(String? value) {

      selectedGenre = value;

  }

  static void onPartyTypeChanged(String? value) {

      selectedPartyType = value;

  }

  static void onMaxPriceChanged(String value) {

      maxPrice = double.tryParse(value) ?? 0;

  }


 static void onRadiusChanged(String value) {

   maxPrice = double.tryParse(value) ?? 0;

 }

  static void openSettingsModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return  Center(

            child: Container(

              padding: EdgeInsets.all(16),
              child: Column(

                mainAxisSize: MainAxisSize.min,
                children: [

                  Text(

                    'Filters',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16), // Add spacing between title and settings

                  Text(
                    'Event Genre',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  DropdownButton<String>(
                    value: selectedGenre,
                    onChanged: onGenreChanged,
                    items: <String>['Any', 'Concert', 'Sport', 'Theater', 'Exhibition']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 8),






                  Text(
                    'Party Type',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  DropdownButton<String>(
                    value: selectedPartyType,
                    onChanged: onPartyTypeChanged,
                    items: <String>['Any', 'Indoor', 'Outdoor']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 8),





                  Text(
                    'Maximum Price',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Enter maximum price',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: onMaxPriceChanged,
                  ),




                  Text(
                    'Radius',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Enter search radius',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: onRadiusChanged,
                  ),

                  ElevatedButton(
                    onPressed: () {
                      //Send GET request
                    },
                    child: Text('Save'),
                  ),

                ],
              ),
            ),
          );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}