import 'dart:io';
import 'package:file_picker/file_picker.dart';

class FileModel{
  //late: delay initialization of a variable until it's actually used
  //non-nullable variable: initialize later
  //variable before it has a value: LateInitializationError
  //file won't be assigned a value until selectFile method is called
  late File file;
  String filePath = '';
  String fileName = '';
  String fileContent = '';

  // Method to select a file
  Future<void> selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result != null) {
      try {
        filePath = result.files.single.path!;
        file = File(filePath);
        fileContent = await file.readAsString();
        fileName = result.files.single.name;
      } catch (e) {
        throw Exception('Failed to read file: $e');
      }
    } else {
      throw Exception('No file selected');
    }
  }

  // Method to read the file
  Future<void> readFile() async {
    try {
      fileContent = await file.readAsString();
    } catch (e) {
      throw Exception('Failed to read file: $e');
    }
  }

  // Method to write to the file
  Future<void> writeFile(String content) async {
    try {
      await file.writeAsString(content);
      fileContent = content;
    } catch (e) {
      throw Exception('Failed to write file: $e');
    }
  }

}
