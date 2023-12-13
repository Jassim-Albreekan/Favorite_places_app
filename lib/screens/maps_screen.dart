// Import the Flutter Material library, which provides widgets and themes for building UIs
import 'package:flutter/material.dart';
// Import the google_maps_flutter package, which allows displaying Google Maps in Flutter
import 'package:google_maps_flutter/google_maps_flutter.dart';
// Import the place.dart file, which contains the PlaceLocation model class
import 'package:great_places/models/place.dart';

// Define the MapsScreen class, which is a StatefulWidget that displays a map with an optional location selection
class MapsScreen extends StatefulWidget {
  // Define a constructor that takes initialLocation and isSelected as named arguments, and sets default values for them
  // initialLocation is a PlaceLocation object that defines the initial center of the map
  // isSelected is a bool value that determines whether the user can select a location on the map or not
  MapsScreen(
      {this.initialLocation = const PlaceLocation(
        latitude: 26.420683,
        longitude: 50.088795,
        address: "default",
      ),
      this.isSelected = false});

  // Define a final PlaceLocation field named initialLocation, which stores the initial location of the map
  final PlaceLocation initialLocation;
  // Define a final bool field named isSelected, which stores the selection mode of the map
  final bool isSelected;

  // Override the createState method to return an instance of _MapsScreenState
  @override
  _MapsScreenState createState() => _MapsScreenState();
}

// Define the _MapsScreenState class, which is the state class for MapsScreen
class _MapsScreenState extends State<MapsScreen> {
  // Define a LatLng field named _pickedLocation, which stores the selected location on the map
  LatLng _pickedLocation = const LatLng(0.0, 0.0);

  // Define a void method named _selectLocation, which takes a LatLng object as an argument and updates the _pickedLocation field
  void _selectLocation(LatLng position) {
    // Call setState to update the _pickedLocation field with the given position
    setState(() {
      _pickedLocation = position;
    });
  }

  // Override the build method to return a widget tree for the MapsScreen widget
  @override
  Widget build(BuildContext context) {
    // Return a Scaffold widget, which provides a basic app structure with an app bar and a body
    return Scaffold(
      // Set the appBar argument to an AppBar widget, which displays a title and an optional action button
      appBar: AppBar(
        // Set the title argument to a const Text widget, which displays the text 'Your Map'
        title: const Text('Your Map'),
        // Set the actions argument to a list of widgets, which are displayed after the title
        actions: [
          // Use an if statement to conditionally add an IconButton widget, which displays an icon that can be pressed to confirm the location selection
          // The condition is based on the widget.isSelected field, which determines whether the map is in selection mode or not
          if (widget.isSelected)
            IconButton(
              // Set the onPressed argument to a conditional expression, which executes a function when the button is pressed or does nothing otherwise
              // The condition is based on the _pickedLocation field, which determines whether a location has been selected or not
              // The function is to pop the current route from the Navigator and pass the _pickedLocation object as the result
              onPressed: _pickedLocation == const LatLng(0.0, 0.0)
                  ? null
                  : () {
                      Navigator.of(context).pop(_pickedLocation);
                    },
              // Set the icon argument to a const Icon widget, which displays an icon of a check mark
              icon: const Icon(Icons.check),
            ),
        ],
      ),
      // Set the body argument to a GoogleMap widget, which displays a Google Map with the given parameters
      body: GoogleMap(
        // Set the onTap argument to a conditional expression, which assigns a function to handle the tap event on the map or does nothing otherwise
        // The condition is based on the widget.isSelected field, which determines whether the map is in selection mode or not
        // The function is to call the _selectLocation method and pass the position of the tap as an argument
        onTap: widget.isSelected ? _selectLocation : null,
        // Set the initialCameraPosition argument to a CameraPosition object, which defines the initial position and zoom level of the map
        initialCameraPosition: CameraPosition(
          // Set the target argument to a LatLng object, which defines the center of the map
          // The latitude and longitude values are taken from the widget.initialLocation field
          target: LatLng(widget.initialLocation.latitude,
              widget.initialLocation.longitude),
          // Set the zoom argument to 16, which defines the zoom level of the map
          zoom: 16,
        ),
        // Set the markers argument to a conditional expression, which assigns a set of Marker objects to the map or an empty set otherwise
        // The condition is based on the _pickedLocation field and the widget.isSelected field, which determine whether a location has been selected or not
        // The set contains a single Marker object, which defines the position and id of the marker
        markers: (_pickedLocation.toString() == '0.0' && widget.isSelected)
            ? {}
            : {
                Marker(
                  // Set the markerId argument to a const MarkerId object, which defines the id of the marker
                  markerId: const MarkerId('m1'),
                  // Set the position argument to the _pickedLocation object, which defines the position of the marker
                  position: _pickedLocation,
                ),
              },
      ),
    );
  }
}
