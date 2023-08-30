import 'dart:io';
import 'package:gems/presentation/feature/add-post/image_processor.dart';

import 'photo_filter.dart';
import 'package:image/image.dart' as img;

class FilterManager {
  Future<File> applyColorFilterToFile(
      File rawFile, List<double> colorMatrix, double brightness, double contrast, double saturation, List<double> defaultMatrix) async {
    final img.Image? image = await ImageProcessor.loadImage(rawFile);

    if (image == null) throw Exception("Failed to decode image");

    // Apply the color filter
    for (int y = 0; y < image.height; y++) {
      for (int x = 0; x < image.width; x++) {
        final img.Pixel pixel = image.getPixel(x, y);

        final num alpha = pixel.a;
        final num red = pixel.r;
        final num green = pixel.g;
        final num blue = pixel.b;

        final newColor = multiplyByColorFilter([red, green, blue, alpha], colorMatrix);

        final color = img.ColorRgba8(newColor[0], newColor[1], newColor[2], newColor[3]);
        image.setPixel(x, y, color);
      }
    }

    if (brightness != midBrightness || contrast != midContrast || saturation != midSaturation) {
      for (int y = 0; y < image.height; y++) {
        for (int x = 0; x < image.width; x++) {
          final img.Pixel pixel = image.getPixel(x, y);

          final num alpha = pixel.a;
          final num red = pixel.r;
          final num green = pixel.g;
          final num blue = pixel.b;

          final newColor = multiplyByColorFilter([red, green, blue, alpha], defaultMatrix);

          final color = img.ColorRgba8(newColor[0], newColor[1], newColor[2], newColor[3]);
          image.setPixel(x, y, color);
        }
      }
    }

    return await ImageProcessor.saveImage(image);
  }

  List<int> multiplyByColorFilter(List<num> color, List<double> matrix) {
    final r = (color[0] * matrix[0] + color[1] * matrix[1] + color[2] * matrix[2] + color[3] * matrix[3] + matrix[4]).clamp(0, 255).toInt();
    final g = (color[0] * matrix[5] + color[1] * matrix[6] + color[2] * matrix[7] + color[3] * matrix[8] + matrix[9]).clamp(0, 255).toInt();
    final b = (color[0] * matrix[10] + color[1] * matrix[11] + color[2] * matrix[12] + color[3] * matrix[13] + matrix[14]).clamp(0, 255).toInt();
    final a = (color[0] * matrix[15] + color[1] * matrix[16] + color[2] * matrix[17] + color[3] * matrix[18] + matrix[19]).clamp(0, 255).toInt();

    return [r, g, b, a];
  }
}
