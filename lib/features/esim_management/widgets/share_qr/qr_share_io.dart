import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

Future<void> sharePng(Uint8List bytes, {String? text}) async {
  final tempDir = await getTemporaryDirectory();
  final file = File('${tempDir.path}/qr_code.png');
  await file.writeAsBytes(bytes);
  await Share.shareXFiles(
    [XFile(file.path)],
    text: text ?? '',
  );
}
