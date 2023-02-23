import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../main.dart';

class ScreenProfil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var startState = context.watch<StartState>();

    return Scaffold(
      appBar: AppBar(title: Text("allo")),
    );
  }
}
