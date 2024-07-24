import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';

bool formatMimeTypeFile(String path) {
  final mimeType = lookupMimeType(path);
  if (mimeType == 'image/png' ||
      mimeType == 'image/jpeg' ||
      mimeType == 'image/jpg' ||
      mimeType == 'image/gif' ||
      mimeType == 'application/pdf') {
    return true;
  } else {
    return false;
  }
}

double getFilesSizeInMB({required XFile input, required int decimals}) {
  File file = File(input.path);
  int sizeInBytes = file.lengthSync();
  double sizeInMb =
      double.parse((sizeInBytes / (1024 * 1024)).toStringAsFixed(decimals));
  return sizeInMb;
}
