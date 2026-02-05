import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';

Future<XFile?> compressImage(File file) async {
  print("test my data ${file.path.split('/').last}");
  final targetPath = "${file.parent.path}/compressed_${file.path.split('/').last}";

  var result = await FlutterImageCompress.compressAndGetFile(
    file.absolute.path,
    targetPath,
    quality: 70, // 0–100 (lower = more compression)
  );

  return result != null ? XFile(result.path) : null;
}