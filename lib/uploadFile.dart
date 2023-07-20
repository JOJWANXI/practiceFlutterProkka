import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

import 'package:try_prokka1/annotationMode.dart';


class FilePickerWidget extends StatefulWidget{
  @override
  State<FilePickerWidget> createState() => _FilePickerWidgetState();
}

class _FilePickerWidgetState extends State<FilePickerWidget> {
  String _fileContent = '';
  String _fileName = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ElevatedButton(
          child: Text( 'Select file'),
          onPressed: () async{
            // FilePicker.platform.pickFiles: open native file picker
            // await -- asynchronous
            // result value: null / picked file
            FilePickerResult? result = await FilePicker.platform.pickFiles(
                type: FileType.any,
              //prob change later to custom the mainly format is fasta, Genbank
            );

            if(result != null){
              try{
                String? filePath = result.files.single.path;

                String fileConetent = await File(filePath!).readAsString();
                setState(() {
                  // tells the Flutter framework that something has changed in this State
                  // rerun the build method --display the updated values
                  _fileContent = fileConetent;
                  _fileName = result.files.single.name;
                });
              }catch(e){
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to read file: $e'),
                    ));
              }
            } else{
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('failed to get file path')),);
            }
          },
        ),
        Text('Selected file: $_fileName'),
        ElevatedButton(
            child: Text('Show all the content'),
            onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ContentPage(_fileContent),
                    ),
                );
            },
        ),
        ElevatedButton(
          child: Text('Select Annotation mode (default: Bacteria)'),
          // onPressed: expected a Void function
          onPressed: (){
            showDialog(
                context: context,
                builder: (BuildContext context){
                  return AlertDialog(
                    content: annotationModeWidget(),
                  );
                },);
          },
        )
      ],
    );
  }
}

class ContentPage extends StatelessWidget {
  final String content;

  ContentPage(this.content);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('File Content'),),
      body: SingleChildScrollView(child: Text(content),),
    );
  }

}