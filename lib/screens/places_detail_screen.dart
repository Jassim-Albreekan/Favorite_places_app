// Import the Flutter Material library, which provides widgets and themes for building UIs
import 'package:flutter/material.dart';
// Import the great_places provider, which contains the logic and data for managing great places
import 'package:great_places/providers/great_places.dart';
// Import the provider package, which allows state management using the Provider widget
import 'package:provider/provider.dart';
// Import the maps_screen.dart file, which contains the MapsScreen widget for displaying a map
import 'package:great_places/screens/maps_screen.dart';

// Define the PlaceDetailScreen class, which is a StatelessWidget that displays the details of a selected place
class PlaceDetailScreen extends StatelessWidget {
  // Define a constructor that takes key as an optional argument and passes it to the super constructor
  const PlaceDetailScreen({Key? key}) : super(key: key);

  // Define a static const field named routName, which stores the name of the route for this screen
  static const routName = '/place-detail';

  // Override the build method to return a widget tree for the PlaceDetailScreen widget
  @override
  Widget build(BuildContext context) {
    // Get the id of the selected place from the ModalRoute settings arguments
    final id = ModalRoute.of(context)!.settings.arguments;
    // Get the selected place from the Provider of GreatPlaces with the given id
    final selectedPlace = Provider.of<GreatPlaces>(context, listen: false)
        .findById(id.toString());
    // Return a Scaffold widget, which provides a basic app structure with an app bar and a body
    return Scaffold(
      // Set the appBar argument to an AppBar widget, which displays the title of the selected place
      appBar: AppBar(
        title: Text(selectedPlace.title),
      ),
      // Set the body argument to a Column widget, which displays its children in a vertical direction
      body: Column(
        // Set the children argument to a list of widgets
        children: [
          // Add a Container widget, which displays the image of the selected place
          Container(
            // Set the height argument to 250, which defines the vertical extent of the container
            height: 250,
            // Set the width argument to double.infinity, which makes the container take the maximum available width
            width: double.infinity,
            // Set the child argument to an Image widget, which displays the image file of the selected place
            child: Image.file(
              // Set the image argument to the selectedPlace.image file, which displays the selected image
              selectedPlace.image,
              // Set the fit argument to BoxFit.cover, which scales and crops the image to fill the container
              fit: BoxFit.cover,
              // Set the width argument to double.infinity, which makes the image take the maximum available width
              width: double.infinity,
            ),
          ),
          // Add a SizedBox widget, which creates an empty space with a given height
          const SizedBox(
            height: 10,
          ),
          // Add a Text widget, which displays the address of the selected place
          Text(
            // Set the text argument to the selectedPlace.location.address, which displays the selected address
            selectedPlace.location.address,
            // Set the textAlign argument to TextAlign.center, which centers the text horizontally
            textAlign: TextAlign.center,
            // Set the style argument to a const TextStyle, which defines the appearance of the text
            style: const TextStyle(
              // Set the fontSize argument to 20, which defines the size of the text
              fontSize: 20,
              // Set the color argument to Colors.grey, which is a predefined color
              color: Colors.grey,
            ),
          ),
          // Add a TextButton widget, which displays a text that can be pressed to view the selected place on a map
          TextButton(
            // Set the onPressed argument to a function that pushes a MaterialPageRoute to the Navigator
            // The MaterialPageRoute takes a MapsScreen widget as the builder argument, and sets the initialLocation argument to the selectedPlace.location
            // The MaterialPageRoute also sets the fullscreenDialog argument to true, which means that the MapsScreen widget will be displayed as a modal dialog
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (context) => MapsScreen(
                        initialLocation: selectedPlace.location,
                        // Set the isSelected argument to false, which means that the MapsScreen widget will not allow the user to select a location
                        isSelected: false,
                      )));
            },
            // Set the child argument to a const Text widget, which displays the text 'View On Map'
            child: const Text('View On Map'),
            // Set the style argument to a ButtonStyle, which defines the appearance of the button
            style: ButtonStyle(
              // Set the foregroundColor argument to a MaterialStateProperty, which defines the color of the text
              foregroundColor: MaterialStateProperty.all(Colors.indigo),
            ),
          ),
        ],
      ),
    );
  }
}
