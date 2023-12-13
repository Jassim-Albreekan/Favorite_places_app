// Import the Flutter Material library, which provides widgets and themes for building UIs
import 'package:flutter/material.dart';
// Import the maps_screen.dart file, which contains the MapsScreen widget for displaying a map
import 'package:great_places/screens/maps_screen.dart';
// Import the location package, which allows accessing the device's location
import 'package:location/location.dart';
// Import the location_helper.dart file, which contains the LocationHelper class for generating a static map image
import 'package:great_places/helpers/location_helper.dart';
// Import the google_maps_flutter package, which allows displaying Google Maps in Flutter
import 'package:google_maps_flutter/google_maps_flutter.dart';

// Define the LocationInput class, which is a StatefulWidget that allows the user to select a location
class LocationInput extends StatefulWidget {
  // Define a final Function field named onSelectPlace, which is passed from the parent widget and is used to pass the selected location back
  LocationInput(this.onSelectPlace, {Key? key}) : super(key: key);

  final Function onSelectPlace;

  // Override the createState method to return an instance of _LocationInputState
  @override
  _LocationInputState createState() => _LocationInputState();
}

// Define the _LocationInputState class, which is the state class for LocationInput
class _LocationInputState extends State<LocationInput> {
  // Define a String field named _previewImageUrl, which stores the URL of the static map image
  String _previewImageUrl = '';

  // Define a void method named _showPreview, which takes the latitude and longitude as arguments and updates the _previewImageUrl field
  void _showPreview(double lat, double lng) {
    // Call the generateLocationPreviewImage method from the LocationHelper class and pass the latitude and longitude as arguments
    // This method returns a URL of a static map image with a marker at the given coordinates
    final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(
      latitude: lat,
      longitude: lng,
    );
    // Call setState to update the _previewImageUrl field with the static map image URL
    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });
  }

  // Define an async method named _getCurrentUserLocation, which gets the current location of the user and updates the _previewImageUrl field
  Future<void> _getCurrentUserLocation() async {
    try {
      // Await the result of calling the getLocation method from the Location class
      // This method returns a LocationData object that contains the latitude and longitude of the user's location
      final locData = await Location().getLocation();
      // Call the _showPreview method and pass the latitude and longitude from the locData object
      _showPreview(locData.latitude!, locData.longitude!);
      // Call the onSelectPlace function from the widget field and pass the latitude and longitude from the locData object
      widget.onSelectPlace(locData.latitude, locData.longitude);
    } catch (error) {
      // If an error occurs, return early
      return;
    }
  }

  // Define an async method named _selectOnMap, which allows the user to select a location on a map and updates the _previewImageUrl field
  Future<void> _selectOnMap() async {
    // Await the result of pushing a MaterialPageRoute to the Navigator
    // The MaterialPageRoute takes a MapsScreen widget as the builder argument, and sets the isSelected argument to true
    // This means that the MapsScreen widget will allow the user to select a location by tapping on the map
    // The MaterialPageRoute also sets the fullscreenDialog argument to true, which means that the MapsScreen widget will be displayed as a modal dialog
    // The result of the MaterialPageRoute is a LatLng object that contains the coordinates of the selected location
    final LatLng selectedLocation = await Navigator.of(context).push(
        MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) => MapsScreen(isSelected: true)));
    // If the selectedLocation object is null or has zero values, return early
    if (selectedLocation.toString() == '0.0') {
      return;
    }
    // Call the _showPreview method and pass the latitude and longitude from the selectedLocation object
    _showPreview(selectedLocation.latitude, selectedLocation.longitude);
    // Call the onSelectPlace function from the widget field and pass the latitude and longitude from the selectedLocation object
    widget.onSelectPlace(selectedLocation.latitude, selectedLocation.longitude);
    // Print the latitude of the selectedLocation object to the console for debugging purposes
    print(selectedLocation.latitude);
  }

  // Override the build method to return a widget tree for the LocationInput widget
  @override
  Widget build(BuildContext context) {
    // Return a Column widget, which displays its children in a vertical direction
    return Column(
      // Set the children argument to a list of widgets
      children: [
        // Add a Container widget, which displays the static map image or a text placeholder
        Container(
          // Set the height argument to 170, which defines the vertical extent of the container
          height: 170,
          // Set the width argument to double.infinity, which makes the container take the maximum available width
          width: double.infinity,
          // Set the alignment argument to Alignment.center, which centers the child widget
          alignment: Alignment.center,
          // Set the decoration argument to a BoxDecoration, which defines the background and border of the container
          decoration: BoxDecoration(
              // Set the border argument to a Border.all, which creates a uniform border with the given width and color
              border: Border.all(
            width: 1,
            color: Colors.grey,
          )),
          // Set the child argument to a conditional expression, which displays an Image widget if the _previewImageUrl is not empty, or a Text widget otherwise
          child: _previewImageUrl.isEmpty
              ? const Text(
                  'no location chosen',
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  // Set the image argument to the _previewImageUrl, which displays the static map image
                  _previewImageUrl,
                  // Set the fit argument to BoxFit.cover, which scales and crops the image to fill the container
                  fit: BoxFit.cover,
                  // Set the width argument to double.infinity, which makes the image take the maximum available width
                  width: double.infinity,
                ),
        ),
        // Add a Row widget, which displays its children in a horizontal direction
        Row(
          // Set the mainAxisAlignment argument to MainAxisAlignment.center, which centers the children widgets horizontally
          mainAxisAlignment: MainAxisAlignment.center,
          // Set the children argument to a list of widgets
          children: [
            // Add a TextButton widget, which displays an icon and a label that can be pressed to get the current user location
            TextButton.icon(
              // Set the onPressed argument to the _getCurrentUserLocation method, which is called when the button is pressed
              onPressed: _getCurrentUserLocation,
              // Set the icon argument to a const Icon widget, which displays an icon of a location pin
              icon: const Icon(Icons.location_on),
              // Set the label argument to a const Text widget, which displays the text 'Current location'
              label: const Text(
                'Current location',
                // Set the style argument to a TextStyle, which defines the appearance of the text
                style: TextStyle(
                  // Set the color argument to Colors.indigo, which is a predefined color
                  color: Colors.indigo,
                ),
              ),
            ),
            // Add a TextButton widget, which displays an icon and a label that can be pressed to select a location on a map
            TextButton.icon(
              // Set the onPressed argument to the _selectOnMap method, which is called when the button is pressed
              onPressed: _selectOnMap,
              // Set the icon argument to a const Icon widget, which displays an icon of a map
              icon: const Icon(Icons.map),
              // Set the label argument to a const Text widget, which displays the text 'Select On Map'
              label: const Text(
                'Select On Map',
                // Set the style argument to a TextStyle, which defines the appearance of the text
                style: TextStyle(
                  // Set the color argument to Colors.indigo, which is a predefined color
                  color: Colors.indigo,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
