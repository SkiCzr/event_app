import 'package:event_finder/additional_pages/event_creation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../additional_pages/filters.dart' as filters;
import '../classes/event.dart';

class MapPage extends StatelessWidget {
  static final List<Event> events = [
    Event(name: 'Event 1', description: 'Description for Event 1', location: LatLng(-33.86, 151.20), address: "address1", date: DateTime.now(), price: 130,images: []),
    Event(name: 'Event 2', description: 'Description for Event 2', location: LatLng(-33.84, 151.18), address: "address2", date: DateTime.now(), price: 130,images: []),
    Event(name: 'Event 3', description: 'Description for Event 3', location: LatLng(-33.82, 151.16), address: "address3", date: DateTime.now(), price: 130,images: []),
    // Add more events here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 3,
              child: Stack(

                children:  [
                  MapSection(events: events),
                  Positioned(
                    bottom: 16,
                    left: 16,
                    child: ElevatedButton(
                      onPressed: () {
                        filters.FiltersPage.openSettingsModal(context);
                      },
                      child: Text('Filters'),
                    ),
                  ),
                ]
            ),
          ),
          Expanded(
            flex: 2,
            child: EventsSection(events: events),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EventCreationPage()),
          );
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

class MapSection extends StatelessWidget {
  final List<Event> events;

  MapSection({required this.events});

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: LatLng(-33.86, 151.20),
        zoom: 11.0,
      ),
      markers: events.map((event) {
        return Marker(
          markerId: MarkerId(event.name),
          position: event.location,
          infoWindow: InfoWindow(
            title: event.name,
            snippet: event.description,
          ),
        );
      }).toSet(),

    );
  }
}

class EventsSection extends StatelessWidget {
  final List<Event> events;

  EventsSection({required this.events});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: events.length,
      itemBuilder: (context, index) {
        final event = events[index];
        return Card(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            title: Text(event.name),
            subtitle: Text(event.description),
            //onTap:,
          ),
        );
      },
    );
  }
}