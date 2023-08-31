
# Image Filter Pro

Hi! This is my first package published to help you out!
Image Filter Pro is a Flutter package that provides a convenient way to apply color filters to images with preset filter options. The package is written purely in Dart, so no additional setup for specific platforms is required.


## Features

-   Apply various preset color filters to images.
-   Easily integrate customizable filter UI into your Flutter app.
-   Inspired by popular filter presets found in other image editing apps.


## Installation

Add the following dependency to your `pubspec.yaml` file:

`dependencies:
image_filter_pro: ^0.1.0`

## Usage

Import the package:

    import 'package:flutter/material.dart';
    import 'package:image_filter_pro/image_filter_pro.dart';

Use the `ImageFilterWidget` in your widget tree:

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

You can also provide your own set of presets like this:

    ImageFilterWidget(
        filters: [
    		 // Always add the "default" one
    			  NamedColorFilter(  
    				colorFilterMatrix: [],  
    			    name: "None"),  
    			  NamedColorFilter(  
    				colorFilterMatrix: [  
    					0.8, 0.1, 0.1, 0, 20,  
    					0.1, 0.8, 0.1, 0, 20,  
    					0.1, 0.1, 0.8, 0, 20,  
    					0, 0, 0, 1, 0,  
    				  ],  
    				name: "Vintage"),  
    			  NamedColorFilter(  
    				colorFilterMatrix: [  
    					1.2, 0.1, 0.1, 0, 10,  
    					0.1, 1, 0.1, 0, 10,  
    					0.1, 0.1, 1, 0, 10,  
    					0, 0, 0, 1, 0,  
    				    ],  
    				 name: 'Mood'),  
    		]
          )

Or if you want to extend:

    ImageFilterWidget(
	   //...the rest of the params
       filters:  NamedColorFilter.defaultFilters()
                  .toList()
                  .addAll([ 
    					    NamedColorFilter(  
    						  colorFilterMatrix: [  
    						     0.8, 0.1, 0.1, 0, 20,  
    						     0.1, 0.8, 0.1, 0, 20,  
    						     0.1, 0.1, 0.8, 0, 20,  
    						     0, 0, 0, 1, 0,  
    						   ],  
    						  name: "Vintage"),  
    						 NamedColorFilter(  
    						   colorFilterMatrix: [  
    						     1.2, 0.1, 0.1, 0, 10,  
    						     0.1, 1, 0.1, 0, 10,  
    						     0.1, 0.1, 1, 0, 10,  
    						     0, 0, 0, 1, 0,  
    						   ],  
    						   name: 'Mood'),  
    					]
            )

By default, the widget will just pop itself when tapping on cancel or apply icons.
It is also possible to trigger callback when tapping in cancel or on apply filter:

    ImageFilterWidget(
    	   //...the rest of the params
    	   onCancel: () => // do something,
    	   onApply: (File? file) => // do something with file
    	   )

## Screenshots

![enter image description here](https://github.com/sharokh1/image_filter_pro/blob/main/example_filter.gif?raw=true)

## License

This package is distributed under the [MIT License](https://mit-license.org/).
