// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ScanButton extends StatelessWidget {
  const ScanButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      onPressed: () {},
      child: Icon(Icons.filter_center_focus),
    );
  }
}
