import 'dart:io';
import 'package:flutter/services.dart';

import 'apply_filter_params.dart';
import 'filter_manager.dart';

void applyFilter(ApplyFilterParams applyFilterParams) async {
  BackgroundIsolateBinaryMessenger.ensureInitialized(applyFilterParams.rootIsolateToken);
  File filteredImageFile = await FilterManager.applyFilter(applyFilterParams);
  applyFilterParams.sendPort.send(filteredImageFile);
}