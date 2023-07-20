import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:try_prokka1/annotationMode.dart';
import 'fileModel.dart';

// !!!!! file path, fileName
// these prob should be the appState
// refactor the structure
class FilePickerWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ElevatedButton(
          child: Text( 'Select file'),
          onPressed: ()async{
            try{
              await context.read<FileModel>().selectFile();
            }catch(e){
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Failed to read file: $e'),)
              ); } },
        ),
        FileNameDisplay(),
        ElevatedButton(
            child: Text('Show all the content'),
            onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ContentPage(),
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

class FileNameDisplay extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final fileName = context.watch<FileModel>().fileName;
    return Text('Selected file: $fileName');
  }
}

class ContentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    final fileContent = context.watch<FileModel>().fileContent;
    return Scaffold(
      appBar: AppBar(title: Text('File Content'),),
      body: SingleChildScrollView(child: Text(fileContent),),
    );
  }
}