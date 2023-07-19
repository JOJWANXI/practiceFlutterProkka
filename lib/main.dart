import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:try_prokka1/uploadFile.dart';


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
            appBar: AppBar(
              title: Text('Prokka GUI'),
              actions: <Widget>[
                IconButton(
                  icon: const Icon(Icons.file_upload),
                  tooltip: 'Upload',
                  onPressed: () {
                    /* place upload functionality here */
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.settings),
                  tooltip: 'Settings',
                  onPressed: () {
                    /* place settings functionality here */
                  },
                ),
              ],
            ),
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





