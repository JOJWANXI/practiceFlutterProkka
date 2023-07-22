import 'package:flutter/foundation.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:try_prokka1/executeProkka.dart';

class FileViewModel extends ChangeNotifier {
  // State
  String? _selectedFilePath;
  String? _selectedFileName;
  String? _fileContent;
  String? _prokkaOutput;

  // Dependencies
  ExecuteProkka _prokkaService;

  FileViewModel(this._prokkaService);

  // Exposed properties for the UI to bind to
  String? get selectedFileName => _selectedFileName;
  String? get fileContent => _fileContent;
  String? get prokkaOutput => _prokkaOutput;

  // Commands
  Future<void> selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.any);

    if(result != null) {
      _selectedFilePath = result.files.single.path;
      _selectedFileName = result.files.single.name;
      _fileContent = await File(_selectedFilePath!).readAsString();
      notifyListeners();
    }
  }

  Future<void> runProkka() async {
    if(_selectedFilePath != null) {
      _prokkaOutput = await _prokkaService.runProkka(_selectedFilePath!);
      notifyListeners();
    }
  }
}
