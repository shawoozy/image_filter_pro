import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';

@immutable
class ApplyFilterParams {
  final File rawFile;
  final List<double> colorMatrix;
  final double brightness;
  final double contrast;
  final double saturation;
  final List<double> defaultMatrix;
  final SendPort sendPort;
  final RootIsolateToken rootIsolateToken;
  final bool shouldCompress;
  final int? compressQuality;

  ApplyFilterParams(
      {required this.shouldCompress,
      this.compressQuality,
      required this.rootIsolateToken,
      required this.sendPort,
      required this.rawFile,
      required this.colorMatrix,
      required this.brightness,
      required this.contrast,
      required this.saturation,
      required this.defaultMatrix});
}
