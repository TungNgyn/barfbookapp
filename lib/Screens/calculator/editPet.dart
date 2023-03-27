import 'package:Barfbook/Screens/calculator/pet_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenEditPet extends StatefulWidget {
  const ScreenEditPet({required this.pet});
  final Pet pet;

  @override
  State<ScreenEditPet> createState() => _ScreenEditPetState();
}

class _ScreenEditPetState extends State<ScreenEditPet> {
  late RxDouble _rationController;
  late TextEditingController _weightController;

  String? _genderController;
  @override
  void initState() {
    _rationController = widget.pet.ration.obs;
    _weightController.value = TextEditingValue(text: '${widget.pet.weight}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.pet.name}"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            CircleAvatar(
              radius: 66,
              child: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.surface,
                radius: 64,
                child: FlutterLogo(
                  size: 64,
                ),
              ),
            ),
            SizedBox(height: 24),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PetTextField(
                  label: 'Name',
                  text: widget.pet.name,
                  controller: _weightController,
                ),
                SizedBox(height: 24),
                PetTextField(
                  label: 'Alter (Jahre)',
                  text: '${widget.pet.age}',
                  controller: _weightController,
                ),
                SizedBox(height: 24),
                PetTextField(
                    label: 'Gewicht (Gramm)',
                    text: '${widget.pet.weight}',
                    controller: _weightController),
                SizedBox(height: 24),
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text('Tägliche Ration',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ),
                Slider(
                  value: _rationController.value,
                  min: 1,
                  max: 5,
                  divisions: 8,
                  onChanged: (double value) {
                    setState(() {
                      _rationController.value = value;
                    });
                  },
                ),
                Center(
                  child: Obx(() {
                    return Column(children: [
                      Text(
                        '${_rationController.toStringAsFixed(1)}%',
                        style: TextStyle(
                            fontSize: 21, fontWeight: FontWeight.bold),
                      ),
                      Text(
                          "Entspricht ${double.parse(_weightController.text) * double.parse(_rationController.toStringAsFixed(1)) ~/ 100} Gramm")
                    ]);
                  }),
                ),
              ],
            ),
            SizedBox(height: 24),
            Padding(
              padding: EdgeInsets.only(left: 20, bottom: 4),
              child: Text('Geschlecht',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ),
            DropdownButtonFormField(
                value: widget.pet.gender,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12))),
                items: ['Rüde', 'Hündin', 'keine Angabe']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _genderController = newValue;
                  });
                }),
            SizedBox(height: 48),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 48),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Beschreibung',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  SizedBox(height: 16),
                  Text('${widget.pet.breed}')
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
