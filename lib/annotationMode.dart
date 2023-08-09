import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:try_prokka1/prokkaService.dart';

class AnnotationModeWidget extends StatefulWidget{
  @override
  State<AnnotationModeWidget> createState() => _AnnotationModeWidgetState();
}

class _AnnotationModeWidgetState extends State<AnnotationModeWidget> {
  final ProkkaService prokkaService = ProkkaService();

  @override
  Widget build(BuildContext context) {
    /*  Provider package: state management
    Provider.of<T> T:AnnotationModeModel object
    context: Provider->nearest provider
    so when data in modeModel changes & notifyListeners()
    then any widget that uses Provider.of<T> will rebuild */
    var annotationModeModel = Provider.of<ModeModel>(context);
    var selectedKingdom = annotationModeModel.selectedMode;

    return DropdownButton<String>(
      value: selectedKingdom,
      items: <String>['Archaea', 'Bacteria', 'Mitochondria', 'Viruses']
          .map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      },).toList(),
      onChanged: (newValue) {
        // Update the value in the model
        annotationModeModel.setSelectedMode(newValue!);
        _executeProkkaWithKingdom(newValue);
      },
    );
  }

  Future<void> _executeProkkaWithKingdom(String kingdom) async {
    String result = await prokkaService.runWithKingdom(kingdom);

  }
}

class ModeModel extends ChangeNotifier {
  String _selectedMode = 'Bacteria';

  String get selectedMode => _selectedMode;

  void setSelectedMode(String mode) {
    _selectedMode = mode;
    notifyListeners();
  }

}