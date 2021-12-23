import 'package:flutter/material.dart';
import 'notes.dart';

final List<String> noteDescription = [];
final List<String> noteHeading = [];
TextEditingController noteHeadingController = new TextEditingController();
TextEditingController noteDescriptionController = new TextEditingController();
FocusNode textSecondFocusNode = new FocusNode();

int notesHeaderMaxLenth = 25;
int notesDescriptionMaxLines = 10;
int notesDescriptionMaxLenth = "" as int;
String deletedNoteHeading = "";
String deletedNoteDescription = "";

List<Color> noteColor = [
  Colors.pink,
  Colors.green,
  Colors.blue,
  Colors.orange,
  Colors.indigo,
  Colors.red,
  Colors.yellow,
  Colors.brown,
  Colors.teal,
  Colors.purple,
];
List<Color> noteMarginColor = [
  Colors.pink,
  Colors.green,
  Colors.blue,
  Colors.orange,
  Colors.indigo,
  Colors.red,
  Colors.yellow,
  Colors.brown,
  Colors.teal,
  Colors.purple,
];
