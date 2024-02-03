import 'dart:io';

import 'apply_filter_params.dart';
import 'filter_manager.dart';

void applyFilter(ApplyFilterParams applyFilterParams) async {
  File filteredImageFile = await FilterManager.applyFilter(applyFilterParams);
  applyFilterParams.sendPort.send(filteredImageFile);
}