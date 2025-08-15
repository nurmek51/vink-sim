import 'dart:ui' as ui;
import 'package:flex_travel_sim/features/esim_management/widgets/share_qr/qr_share_export.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class QrShareService {

static bool _isSharing = false;

static Future<Uint8List> captureWidgetAsPng(GlobalKey key) async {
  try {
    if (key.currentContext == null) {
      if (kDebugMode) print('captureWidgetAsPng: Виджет с этим ключом ещё не отрисован.');
      return Uint8List(0);
    }

    final renderObject = key.currentContext!.findRenderObject();
    if (renderObject is! RenderRepaintBoundary) {
      if (kDebugMode) print('captureWidgetAsPng: RenderObject не является RenderRepaintBoundary.');
      return Uint8List(0);
    }

    final boundary = renderObject;
    final size = boundary.size;
    if (size.isEmpty) {
      if (kDebugMode) print('captureWidgetAsPng: Размер виджета равен нулю');
      return Uint8List(0);
    }

    final image = await boundary.toImage(pixelRatio: 3.0);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

    if (byteData == null) {
      if (kDebugMode) print('captureWidgetAsPng: Не удалось преобразовать в PNG');
      return Uint8List(0);
    }

    return byteData.buffer.asUint8List();
  } catch (e, st) {
    if (kDebugMode) print('captureWidgetAsPng: Ошибка — $e\n$st');
    return Uint8List(0); 
  }
}



static Future<void> shareWidget(GlobalKey key, {String? text}) async {
    if (_isSharing) {
      if (kDebugMode) print('QR Share: Уже выполняется шаринг');
      return;
    }

    _isSharing = true;

  try {
    if (key.currentContext == null) {
      throw Exception('QR Share: Виджет не найден');
    }

    final pngBytes = await captureWidgetAsPng(key);
    if (pngBytes.isEmpty) {
      throw Exception('QR Share: PNG пустой');
    }

    await sharePng(pngBytes, text: text);
  } catch (e) {
    if (kDebugMode) print('Ошибка при шаринге: $e');
  } finally {
    _isSharing = false;
  }
}


}