import 'dart:io';

import 'package:Barfbook/Screens/Barfbook/pet_controller.dart';
import 'package:Barfbook/util/Supabase/AuthController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart'
    show FilteringTextInputFormatter, rootBundle;

class ScreenAddPet extends StatefulWidget {
  @override
  State<ScreenAddPet> createState() => _ScreenAddPetState();
}

class _ScreenAddPetState extends State<ScreenAddPet> {
  final PageController pageController = PageController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _breedController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _weightController =
      TextEditingController(text: '0');
  bool filledInput = false;
  String? _genderController;
  RxDouble _rationController = 3.0.obs;
  int? pageIndex;
  late final dogId;

  @override
  Widget build(BuildContext context) {
    if (_nameController.text.isNotEmpty &
        _ageController.text.isNotEmpty &
        ((pageIndex == 0) | (pageIndex == null))) {
      setState(() {
        filledInput = true;
      });
    } else if (_breedController.text.isNotEmpty &
        _weightController.text.isNotEmpty &
        (pageIndex == 1)) {
      setState(() {
        filledInput = true;
      });
    }
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(),
        body: Column(
          children: [
            Flexible(
              flex: 3,
              child: PageView(
                controller: pageController,
                onPageChanged: _onPageViewChange,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Card(
                          elevation: 10,
                          child: Container(
                              color: Theme.of(context).colorScheme.onPrimary,
                              width: MediaQuery.of(context).size.width * 0.8,
                              height: MediaQuery.of(context).size.height * 0.3,
                              child: Center(
                                  child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Basisinformationen',
                                      style: TextStyle(fontSize: 24),
                                    ),
                                    SizedBox(height: 30),
                                    TextField(
                                      onChanged: (value) {
                                        setState(() {});
                                      },
                                      onSubmitted: (value) {
                                        (filledInput == false)
                                            ? (pageIndex == 2)
                                                ? _addPet().then((value) =>
                                                    _createDogAvatar().then(
                                                        (value) => Get.back()))
                                                : null
                                            : pageController.nextPage(
                                                duration: Duration(seconds: 1),
                                                curve: Curves
                                                    .fastLinearToSlowEaseIn);
                                      },
                                      controller: _nameController,
                                      decoration: InputDecoration(
                                          hintText: "Name",
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12))),
                                    ),
                                    SizedBox(height: 30),
                                    TextField(
                                      onChanged: (value) {
                                        setState(() {});
                                      },
                                      onSubmitted: (value) {
                                        (filledInput == false)
                                            ? (pageIndex == 2)
                                                ? _addPet().then((value) =>
                                                    _createDogAvatar().then(
                                                        (value) => Get.back()))
                                                : null
                                            : pageController.nextPage(
                                                duration: Duration(seconds: 1),
                                                curve: Curves
                                                    .fastLinearToSlowEaseIn);
                                      },
                                      controller: _ageController,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      decoration: InputDecoration(
                                          hintText: "Alter",
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12))),
                                    )
                                  ],
                                ),
                              ))),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Card(
                          elevation: 10,
                          child: Container(
                              color: Theme.of(context).colorScheme.onPrimary,
                              width: MediaQuery.of(context).size.width * 0.8,
                              height: MediaQuery.of(context).size.height * 0.3,
                              child: Center(
                                  child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Basisinformationen',
                                      style: TextStyle(fontSize: 24),
                                    ),
                                    SizedBox(height: 30),
                                    TypeAheadField(
                                      textFieldConfiguration:
                                          TextFieldConfiguration(
                                              decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12))),
                                              controller: _breedController),
                                      suggestionsCallback: (pattern) async {
                                        return await supabase
                                            .from('dog')
                                            .select('*')
                                            .ilike('name', '%$pattern%');
                                      },
                                      itemBuilder: (context, suggestion) {
                                        suggestion as Map;
                                        return ListTile(
                                          title: Row(
                                            children: [
                                              Image.asset(
                                                'assets/icons/dog/${suggestion['avatar']}.png',
                                                width: 32,
                                              ),
                                              Text(
                                                (suggestion)['name'],
                                                style: TextStyle(fontSize: 16),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      noItemsFoundBuilder:
                                          (BuildContext context) {
                                        return Container(
                                          color: Colors.transparent,
                                          height: 0,
                                          width: 0,
                                        );
                                      },
                                      onSuggestionSelected: (suggestion) {
                                        setState(() {
                                          suggestion as Map;
                                          _breedController.text =
                                              suggestion['name'];
                                          print(suggestion);
                                        });
                                      },
                                    ),
                                    TextField(
                                      onChanged: (value) {
                                        setState(() {});
                                      },
                                      onSubmitted: (value) {
                                        (filledInput == false)
                                            ? (pageIndex == 2)
                                                ? _addPet().then((value) =>
                                                    _createDogAvatar().then(
                                                        (value) => Get.back()))
                                                : null
                                            : pageController.nextPage(
                                                duration: Duration(seconds: 1),
                                                curve: Curves
                                                    .fastLinearToSlowEaseIn);
                                      },
                                      controller: _weightController,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      decoration: InputDecoration(
                                          hintText: "Gewicht in Gramm",
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          suffix: Text(
                                              "${(double.parse(_weightController.value.text.isEmpty ? '0' : _weightController.value.text) / 1000).toStringAsFixed(1)}kg")),
                                    ),
                                    DropdownButtonFormField(
                                        decoration: InputDecoration(
                                            label: Text('$_genderController'),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12))),
                                        items: [
                                          'Rüde',
                                          'Hündin',
                                          'keine Angabe'
                                        ]
                                            .map((e) => DropdownMenuItem(
                                                value: e, child: Text(e)))
                                            .toList(),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            _genderController = newValue;
                                          });
                                        })
                                  ],
                                ),
                              ))),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Card(
                          elevation: 10,
                          child: Container(
                              color: Theme.of(context).colorScheme.onPrimary,
                              width: MediaQuery.of(context).size.width * 0.8,
                              height: MediaQuery.of(context).size.height * 0.3,
                              child: Center(
                                  child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  children: [
                                    Text(
                                      "Tägliche Ration",
                                      style: TextStyle(fontSize: 24),
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
                                    Obx(() {
                                      return Column(children: [
                                        Text(
                                          '${_rationController.toStringAsFixed(1)}%',
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        Text(
                                            "entspricht ${double.parse(_weightController.text) * double.parse(_rationController.toStringAsFixed(1)) ~/ 100} Gramm"),
                                        Text(
                                            "empfohlener Energiebedarf: ${((30 * (double.parse(_weightController.text) * double.parse(_rationController.toStringAsFixed(1)) + 70) * 1.8) / 1000 / 3).toStringAsFixed(0)}kcal")
                                      ]);
                                    }),
                                  ],
                                ),
                              ))),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
                flex: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Visibility(
                      maintainSize: true,
                      maintainAnimation: true,
                      maintainState: true,
                      visible:
                          (pageIndex == 0) | (pageIndex == null) ? false : true,
                      child: ElevatedButton(
                          onPressed: (pageIndex == 0) | (pageIndex == null)
                              ? null
                              : () {
                                  pageController.previousPage(
                                      duration: Duration(seconds: 1),
                                      curve: Curves.fastLinearToSlowEaseIn);
                                },
                          child: Text("Zurück")),
                    ),
                    ElevatedButton(
                        onPressed: (filledInput == false)
                            ? (pageIndex == 2)
                                ? () => _addPet().then((value) =>
                                    _createDogAvatar()
                                        .then((value) => Get.back()))
                                : null
                            : () {
                                pageController.nextPage(
                                    duration: Duration(seconds: 1),
                                    curve: Curves.fastLinearToSlowEaseIn);
                              },
                        child: (pageIndex == 2)
                            ? Text('Hinzufügen')
                            : Text("Weiter"))
                  ],
                ))
          ],
        ));
  }

  _onPageViewChange(int page) {
    setState(() {
      filledInput = false;
      pageIndex = page;
    });
  }

  _addPet() async {
    Pet pet = Pet(
        owner: user!.id,
        name: _nameController.text,
        breed: _breedController.text,
        age: int.parse(_ageController.text),
        weight: int.parse(_weightController.text),
        ration: double.parse(_rationController.toStringAsFixed(1)),
        gender: _genderController!,
        avatar: '');
    print(pet.name);
    try {
      await supabase.from('pet').insert({
        'name': _nameController.text,
        'owner': pet.owner,
        'breed': pet.breed,
        'age': pet.age,
        'weight': pet.weight,
        'ration': pet.ration,
        'gender': pet.gender
      });

      dogId = await supabase.from('pet').select('id').match({
        'name': _nameController.text,
        'owner': pet.owner,
        'breed': pet.breed,
        'age': pet.age,
        'weight': pet.weight,
        'ration': pet.ration,
        'gender': pet.gender
      });
    } catch (error) {
      print(error);
    }
    try {
      print(await supabase.from('pet').select('*').eq('owner', user?.id));
    } catch (error) {
      print(error);
    }
  }

  Future _createDogAvatar() async {
    try {
      final bytes = await rootBundle.load('assets/images/defaultDogAvatar.png');
      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/defaultDogAvatar.png');
      await file.writeAsBytes(
          bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes));

      await supabase.storage.from('pet').upload('${dogId}', file);
    } catch (error) {
      print(error);
    }
  }
}
