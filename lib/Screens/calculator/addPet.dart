import 'package:flutter/material.dart';

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
  final TextEditingController _genderController = TextEditingController();
  int? pageIndex;
  @override
  Widget build(BuildContext context) {
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
                                        controller: _nameController,
                                        decoration: InputDecoration(
                                            hintText: "Name",
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide())),
                                      ),
                                      SizedBox(height: 30),
                                      TextField(
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
                                        controller: _breedController,
                                        decoration: InputDecoration(
                                            hintText: "Hunderasse",
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide())),
                                      ),
                                      TextField(
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
                                            setState(() {});
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
                                      TextField(
                                        decoration: InputDecoration(),
                                      ),
                                      Text("Entspricht Gramm")
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
                  flex: 2,
                  child: ElevatedButton(
                      onPressed: (pageIndex == 0) | (pageIndex == null)
                          ? null
                          : () {
                              pageController.previousPage(
                                  duration: Duration(seconds: 1),
                                  curve: Curves.fastLinearToSlowEaseIn);
                            },
                      child: Text("Zurück"))),
              Flexible(
                  flex: 2,
                  child: ElevatedButton(
                      onPressed: pageIndex == 2
                          ? null
                          : () {
                              pageController.nextPage(
                                  duration: Duration(seconds: 1),
                                  curve: Curves.fastLinearToSlowEaseIn);
                            },
                      child: Text("Weiter")))
            ],
          ),
        ));
  }

  _onPageViewChange(int page) {
    setState(() {
      pageIndex = page;
    });
  }
}
