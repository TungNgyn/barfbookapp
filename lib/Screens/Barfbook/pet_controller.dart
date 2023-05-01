import 'package:flutter/material.dart';

// class Pet {
//   const Pet(
//       {this.id = 0,
//       required this.owner,
//       required this.name,
//       this.breed = 'keine Angabe',
//       this.age = 0,
//       this.weight = 0,
//       this.ration = 3,
//       this.gender = 'rüde',
//       required this.avatar});

//   final int id;
//   final String owner;
//   final String name;
//   final String breed;
//   final int age;
//   final int weight;
//   final String gender;
//   final double ration;
//   final avatar;
// }

class CustomTextField extends StatefulWidget {
  final int maxLines;
  final String label;
  final String text;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final bool obscurred;

  const CustomTextField(
      {super.key,
      this.maxLines = 1,
      required this.label,
      required this.text,
      required this.controller,
      required this.onChanged,
      this.obscurred = false});

  @override
  State<StatefulWidget> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
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
          obscureText: widget.obscurred,
          onChanged: (value) => widget.onChanged,
          controller: widget.controller,
          decoration: InputDecoration(
              hintText: widget.text,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
          maxLines: widget.maxLines,
        )
      ],
    );
  }
}
