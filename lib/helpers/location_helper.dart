// Import the http package, which provides a convenient way to make HTTP requests
import 'package:http/http.dart' as http;
// Import the dart:convert library, which provides methods to encode and decode JSON data
import 'dart:convert';

// Define a const String field named GOOGLE_API_KEY, which stores the Google Maps API key
// You can get your own API key from the Google Cloud Platform Console
const String GOOGLE_API_KEY = '';

// Define the LocationHelper class, which is a class that provides static methods to get the image and address of a location
class LocationHelper {
  // Define a static method named generateLocationPreviewImage, which takes the latitude and longitude as required named arguments and returns a String
  // This method returns the URL of a static map image that shows the given location with a marker
  static String generateLocationPreviewImage({
    required double latitude,
    required double longitude,
  }) {
    // Return the URL of the Google Maps Static API, which generates the map image
    // The URL has the following parameters:
    // center: the latitude and longitude of the center of the map
    // zoom: the zoom level of the map, from 0 (world) to 21 (building)
    // size: the width and height of the map image in pixels
    // maptype: the type of map to display, such as roadmap, satellite, hybrid, or terrain
    // markers: the location and style of the marker to display on the map
    // key: the Google Maps API key
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=$GOOGLE_API_KEY';
  }

  // Define a static async method named getPlaceAddress, which takes the latitude and longitude as arguments and returns a Future<String>
  // This method returns the formatted address of the given location using the Google Maps Geocoding API
  static Future<String> getPlaceAddress(double lat, double lan) async {
    // Create a Uri object named url, which parses the URL of the Google Maps Geocoding API
    // The URL has the following parameters:
    // address: the latitude and longitude of the location to geocode
    // key: the Google Maps API key
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?address=$lat,$lan&key=$GOOGLE_API_KEY');
    // Await the result of calling the get method from the http package and pass the url as an argument
    // This method returns a Response object that contains the HTTP response data
    final response = await http.get(url);
    // Return the result of decoding the response body as a JSON object and accessing the formatted_address property of the first element in the results array
    // This property contains the human-readable address of the location
    return json.decode(response.body)['results'][0]['formatted_address'];
  }
}
