import 'package:flutter/foundation.dart';

Future<void> sharePng(Uint8List bytes, {String? text}) async {
  if (kDebugMode) {
    print('sharePng: Метод недоступен на Web');
  }
}