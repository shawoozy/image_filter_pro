import 'package:flutter/material.dart';

@immutable
class ApplyFilterParams {
  final List<double> colorMatrix;
  final double brightness;
  final double contrast;
  final double saturation;
  final List<double> defaultMatrix;

  ApplyFilterParams({
      required this.colorMatrix,
      required this.brightness,
      required this.contrast,
      required this.saturation,
      required this.defaultMatrix});
}
