import 'package:flutter/foundation.dart';
import 'fileModel.dart';

class FileViewModel extends ChangeNotifier {
  //UI updates are triggered by calling 'notifyListeners()'
  final FileModel fileModel;

  FileViewModel(this.fileModel);

  String get fileName => fileModel.fileName;
  String get fileContent => fileModel.fileContent;

  Future<void> selectFile() async {
    try {
      await fileModel.selectFile();
      notifyListeners();
    } catch (e) {
      "select error";
    }
  }

  Future<void> readFile() async {
    try {
      await fileModel.readFile();
      notifyListeners();
    } catch (e) {
      "read error";
    }
  }

  Future<void> writeFile(String content) async {
    try {
      await fileModel.writeFile(content);
      notifyListeners();
    } catch (e) {
      "write error";
    }
  }
}

