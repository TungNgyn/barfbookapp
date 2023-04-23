import 'dart:io';

import 'package:Barfbook/Screens/Barfbook/pet_controller.dart';
import 'package:Barfbook/util/Supabase/AuthController.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../home.dart';

class ScreenEditPet extends StatefulWidget {
  const ScreenEditPet({required this.pet});
  final Pet pet;

  @override
  State<ScreenEditPet> createState() => _ScreenEditPetState();
}

class _ScreenEditPetState extends State<ScreenEditPet> {
  late final TextEditingController _nameController =
      TextEditingController(text: widget.pet.name);
  late final TextEditingController _breedController =
      TextEditingController(text: widget.pet.breed);
  late final TextEditingController _ageController =
      TextEditingController(text: '${widget.pet.age}');
  late RxDouble _rationController = widget.pet.ration.obs;
  late Rx<TextEditingController> _weightController =
      TextEditingController(text: '${widget.pet.weight}').obs;

  late String _genderController = widget.pet.gender;
  var avatar;
  var file;
  Future? _future;
  FilePickerResult? result;
  PlatformFile? avatarFile;

  _loadAvatar() async {
    avatar = widget.pet.avatar;
  }

  @override
  void initState() {
    super.initState();
    _future = _loadAvatar();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future,
      builder: (context, snapshot) => Scaffold(
        appBar: AppBar(
          title: Text("${widget.pet.name} bearbeiten"),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                icon: Icon(Icons.create),
                onPressed: () async {
                  _updatePet().then((value) => Get.back());
                },
              ),
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32),
          child: ListView(
            children: [
              Column(
                children: [
                  GestureDetector(
                    onTap: () async {
                      result = await FilePicker.platform
                          .pickFiles(type: FileType.image, withData: true);

                      if (result != null) {
                        try {
                          avatarFile = result!.files.first;
                          Uint8List fileBytes = result!.files.first.bytes!;

                          final tempDir = await getTemporaryDirectory();
                          file = File('${tempDir.path}/${widget.pet.id}');

                          setState(() {
                            avatar = Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: Image.memory(fileBytes).image)),
                            );
                          });
                        } catch (error) {
                          print(error);
                        }
                      }
                    },
                    child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 64,
                        child: avatar),
                  ),
                  SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField(
                        label: 'Name',
                        text: widget.pet.name,
                        controller: _nameController,
                        onChanged: (name) {},
                      ),
                      SizedBox(height: 16),
                      CustomTextField(
                        label: 'Alter (Jahre)',
                        text: '${widget.pet.age}',
                        controller: _ageController,
                        onChanged: (age) {},
                      ),
                      SizedBox(height: 16),
                      CustomTextField(
                          label: 'Rasse',
                          text: widget.pet.breed,
                          controller: _breedController,
                          onChanged: (breed) {}),
                      SizedBox(height: 16),
                      Padding(
                        padding: EdgeInsets.only(left: 20, bottom: 4),
                        child: Text('Geschlecht',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                      ),
                      SizedBox(height: 8),
                      DropdownButtonFormField(
                          value: widget.pet.gender,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12))),
                          items: ['Rüde', 'Hündin', 'keine Angabe']
                              .map((e) =>
                                  DropdownMenuItem(value: e, child: Text(e)))
                              .toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _genderController = newValue!;
                            });
                          }),
                      SizedBox(height: 24),
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text('Gewicht (Gramm)',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
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
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
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
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Center(
                          child: ElevatedButton(
                              onPressed: () {
                                Get.defaultDialog(
                                    title: 'Achtung',
                                    content: Column(
                                      children: [
                                        Text(
                                            "Das Löschen kann nicht rückgängig gemacht werden!"),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            ElevatedButton(
                                                onPressed: () {
                                                  deletePet().whenComplete(() =>
                                                      Get.offAll(() => Home()));
                                                },
                                                child: Text(
                                                  "Bestätigen",
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                )),
                                            ElevatedButton(
                                                onPressed: () {
                                                  Get.back();
                                                },
                                                child: Text("Abbrechen")),
                                          ],
                                        )
                                      ],
                                    ));
                              },
                              child: Text("Hund entfernen")),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> _updatePet() async {
    try {
      if (file != null) {
        final bytes = await rootBundle.load(avatarFile!.path!);
        await file.writeAsBytes(
            bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes));

        await supabase.storage.from('pet').update('${widget.pet.id}', file,
            fileOptions:
                const FileOptions(cacheControl: '3600', upsert: false));
      }
      await supabase.rpc('update_pet', params: {
        'petname': _nameController.text,
        'petbreed': _breedController.text,
        'petage': _ageController.text,
        'petweight': _weightController.value.text,
        'petgender': _genderController,
        'petration': _rationController.value,
        'petid': widget.pet.id
      });
    } catch (error) {
      print(error);
      Get.snackbar("Fehler!", "Etwas hat nicht funktioniert");
    }
  }

  Future deletePet() async {
    try {
      await supabase.from('pet').delete().eq('id', widget.pet.id);
    } catch (error) {
      print(error);
    }
  }
}
