import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

class ImageProcessor {
  static Future<img.Image?> loadImage(File file) async {
    final List<int> bytes = await file.readAsBytes();
    return img.decodeImage(Uint8List.fromList(bytes));
  }

  static Future<File> saveImage(img.Image image, bool shouldCompress, int? compressQuality) async
  {
    image = shouldCompress ? compressImage(image,compressQuality ?? 75) : image;

    final directory = await getTemporaryDirectory();
    final path = "${directory.path}/${generateRandomString()}.png";
    final File file = File(path);
    file.writeAsBytesSync(img.encodePng(image));
    return file;
  }

  static img.Image compressImage(img.Image originalImage, int quality) {
    Uint8List? compressedBytes = img.encodeJpg(originalImage, quality: quality);
    return img.decodeImage(compressedBytes)!;
  }
}

String generateRandomString() {
  final random = Random();
  const availableChars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final randomString = List.generate(4,
          (index) => availableChars[random.nextInt(availableChars.length)]).join();

  return randomString;
}