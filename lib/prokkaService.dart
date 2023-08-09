import 'dart:io';
import 'package:try_prokka1/config.dart'; // dart:io package's Process class
//locustag, prefix
class ProkkaService {
  Future<String> executeCommand(List<String> arguments) async {
    try {
      final result = await Process.run(
          PathConfig.path,
          arguments,
          environment: {'PATH': PathConfig.environmentPath});
      return result.stdout.toString() + result.stderr.toString();
    } catch (e) {
      return 'Error: Prokka not found. Please install Prokka.';
    }
  }
  //prob this is not necessary or just passing it in the widget
  Future<String> checkVersion() async {
    return await executeCommand(['--version']);
  }

  Future<String> runWithKingdom(String kingdom, String filePath) async {
    return await executeCommand(['--kingdom', kingdom, filePath]);
  }


}

