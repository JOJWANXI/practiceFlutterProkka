import 'dart:io';
import 'package:flutter/material.dart';
import 'package:try_prokka1/config.dart';

// this version checks now is local and based on the conda environment
// later can use this to check whether the user install the prokka and
// const a pop up window to notify the users and guide him
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
      final result = await Process.run(
        //static method should be accessed directly on the class
        //so ProkkaConfig().path this kind of instance can not work
          PathConfig.path,
          ['--version'],
          environment: {'PATH': PathConfig.environmentPath});
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
