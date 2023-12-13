// Import the Flutter Material library, which provides widgets and themes for building UIs
import 'package:flutter/material.dart';
// Import the places_detail_screen.dart file, which contains the PlaceDetailScreen widget for displaying the details of a selected place
import 'package:great_places/screens/places_detail_screen.dart';
// Import the provider package, which allows state management using the Provider widget
import 'package:provider/provider.dart';
// Import the add_place_screen.dart file, which contains the AddPlaceScreen widget for adding a new place
import 'package:great_places/screens/add_place_screen.dart';

// Import the great_places provider, which contains the logic and data for managing great places
import '../providers/great_places.dart';

// Define the PlacesListScreen class, which is a StatelessWidget that displays a list of places
class PlacesListScreen extends StatelessWidget {
  // Define a constructor that takes key as an optional argument and passes it to the super constructor
  PlacesListScreen({Key? key}) : super(key: key);

  // Override the build method to return a widget tree for the PlacesListScreen widget
  @override
  Widget build(BuildContext context) {
    // Return a Scaffold widget, which provides a basic app structure with an app bar and a body
    return Scaffold(
      // Set the appBar argument to an AppBar widget, which displays the title of the screen and an action button for adding a new place
      appBar: AppBar(
        // Set the title argument to a const Text widget, which displays the text 'Your Places'
        title: const Text('Your Places'),
        // Set the actions argument to a list of widgets, which are displayed after the title
        actions: <Widget>[
          // Add an IconButton widget, which displays an icon that can be pressed to navigate to the AddPlaceScreen
          IconButton(
            // Set the icon argument to a const Icon widget, which displays an icon of a plus sign
            icon: const Icon(Icons.add),
            // Set the onPressed argument to a function that pushes the AddPlaceScreen route to the Navigator
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routName);
            },
          ),
        ],
      ),
      // Set the body argument to a FutureBuilder widget, which builds itself based on the latest snapshot of interaction with a Future
      body: FutureBuilder(
        // Set the future argument to the result of calling the fetchAndSetPlaces method from the Provider of GreatPlaces
        // This method returns a Future that fetches the places data from the local database and updates the state
        future: Provider.of<GreatPlaces>(context, listen: false)
            .fetchAndSetPlaces(),
        // Set the builder argument to a function that takes the context and the snapshot as arguments and returns a widget
        builder: (context, snapshot) =>
            // Use a conditional expression to check the connection state of the snapshot
            // If the connection state is waiting, return a Center widget with a CircularProgressIndicator widget as the child
            // This means that the Future is still loading and the UI shows a loading indicator
            snapshot.connectionState == ConnectionState.waiting
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                // If the connection state is not waiting, return a Consumer widget of GreatPlaces
                // This means that the Future is completed and the UI shows the data
                : Consumer<GreatPlaces>(
                    // Set the builder argument to a function that takes the context, the greatPlaces object, and the ch widget as arguments and returns a widget
                    builder: (ctx, greatPlaces, ch) =>
                        // Use a conditional expression to check if the greatPlaces items list is empty
                        // If the list is empty, return a Center widget with the ch widget as the child
                        // This means that there are no places to display and the UI shows a placeholder text
                        greatPlaces.items.isEmpty
                            ? Center(
                                child: ch,
                              )
                            // If the list is not empty, return a ListView widget with a builder constructor
                            // This means that there are places to display and the UI shows a list of tiles
                            : ListView.builder(
                                // Set the itemCount argument to the length of the greatPlaces items list, which defines the number of items in the list
                                itemCount: greatPlaces.items.length,
                                // Set the itemBuilder argument to a function that takes the context and the index as arguments and returns a widget
                                itemBuilder: (ctx, i) =>
                                    // Return a ListTile widget, which displays the image, title, and address of each place
                                    ListTile(
                                  // Set the leading argument to a CircleAvatar widget, which displays a circular image of the place
                                  leading: CircleAvatar(
                                    // Set the backgroundImage argument to a FileImage widget, which displays the image file of the place
                                    backgroundImage: FileImage(
                                      greatPlaces.items[i].image,
                                    ),
                                  ),
                                  // Set the title argument to a Text widget, which displays the title of the place
                                  title: Text(greatPlaces.items[i].title),
                                  // Set the subtitle argument to a Text widget, which displays the address of the place
                                  subtitle: Text(
                                      greatPlaces.items[i].location.address),
                                  // Set the onTap argument to a function that pushes the PlaceDetailScreen route to the Navigator and passes the id of the place as an argument
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                        PlaceDetailScreen.routName,
                                        arguments: greatPlaces.items[i].id);
                                  },
                                ),
                              ),
                    // Set the child argument to a const Center widget, which displays a text widget as the child
                    // This widget is passed to the builder function as the ch argument and is used as a placeholder when the list is empty
                    child: const Center(
                      // Set the child argument to a const Text widget, which displays the text 'Got no places yet, start adding some !'
                      child: Text('Got no places yet, start adding some !'),
                    ),
                  ),
      ),
    );
  }
}
