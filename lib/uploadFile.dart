import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io'; // access the 'File' Class for non-web application


class FilePickerWidget extends StatefulWidget{
  @override
  State<FilePickerWidget> createState() => _FilePickerWidgetState();
}

class _FilePickerWidgetState extends State<FilePickerWidget> {
  @override
  Widget build(BuildContext context) {
    String _fileContent = '';
    String _fileName = '';

    return Column(
      children: <Widget>[
        ElevatedButton(
          child: Text( 'Select FASTA file'),
          onPressed: () async{
            // FilePicker.platform.pickFiles: open native file picker
            // await -- asynchronous
            // result value: null / picked file
            FilePickerResult? result = await FilePicker.platform.pickFiles(
                type: FileType.custom,
                //target file format: FASTA files
                allowedExtensions: ['fasta', 'fa']
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
        )
      ],
    );
  }
}

class ContentPage {
  final String content;

  ContentPage(this.content);

  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('File Content'),),
      body: SingleChildScrollView(child: Text(content),),
    );
  }

}