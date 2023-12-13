// Import the dart:io library, which provides file and directory operations
import 'dart:io';

// Define the PlaceLocation class, which is a const class that represents the location of a place
class PlaceLocation {
  // Define the final double fields named latitude and longitude, which store the geographic coordinates of the location
  final double latitude, longitude;
  // Define the final String field named address, which stores the address of the location
  final String address;

  // Define a const constructor that takes the latitude, longitude, and address as required named arguments and assigns them to the corresponding fields
  const PlaceLocation({
    required this.latitude,
    required this.longitude,
    required this.address,
  });
}

// Define the Place class, which is a class that represents a place
class Place {
  // Define the final String fields named id and title, which store the unique identifier and the name of the place
  final String id, title;
  // Define the final PlaceLocation field named location, which stores the location of the place
  final PlaceLocation location;
  // Define the final File field named image, which stores the image file of the place
  final File image;

  // Define a constructor that takes the id, title, image, and location as required named arguments and assigns them to the corresponding fields
  Place({
    required this.id,
    required this.title,
    required this.image,
    required this.location,
  });
}
