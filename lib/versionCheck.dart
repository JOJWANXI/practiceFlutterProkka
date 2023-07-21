import 'dart:io';
import 'package:flutter/material.dart';

// this version checks now is local and based on the conda environment
class ProkkaVersion extends StatefulWidget {
  ProkkaVersion({Key? key}) : super(key: key);

  @override
  _ProkkaVersionState createState() => _ProkkaVersionState();
}

class _ProkkaVersionState extends State<ProkkaVersion> {
  String _output = 'Not checked yet';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Prokka version: $_output',
        ),
        ElevatedButton(
          onPressed: _checkProkkaVersion,
          child: Text('Check Prokka version'),
        ),
      ],
    );
  }

  void _checkProkkaVersion() async {
    try {
      final result = await Process.run('/home/jianing/anaconda3/envs/prokka/bin/prokka', ['--version'], environment: {'PATH': '/home/jianing/anaconda3/envs/prokka/bin:${Platform.environment['PATH']}'});
      setState(() {
        _output = result.stdout.toString() + result.stderr.toString();
      });
    } catch (e) {
      setState(() {
        _output = 'Error: Prokka not found. Please install Prokka.';
      });
    }
  }


}
