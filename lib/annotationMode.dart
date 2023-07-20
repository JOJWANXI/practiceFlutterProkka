import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class annotationModeWidget extends StatefulWidget{
  @override
  State<annotationModeWidget> createState() => _annotationModeWidgetState();
}

class _annotationModeWidgetState extends State<annotationModeWidget> {
  String selectedKingdom = 'Bacteria';

  @override
  Widget build(BuildContext context) {

    return DropdownButton<String>(
      //String? value,
      value: selectedKingdom,
      //The items must have distinct value
      items: <String>['Archaea', 'Bacteria', 'Mitochondria', 'Viruses'].map((String value){
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
        },).toList(),
      onChanged:(newValue){
        setState(() {
          selectedKingdom = newValue! ;
        }
        // the logic ?probably: update the state of the widgets ?call prokka
        );},
    );
  }
}