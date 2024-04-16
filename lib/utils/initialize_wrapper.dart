import 'package:flutter/material.dart';

class InitializeWrapper extends StatefulWidget {
  final Function onInit;
  final Widget child;

  const InitializeWrapper({super.key, required this.onInit, required this.child});

  @override
  InitializeWrapperState createState() => InitializeWrapperState();
}

class InitializeWrapperState extends State<InitializeWrapper> {
  @override
  void initState() {
    Future(() {
      widget.onInit();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
