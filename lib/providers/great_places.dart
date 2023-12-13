// Import the dart:io library, which provides file and directory operations
import 'dart:io';

// Import the flutter foundation library, which provides basic types and utilities for Flutter
import 'package:flutter/foundation.dart';

// Import the place.dart file, which contains the Place and PlaceLocation model classes
import '../models/place.dart';
// Import the db_helper.dart file, which contains the DBHelper class for interacting with the local database
import '../helpers/db_helper.dart';
// Import the location_helper.dart file, which contains the LocationHelper class for getting the address of a location
import 'package:great_places/helpers/location_helper.dart';

// Define the GreatPlaces class, which extends the ChangeNotifier class and provides the logic and data for managing great places
class GreatPlaces with ChangeNotifier {
  // Define a List field named _items, which stores the list of places
  List<Place> _items = [];

  // Define a getter named items, which returns a copy of the _items list
  List<Place> get items {
    return [..._items];
  }

  // Define a method named findById, which takes a String argument named id and returns a Place object with the matching id
  Place findById(String id) {
    // Use the firstWhere method on the _items list to find the place with the given id
    return _items.firstWhere((place) => place.id == id);
  }

  // Define an async method named addPlace, which takes a String argument named pickedTitle, a File argument named pickedImage, and a PlaceLocation argument named pickedLocation
  // This method adds a new place to the _items list and the local database
  Future<void> addPlace(
    String pickedTitle,
    File pickedImage,
    PlaceLocation pickedLocation,
  ) async {
    // Await the result of calling the getPlaceAddress method from the LocationHelper class and pass the pickedLocation latitude and longitude as arguments
    // This method returns a String that contains the address of the given location
    final address = await LocationHelper.getPlaceAddress(
        pickedLocation.latitude, pickedLocation.longitude);
    // Create a new PlaceLocation object named updatedLocation with the same latitude and longitude as the pickedLocation, but with the address from the previous step
    final updatedLocation = PlaceLocation(
      latitude: pickedLocation.latitude,
      longitude: pickedLocation.longitude,
      address: address,
    );
    // Create a new Place object named newPlace with a unique id based on the current date and time, and the pickedTitle, pickedImage, and updatedLocation as the other fields
    final newPlace = Place(
      id: DateTime.now().toString(),
      image: pickedImage,
      title: pickedTitle,
      location: updatedLocation,
    );
    // Add the newPlace object to the _items list
    _items.add(newPlace);
    // Call the notifyListeners method to inform the listeners of the state change
    notifyListeners();
    // Call the insert method from the DBHelper class and pass the table name 'user_places' and a map of the newPlace fields as arguments
    // This method inserts the newPlace data to the local database
    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'loc_lat': newPlace.location.latitude,
      'loc_lng': newPlace.location.longitude,
      'address': newPlace.location.address,
    });
  }

  // Define an async method named fetchAndSetPlaces, which retrieves the places data from the local database and updates the _items list
  Future<void> fetchAndSetPlaces() async {
    // Await the result of calling the getData method from the DBHelper class and pass the table name 'user_places' as an argument
    // This method returns a List of maps that contain the data of the places
    final dataList = await DBHelper.getData('user_places');
    // Assign the result of mapping the dataList to a List of Place objects to the _items list
    // Use the map method on the dataList to iterate over each map and create a new Place object with the map values
    // Use the toList method to convert the result to a List
    _items = dataList
        .map(
          (item) => Place(
            id: item['id'],
            title: item['title'],
            image: File(item['image']),
            location: PlaceLocation(
              address: item['address'],
              latitude: item['loc_lat'],
              longitude: item['loc_lng'],
            ),
          ),
        )
        .toList();
    // Call the notifyListeners method to inform the listeners of the state change
    notifyListeners();
  }
}
