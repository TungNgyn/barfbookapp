// Screen Suche
import 'package:Barfbook/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class whatsis extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var startState = context.watch<StartState>();

    return Scaffold(
        body: NestedScrollView(
      headerSliverBuilder: (_, __) => [
        SliverAppBar(
          pinned: true,
          expandedHeight: 110,
          toolbarHeight: 60,
          flexibleSpace: SafeArea(
            child: FlexibleSpaceBar(
              centerTitle: true,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 250,
                    child: TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: BorderSide.none),
                          filled: true,
                          hintText: "Suche",
                          hintStyle: TextStyle(fontSize: 15)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
      body: Column(
        children: [
          Card(
            child: Row(
              children: [
                Text("alol"),
                ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("back"))
              ],
            ),
          )
        ],
      ),
    ));
  }
}
