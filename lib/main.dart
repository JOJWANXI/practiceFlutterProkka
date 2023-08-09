import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:try_prokka1/annotationMode.dart';
import 'package:try_prokka1/appBar.dart';
import 'package:try_prokka1/fileMvvms/fileModel.dart';
import 'package:try_prokka1/fileMvvms/fileView.dart';
import 'package:try_prokka1/fileMvvms/fileViewModel.dart';
import 'package:try_prokka1/versionCheck.dart';


void main() {
  runApp(MyApp());
}

// create app-wide state
class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // widget -- root of the application
  @override
  Widget build(BuildContext context) {
    //ChangeNotifierProvider: state is created and provided to the whole app
    return MultiProvider(
        providers:[//alow any widge--get hold of the state
          ChangeNotifierProvider(
              create: (context) => FileViewModel(FileModel())),
          ChangeNotifierProvider(
              create: (context)=> ModeModel()),
        ],

      // prob change this provider into fileView file
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
  @override
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
        page = fileView();
        break;
      case 1:
        page = ProkkaVersion();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    return MaterialApp(
      //LayoutBuilder:change the widget tree depending on how much available space
        home: LayoutBuilder(
          builder: (context, constraints){
            //callback is called every time the constraints change
            return Scaffold(
                appBar: CustomAppBar('Prokka GUI'),
                body: Row(
                  children: [
                    // safeArea wraps around NavigationRail
                    SafeArea(
                        child: NavigationRail(
                          extended: constraints.maxWidth >= 600, //label next to the icons
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
            );
          },
        )
    );
  }
}





