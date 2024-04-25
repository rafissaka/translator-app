import 'package:flutter/material.dart';

class ColorsUsed {
  static final Color color = Colors.grey.shade200;
  static final Color buttoncolor = Colors.grey.shade200;
  static final Color cardcolor = Colors.grey.shade200;
  static final Color appbarbackgroundColor = Colors.grey.shade200;
  static final Color bottomcolor = Colors.grey.shade400;
  static final Color dropdowncolor = Colors.grey.shade200;
  static final Color textcolor = Colors.deepPurpleAccent.shade700;
  static const Color iconcolor = Colors.deepPurple;
}

// ignore: camel_case_types
class iconUsed {
  static final items = [
     const Icon(
      Icons.camera,
      color: ColorsUsed.iconcolor,
    ),
     const Icon(Icons.text_fields_rounded, color: ColorsUsed.iconcolor),
    const Icon(
      Icons.mic_sharp,
      color: ColorsUsed.iconcolor,
    ),
  ];
}
