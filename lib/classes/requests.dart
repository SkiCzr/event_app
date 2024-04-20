import 'dart:convert';
import 'dart:html';

import 'package:http/http.dart' as http;

class Requests{

  Future<void> fetchEvents(double latitude, double longitude, double range) async {
    final baseUrl = 'https://example.com/api/events';

    // Define query parameters
    final queryParams = {
      'latitude': latitude.toString(),
      'longitude': longitude.toString(),
      'range': range.toString(),
    };

    final uri = Uri.parse('$baseUrl?${Uri.encodeQueryComponent(queryParams as String)}');

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      // Request successful, parse and use the response
      print('Response body: ${response.body}');
    } else {
      // Request failed, handle error
      print('Request failed with status: ${response.statusCode}');
    }
  }

  Future<void> sendEventToServer(Event event) async {
    final eventJson = jsonEncode(event);

    final url = Uri.parse('https://example.com/api/events'); // Replace with your server's URL
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: eventJson,
    );

    if (response.statusCode == 201) {
      // Request successful, handle response as needed
      print('Event created successfully');
    } else {
      // Request failed, handle error
      print('Request failed with status: ${response.statusCode}');
    }
  }

}