import 'package:Barfbook/Screens/calculator/pet_controller.dart';
import 'package:Barfbook/util/Supabase/AuthController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenAddPet extends StatefulWidget {
  @override
  State<ScreenAddPet> createState() => _ScreenAddPetState();
}

class _ScreenAddPetState extends State<ScreenAddPet> {
  final PageController pageController = PageController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _breedController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  bool filledInput = false;
  String? _genderController;
  RxDouble _rationController = 3.0.obs;
  int? pageIndex;

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
        appBar: AppBar(),
        body: SafeArea(
          child: Column(
            children: [
              Flexible(
                flex: 4,
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
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                child: Center(
                                    child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Basisinformationen',
                                        style: TextStyle(fontSize: 31),
                                      ),
                                      SizedBox(height: 30),
                                      TextField(
                                        onChanged: (value) {
                                          setState(() {});
                                        },
                                        controller: _nameController,
                                        decoration: InputDecoration(
                                            hintText: "Name",
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide())),
                                      ),
                                      SizedBox(height: 30),
                                      TextField(
                                        onChanged: (value) {
                                          setState(() {});
                                        },
                                        controller: _ageController,
                                        decoration: InputDecoration(
                                            hintText: "Alter",
                                            border: OutlineInputBorder()),
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
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                child: Center(
                                    child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Basisinformationen',
                                        style: TextStyle(fontSize: 31),
                                      ),
                                      SizedBox(height: 30),
                                      TextField(
                                        onChanged: (value) {
                                          setState(() {});
                                        },
                                        controller: _breedController,
                                        decoration: InputDecoration(
                                            hintText: "Hunderasse",
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide())),
                                      ),
                                      TextField(
                                        onChanged: (value) {
                                          setState(() {});
                                        },
                                        controller: _weightController,
                                        decoration: InputDecoration(
                                            hintText: "Gewicht in Gramm",
                                            border: OutlineInputBorder()),
                                      ),
                                      DropdownButtonFormField(
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder()),
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
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
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
                                              "Entspricht ${double.parse(_weightController.text) * double.parse(_rationController.toStringAsFixed(1)) ~/ 100} Gramm")
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
                        visible: (pageIndex == 0) | (pageIndex == null)
                            ? false
                            : true,
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
                                  ? () => _addPet()
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
          ),
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
        gender: _genderController!);
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
    } catch (error) {
      print(error);
    }
    try {
      print(await supabase.from('pet').select('*').eq('owner', user?.id));
    } catch (error) {
      print(error);
    }
  }
}
