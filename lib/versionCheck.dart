import 'package:flutter/material.dart';
import 'package:try_prokka1/prokkaService.dart';

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
  //instantiate the 'ProkkaService' class--instance
  final ProkkaService prokkaService = ProkkaService();

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

  Future<void> _checkProkkaVersion() async {
    String result = await prokkaService.checkVersion();
    setState(() {
      _output = result;//update the state--trigger widget
    });
  }

}
