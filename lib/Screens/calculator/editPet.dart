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
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _breedController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  late RxDouble _rationController = widget.pet.ration.obs;
  late Rx<TextEditingController> _weightController =
      TextEditingController(text: '${widget.pet.weight}').obs;

  String? _genderController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.pet.name}"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              icon: Icon(Icons.create),
              onPressed: () async {
                // await _updateRecipe();
                // Get.back();
              },
            ),
          )
        ],
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
                CustomTextField(
                  label: 'Name',
                  text: widget.pet.name,
                  controller: _nameController,
                  onChanged: (name) {},
                ),
                SizedBox(height: 24),
                CustomTextField(
                  label: 'Alter (Jahre)',
                  text: '${widget.pet.age}',
                  controller: _ageController,
                  onChanged: (age) {},
                ),
                SizedBox(height: 24),
                CustomTextField(
                    label: 'Rasse',
                    text: widget.pet.breed,
                    controller: _breedController,
                    onChanged: (breed) {}),
                SizedBox(height: 24),
                Padding(
                  padding: EdgeInsets.only(left: 20, bottom: 4),
                  child: Text('Geschlecht',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ),
                SizedBox(height: 8),
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
                SizedBox(height: 24),
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text('Gewicht (Gramm)',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ),
                SizedBox(height: 8),
                Obx(() => TextField(
                      onChanged: (value) {
                        setState(() {});
                      },
                      keyboardType: TextInputType.number,
                      controller: _weightController.value,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                          suffix: Text(
                              "${(double.parse(_weightController.value.text) / 1000).toStringAsFixed(1)}kg")),
                    )),
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
                          "Entspricht ${double.parse(_weightController.value.text) * double.parse(_rationController.toStringAsFixed(1)) ~/ 100} Gramm")
                    ]);
                  }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
