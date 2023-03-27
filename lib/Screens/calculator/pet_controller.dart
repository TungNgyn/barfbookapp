import 'package:flutter/material.dart';

class Pet {
  const Pet(
      {this.id = 0,
      required this.owner,
      required this.name,
      this.breed = 'keine Angabe',
      this.age = 0,
      this.weight = 0,
      this.ration = 3,
      this.gender = 'rüde'});

  final int id;
  final String owner;
  final String name;
  final String breed;
  final int age;
  final int weight;
  final String gender;
  final double ration;
}

class PetTextField extends StatefulWidget {
  final int maxLines;
  final String label;
  final String text;
  final TextEditingController controller;

  const PetTextField(
      {super.key,
      this.maxLines = 1,
      required this.label,
      required this.text,
      required this.controller});

  @override
  State<StatefulWidget> createState() => _PetTextFieldState();
}

class _PetTextFieldState extends State<PetTextField> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.text);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text(widget.label,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ),
        SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
          maxLines: widget.maxLines,
        )
      ],
    );
  }
}
