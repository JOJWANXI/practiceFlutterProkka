import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:try_prokka1/annotationMode.dart';
import 'package:try_prokka1/fileViewModel.dart';

import 'prokkaService.dart';

class fileView extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ElevatedButton(
          child: Text( 'Select file'),
          onPressed: ()async{
            try{
              //interact with FileViewModel
              await context.read<FileViewModel>().selectFile();
            }catch(e){
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Failed to read file: $e'),)
              ); }
          },
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
          child: Consumer<ModeModel>(
            //builder is called--the modeModel changes
            builder: (context, modeModel, child){
              return Text('Select Annotation mode ('
                  '${modeModel.selectedMode})');
            },
          ),
          // onPressed: expected a Void function
          onPressed: (){
            showDialog(
                context: context,
                builder: (BuildContext context){
                  return AlertDialog(
                    content: AnnotationModeWidget(),
                  );},
            );
          },
        ),
        ElevatedButton(
          child: Text('Start Annotation'),
          onPressed: () async {
            var annotationModeModel = Provider.of<ModeModel>(context, listen: false);
            var selectedKingdom = annotationModeModel.selectedMode;
            final ProkkaService prokkaService = ProkkaService();
            final fileViewModel = Provider.of<FileViewModel>(context, listen: false);

            String result = await prokkaService.runWithKingdom(selectedKingdom, fileViewModel.fileModel.filePath);
            // Handle the result as needed
          },
        ),
      ],
    );
  }
}

class FileNameDisplay extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final fileName = context.watch<FileViewModel>().fileName;
    return Text('Selected file: $fileName');
  }
}

class ContentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    final fileContent = context.watch<FileViewModel>().fileContent;
    return Scaffold(
      appBar: AppBar(title: Text('File Content'),),
      body: SingleChildScrollView(child: Text(fileContent),),
    );
  }

}