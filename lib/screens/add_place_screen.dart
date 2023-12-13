// Import the Flutter Material library, which provides widgets and themes for building UIs
import 'package:flutter/material.dart';
// Import the place.dart file, which contains the Place and PlaceLocation model classes
import 'package:great_places/models/place.dart';
// Import the image_input.dart and location_input.dart files, which contain the ImageInput and LocationInput widgets for selecting an image and a location
import 'package:great_places/widgets/image_input.dart';
import 'package:great_places/widgets/location_input.dart';
// Import the dart:io library, which provides file and directory operations
import 'dart:io';
// Import the provider package, which allows state management using the Provider widget
import 'package:provider/provider.dart';
// Import the great_places provider, which contains the logic and data for managing great places
import 'package:great_places/providers/great_places.dart';

// Define the AddPlaceScreen class, which is a StatefulWidget that allows the user to add a new place
class AddPlaceScreen extends StatefulWidget {
  // Define a constructor that takes key as an optional argument and passes it to the super constructor
  AddPlaceScreen({Key? key}) : super(key: key);

  // Define a static const field named routName, which stores the name of the route for this screen
  static const routName = 'add-place';

  // Override the createState method to return an instance of _AddPlaceScreenState
  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

// Define the _AddPlaceScreenState class, which is the state class for AddPlaceScreen
class _AddPlaceScreenState extends State<AddPlaceScreen> {
  // Define a final TextEditingController field named _titleController, which controls the text of the title input field
  final _titleController = TextEditingController();
  // Define a late File field named _pickedImage, which stores the selected image file
  late File _pickedImage;
  // Define a late PlaceLocation field named _pickedLocation, which stores the selected location
  late PlaceLocation _pickedLocation;

  // Define a void method named _selectImage, which takes a File object as an argument and updates the _pickedImage field
  void _selectImage(File pickedImage) {
    // Assign the pickedImage object to the _pickedImage field
    _pickedImage = pickedImage;
  }

  // Define a void method named _selectPlace, which takes the latitude and longitude as arguments and updates the _pickedLocation field
  void _selectPlace(double lat, double lon) {
    // Create a new PlaceLocation object with the given latitude, longitude, and an empty address, and assign it to the _pickedLocation field
    _pickedLocation = PlaceLocation(latitude: lat, longitude: lon, address: '');
  }

  // Define a void method named _savedPlace, which validates the input fields and adds a new place to the provider
  void _savedPlace() {
    // Check if the _titleController text, the _pickedImage path, or the _pickedLocation string are empty, and return early if so
    if (_titleController.text.isEmpty ||
        _pickedImage.path.isEmpty ||
        _pickedLocation.toString().isEmpty) {
      return;
    } else {
      // Get the instance of GreatPlaces from the Provider with the context and listen set to false
      // Call the addPlace method and pass the _titleController text, the _pickedImage file, and the _pickedLocation object as arguments
      Provider.of<GreatPlaces>(context, listen: false)
          .addPlace(_titleController.text, _pickedImage, _pickedLocation);
      // Pop the current route from the Navigator and return to the previous screen
      Navigator.of(context).pop();
    }
  }

  // Override the build method to return a widget tree for the AddPlaceScreen widget
  @override
  Widget build(BuildContext context) {
    // Return a Scaffold widget, which provides a basic app structure with an app bar and a body
    return Scaffold(
      // Set the appBar argument to an AppBar widget, which displays the title of the screen
      appBar: AppBar(
        title: const Text('add a new place'),
      ),
      // Set the body argument to a Column widget, which displays its children in a vertical direction
      body: Column(
        // Set the crossAxisAlignment argument to CrossAxisAlignment.stretch, which stretches the children widgets horizontally
        crossAxisAlignment: CrossAxisAlignment.stretch,
        // Set the children argument to a list of widgets
        children: [
          // Add an Expanded widget, which expands its child to fill the remaining space
          Expanded(
            // Set the child argument to a SingleChildScrollView widget, which allows scrolling its child widget
            child: SingleChildScrollView(
              // Set the child argument to a Padding widget, which adds some space around its child widget
              child: Padding(
                // Set the padding argument to a const EdgeInsets object, which defines the amount of space in all directions
                padding: const EdgeInsets.all(10.0),
                // Set the child argument to a Column widget, which displays its children in a vertical direction
                child: Column(
                  // Set the children argument to a list of widgets
                  children: [
                    // Add a TextField widget, which allows the user to enter the title of the new place
                    TextField(
                      // Set the decoration argument to a const InputDecoration object, which defines the appearance of the input field
                      decoration: const InputDecoration(
                        // Set the labelText argument to 'title', which displays a hint text above the input field
                        labelText: 'title',
                      ),
                      // Set the controller argument to the _titleController field, which controls the text of the input field
                      controller: _titleController,
                    ),
                    // Add a SizedBox widget, which creates an empty space with a given height
                    const SizedBox(height: 10),
                    // Add an ImageInput widget, which allows the user to select an image from the camera or the gallery
                    // Pass the _selectImage method as an argument, which is used to pass the selected image back to the state
                    ImageInput(_selectImage),
                    // Add a SizedBox widget, which creates an empty space with a given width
                    const SizedBox(
                      width: 10,
                    ),
                    // Add a LocationInput widget, which allows the user to select a location from the map or the current location
                    // Pass the _selectPlace method as an argument, which is used to pass the selected location back to the state
                    LocationInput(_selectPlace),
                  ],
                ),
              ),
            ),
          ),
          // Add a Container widget, which displays the button for saving the new place
          Container(
            // Set the color argument to the secondary color of the theme, which defines the background color of the container
            color: Theme.of(context).colorScheme.secondary,
            // Set the child argument to an ElevatedButton widget, which displays an icon and a label that can be pressed to save the new place
            child: ElevatedButton.icon(
              // Set the onPressed argument to the _savedPlace method, which is called when the button is pressed
              onPressed: _savedPlace,
              // Set the icon argument to a const Icon widget, which displays an icon of a plus sign
              icon: const Icon(Icons.add),
              // Set the label argument to a const Text widget, which displays the text 'add a Place'
              label: const Text('add a Place'),
              // Set the style argument to a ButtonStyle, which defines the appearance of the button
              style: ButtonStyle(
                // Set the shadowColor argument to a MaterialStateProperty, which defines the color of the button's shadow
                shadowColor: MaterialStateProperty.all<Color>(Colors.indigo),
                // Set the elevation argument to a MaterialStateProperty, which defines the elevation of the button
                elevation: MaterialStateProperty.all(0),
                // Set the backgroundColor argument to a MaterialStateProperty, which defines the background color of the button
                backgroundColor:
                    MaterialStateProperty.all(Theme.of(context).accentColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
