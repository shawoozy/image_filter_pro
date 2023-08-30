import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_filter_pro/photo_filter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FilteredImageWidget(),
    );
  }
}

class FilteredImageWidget extends StatefulWidget {
  @override
  _FilteredImageWidgetState createState() => _FilteredImageWidgetState();
}

class _FilteredImageWidgetState extends State<FilteredImageWidget> {
  File? image;

  void _showImagePicker() async {
    // Implement your image picker logic here
    // Set the selected image as the imageFile
    // For example:
    // var pickedImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    // setState(() {
    //   imageFile = pickedImage;
    // });

    var updatedImage = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PhotoFilter(
          image: imageFile,
          presets: NamedColorFilter.defaultFilters(),
          cancelIcon: Icons.cancel,
          applyIcon: Icons.check,
          backgroundColor: Colors.black,
          sliderColor: Colors.blue,
          sliderLabelStyle: TextStyle(color: Colors.white),
          bottomButtonsTextStyle: TextStyle(color: Colors.white),
          presetsLabelTextStyle: TextStyle(color: Colors.white),
          applyingTextStyle: TextStyle(color: Colors.white),
        ),
      ),
    );

    if (updatedImage != null) {
      setState(() {
        this.image = updatedImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Filter App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _showImagePicker,
              child: Text('Pick and Filter Image'),
            ),
            if (image != null)
              Image.file(image!),
          ],
        ),
      ),
    );
  }
}
