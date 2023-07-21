import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';

class FileModel extends ChangeNotifier {
  String _fileName = '';
  String _fileContent = '';
  String _filePath = '';

  String get fileName => _fileName;
  String get fileContent => _fileContent;
  String get filePath => _filePath;

  Future<void> selectFile() async {
    // FilePicker.platform.pickFiles: open native file picker
    // await -- asynchronous
    // result value: null / picked file
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if(result != null) {
      try {
        _filePath = result.files.single.path!;
        _fileContent = await File(_filePath).readAsString();
        _fileName = result.files.single.name;
        notifyListeners();
      } catch (e) {
        throw Exception('Failed to read file: $e');
      }
    } else {
      throw Exception('No file selected');
    }
  }

}
