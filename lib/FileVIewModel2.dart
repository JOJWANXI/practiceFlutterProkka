import 'package:flutter/foundation.dart';
import 'package:try_prokka1/fileModel2.dart';

class FileViewModel extends ChangeNotifier {
  final FileModel _fileModel;

  FileViewModel(this._fileModel);

  String get fileName => _fileModel.fileName;
  String get fileContent => _fileModel.fileContent;
  // other getters...

  void selectFile(/* parameters */) {
    _fileModel.selectFile(/* parameters */);
    notifyListeners();
  }

  void readFile(/* parameters */) {
    _fileModel.readFile(/* parameters */);
    notifyListeners();
  }

  void writeFile(/* parameters */) {
    _fileModel.writeFile(/* parameters */);
    notifyListeners();
  }

// other methods...
}
