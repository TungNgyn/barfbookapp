import 'package:flutter/material.dart';

class ScreenLoading extends StatefulWidget {
  @override
  _loadingState createState() => _loadingState();
}

class _loadingState extends State<ScreenLoading> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/Wallpaper.jpeg"),
                    fit: BoxFit.fill))),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Barfbook",
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
              Image(
                image: AssetImage("assets/images/rakete.png"),
                height: 100,
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
