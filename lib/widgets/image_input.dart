// Import the Flutter Material library, which provides widgets and themes for building UIs
import 'package:flutter/material.dart';
// Import the dart:io library, which provides file and directory operations
import 'dart:io';
// Import the image_picker package, which allows picking images from the camera or gallery
import 'package:image_picker/image_picker.dart';
// Import the path_provider package as sysPath, which allows finding commonly used locations on the file system
import 'package:path_provider/path_provider.dart' as sysPath;
// Import the path package as path, which allows manipulating file paths
import 'package:path/path.dart' as path;

// Define the ImageInput class, which is a StatefulWidget that allows the user to take a picture and display it
class ImageInput extends StatefulWidget {
  // Define a final Function field named onSelectImage, which is passed from the parent widget and is used to pass the selected image back
  final Function onSelectImage;

  // Define a constructor that takes onSelectImage as a required argument and key as an optional argument, and passes them to the super constructor
  ImageInput(this.onSelectImage, {Key? key}) : super(key: key);

  // Override the createState method to return an instance of _ImageInputState
  @override
  _ImageInputState createState() => _ImageInputState();
}

// Define the _ImageInputState class, which is the state class for ImageInput
class _ImageInputState extends State<ImageInput> {
  // Define a late File field named _storedImage, which stores the selected image file
  late File _storedImage = File('');

  // Define an async method named _takePicture, which allows the user to take a picture using the camera and save it to the app directory
  Future<void> _takePicture() async {
    // Create an instance of ImagePicker
    final picker = ImagePicker();
    // Await the result of picking an image from the camera with a maximum width of 600 pixels
    final imageFile = await picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    // If the image file path is empty, return early
    if (imageFile!.path.isEmpty) {
      return;
    }
    // Call setState to update the _storedImage field with the image file
    setState(() {
      _storedImage = File(imageFile.path);
    });
    // Await the app directory path using the path_provider package
    final appDir = await sysPath.getApplicationDocumentsDirectory();
    // Get the file name from the image file path using the path package
    final fileName = path.basename(imageFile.path);
    // Copy the image file to the app directory with the same file name and await the result
    final savedImage =
        await File(imageFile.path).copy('${appDir.path}/$fileName');
    // Call the onSelectImage function from the widget field and pass the saved image as an argument
    widget.onSelectImage(savedImage);
  }

  // Override the build method to return a widget tree for the ImageInput widget
  @override
  Widget build(BuildContext context) {
    // Return a Row widget, which displays its children in a horizontal direction
    return Row(
      // Set the children argument to a list of widgets
      children: [
        // Add a Container widget, which displays the selected image or a text placeholder
        Container(
          // Set the alignment argument to Alignment.center, which centers the child widget
          alignment: Alignment.center,
          // Set the width argument to 180, which defines the horizontal extent of the container
          width: 180,
          // Set the height argument to 150, which defines the vertical extent of the container
          height: 150,
          // Set the decoration argument to a BoxDecoration, which defines the background and border of the container
          decoration: BoxDecoration(
              // Set the border argument to a Border.all, which creates a uniform border with the given width and color
              border: Border.all(
            width: 1,
            color: Colors.grey,
          )),
          // Set the child argument to a conditional expression, which displays an Image widget if the _storedImage path is not empty, or a Text widget otherwise
          child: _storedImage.path.isNotEmpty
              ? Image.file(
                  // Set the image argument to the _storedImage file, which displays the selected image
                  _storedImage,
                  // Set the fit argument to BoxFit.cover, which scales and crops the image to fill the container
                  fit: BoxFit.cover,
                  // Set the width argument to double.infinity, which makes the image take the maximum available width
                  width: double.infinity,
                )
              : const Text(
                  'no image taken', // Set the text argument to 'no image taken', which displays a placeholder text
                  textAlign: TextAlign
                      .center, // Set the textAlign argument to TextAlign.center, which centers the text horizontally
                  style: TextStyle(
                    // Set the style argument to a TextStyle, which defines the appearance of the text
                    fontSize:
                        20, // Set the fontSize argument to 20, which defines the size of the text
                  ),
                ),
        ),
        // Add a SizedBox widget, which creates an empty space with a given width
        const SizedBox(
          width: 10,
        ),
        // Add an Expanded widget, which expands its child to fill the remaining space
        Expanded(
          // Set the child argument to a TextButton widget, which displays an icon and a label that can be pressed
          child: TextButton.icon(
            // Set the icon argument to a const Icon widget, which displays an icon of a camera
            icon: const Icon(Icons.camera),
            // Set the label argument to a const Text widget, which displays the text 'Take a picture'
            label: const Text('Take a picture'),
            // Set the style argument to a ButtonStyle, which defines the appearance of the button
            style: ButtonStyle(
              // Set the foregroundColor argument to a MaterialStateProperty, which defines the color of the icon and label
              foregroundColor:
                  MaterialStateProperty.all(Theme.of(context).primaryColor),
            ),
            // Set the onPressed argument to the _takePicture method, which is called when the button is pressed
            onPressed: _takePicture,
          ),
        ),
      ],
    );
  }
}
