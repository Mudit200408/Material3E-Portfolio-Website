import 'dart:typed_data';

import 'file_downloader_mobile.dart'
    if (dart.library.html) 'file_downloader_web.dart';

Future<void> downloadAndOpen(String fileName, Uint8List bytes) =>
    downloadAndOpenImpl(fileName, bytes);
