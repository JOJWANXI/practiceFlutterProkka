import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';
import 'dart:io'; // access the 'File' Class for non-web application

void main() {
  runApp(MyApp());
}

// create app-wide state
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // widget -- root of the application
  @override
  Widget build(BuildContext context) {
    //ChangeNotifierProvider: state is created and provided to the whole app
    return ChangeNotifierProvider(
      //alow any widge--get hold of the state
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

//MyAppState: defines the data the app needs to function
//extendsChangeNotifier: notify others about its own changes
class MyAppState extends ChangeNotifier {

  notifyListeners();
}

//some state is only relevant to a single widget
class MyHomePage extends StatefulWidget {
  @override
  //IDE crates a new class: _MyHomePageState()
  State<MyHomePage> createState() => _MyHomePageState();
}

//_MyHomePageState() extends State -- manage own values
class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = FilePickerWidget();
        break;
      case 1:
        page = Placeholder();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Prokka GUI'),),
        body: Row(
          children: [
            SafeArea(
                child: NavigationRail(
                  extended: false,
                  destinations: [
                    NavigationRailDestination(
                        icon: Icon(Icons.file_upload),
                        label: Text('upload')
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.settings),
                      label: Text('Settings'),
                    ),
                  ],
                  selectedIndex: selectedIndex,
                  onDestinationSelected: (value){
                    setState(() {
                      selectedIndex = value;
                    });
                  },
                )
            ),
            Expanded(
                child: Container(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  child: page,
                )
            ),
          ],

        )
      )
    );
  }
}


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


