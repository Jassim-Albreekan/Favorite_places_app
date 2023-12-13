// Import the Flutter Material library, which provides widgets and themes for building UIs
import 'package:flutter/material.dart';
// Import the great_places provider, which contains the logic and data for managing great places
import 'package:great_places/providers/great_places.dart';
// Import the screens for adding, viewing, and listing great places
import 'package:great_places/screens/add_place_screen.dart';
import 'package:great_places/screens/places_detail_screen.dart';
import 'package:great_places/screens/places_list_screen.dart';
// Import the provider package, which allows state management using the ChangeNotifierProvider widget
import 'package:provider/provider.dart';

// Define the main function, which is the entry point of the app
void main() => runApp(MyApp());

// Define the MyApp class, which is a StatelessWidget that returns the root widget of the app
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Return a ChangeNotifierProvider widget, which provides an instance of GreatPlaces to the widget tree
    return ChangeNotifierProvider.value(
      // Use the value constructor to pass an existing instance of GreatPlaces
      value: GreatPlaces(),
      // Use the child argument to pass a MaterialApp widget, which configures the app's title, theme, and routes
      child: MaterialApp(
          // Set the title of the app, which is used by the device to identify the app
          title: 'Great Places',
          // Set the theme of the app, which defines the colors and fonts for the widgets
          theme: ThemeData(
            // Set the primarySwatch to Colors.indigo, which is a predefined color palette
            primarySwatch: Colors.indigo,
            // Set the accentColor to Colors.amber, which is a secondary color for the app
            accentColor: Colors.amber,
          ),
          // Set the home argument to PlacesListScreen, which is the default screen of the app
          home: PlacesListScreen(),
          // Set the routes argument to a map of named routes, which allows navigation to different screens
          routes: {
            // Use the routName static property of each screen class as the key, and the screen constructor as the value
            AddPlaceScreen.routName: (context) => AddPlaceScreen(),
            PlaceDetailScreen.routName: (context) => const PlaceDetailScreen(),
          }),
    );
  }
}
