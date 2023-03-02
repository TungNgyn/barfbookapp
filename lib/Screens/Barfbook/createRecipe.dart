import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class ScreenCreateRecipe extends StatefulWidget {
  const ScreenCreateRecipe({super.key});

  @override
  State<ScreenCreateRecipe> createState() => _newRecipeState();
}

class _newRecipeState extends State<ScreenCreateRecipe> {
  late String teil1;
  late String teil2;
  var beef = false;
  var duck = false;
  var goat = false;
  var goose = false;
  var hen = false;
  var horse = false;
  var lamb = false;
  var rabbit = false;
  var vegan = false;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Neues Rezept erstellen"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              icon: Icon(Icons.add),
              onPressed: () {},
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              onChanged: (textfeld1text) {
                teil1 = textfeld1text;
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: "Rezeptname"),
            ),
            SizedBox(height: 20),
            TextField(
                onChanged: (textfeld2text) {
                  teil2 = textfeld2text;
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: "Wort2")),
            SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  print(teil1);
                },
                child: Text("klick")),
            SizedBox(height: 20),
            ExpansionTile(
              initiallyExpanded: true,
              title: Text("Hauptzutat"),
              children: [
                Wrap(
                  alignment: WrapAlignment.spaceEvenly,
                  direction: Axis.horizontal,
                  spacing: 5,
                  runSpacing: 5,
                  children: [
                    SizedBox(
                      height: 40,
                      child: ElevatedButton.icon(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(beef
                                  ? theme.colorScheme.secondary
                                  : theme.colorScheme.secondaryContainer),
                              foregroundColor: MaterialStateProperty.all(beef
                                  ? theme.colorScheme.secondaryContainer
                                  : theme.colorScheme.secondary)),
                          onPressed: () {
                            setState(() {
                              beef ? beef = false : beef = true;
                            });
                          },
                          icon: Image.asset(
                              "assets/images/recipe/icons/beef.png"),
                          label: Text("Rind")),
                    ),
                    SizedBox(
                      height: 40,
                      child: ElevatedButton.icon(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(duck
                                  ? theme.colorScheme.secondary
                                  : theme.colorScheme.secondaryContainer),
                              foregroundColor: MaterialStateProperty.all(duck
                                  ? theme.colorScheme.secondaryContainer
                                  : theme.colorScheme.secondary)),
                          onPressed: () {
                            setState(() {
                              duck ? duck = false : duck = true;
                            });
                          },
                          icon: Image.asset(
                              "assets/images/recipe/icons/duck.png"),
                          label: Text("Ente")),
                    ),
                    SizedBox(
                      height: 40,
                      child: ElevatedButton.icon(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(goat
                                  ? theme.colorScheme.secondary
                                  : theme.colorScheme.secondaryContainer),
                              foregroundColor: MaterialStateProperty.all(goat
                                  ? theme.colorScheme.secondaryContainer
                                  : theme.colorScheme.secondary)),
                          onPressed: () {
                            setState(() {
                              goat ? goat = false : goat = true;
                            });
                          },
                          icon: Image.asset(
                              "assets/images/recipe/icons/goat.png"),
                          label: Text("Ziege")),
                    ),
                    SizedBox(
                      height: 40,
                      child: ElevatedButton.icon(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(goose
                                  ? theme.colorScheme.secondary
                                  : theme.colorScheme.secondaryContainer),
                              foregroundColor: MaterialStateProperty.all(goose
                                  ? theme.colorScheme.secondaryContainer
                                  : theme.colorScheme.secondary)),
                          onPressed: () {
                            setState(() {
                              goose ? goose = false : goose = true;
                            });
                          },
                          icon: Image.asset(
                              "assets/images/recipe/icons/goose.png"),
                          label: Text("Gans")),
                    ),
                    SizedBox(
                      height: 40,
                      child: ElevatedButton.icon(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(hen
                                  ? theme.colorScheme.secondary
                                  : theme.colorScheme.secondaryContainer),
                              foregroundColor: MaterialStateProperty.all(hen
                                  ? theme.colorScheme.secondaryContainer
                                  : theme.colorScheme.secondary)),
                          onPressed: () {
                            setState(() {
                              hen ? hen = false : hen = true;
                            });
                          },
                          icon:
                              Image.asset("assets/images/recipe/icons/hen.png"),
                          label: Text("Huhn")),
                    ),
                    SizedBox(
                      height: 40,
                      child: ElevatedButton.icon(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(horse
                                  ? theme.colorScheme.secondary
                                  : theme.colorScheme.secondaryContainer),
                              foregroundColor: MaterialStateProperty.all(horse
                                  ? theme.colorScheme.secondaryContainer
                                  : theme.colorScheme.secondary)),
                          onPressed: () {
                            setState(() {
                              horse ? horse = false : horse = true;
                            });
                          },
                          icon: Image.asset(
                              "assets/images/recipe/icons/horse.png"),
                          label: Text("Pferd")),
                    ),
                    SizedBox(
                      height: 40,
                      child: ElevatedButton.icon(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(lamb
                                  ? theme.colorScheme.secondary
                                  : theme.colorScheme.secondaryContainer),
                              foregroundColor: MaterialStateProperty.all(lamb
                                  ? theme.colorScheme.secondaryContainer
                                  : theme.colorScheme.secondary)),
                          onPressed: () {
                            setState(() {
                              lamb ? lamb = false : lamb = true;
                            });
                          },
                          icon: Image.asset(
                              "assets/images/recipe/icons/lamb.png"),
                          label: Text("Lamm")),
                    ),
                    SizedBox(
                      height: 40,
                      child: ElevatedButton.icon(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(rabbit
                                  ? theme.colorScheme.secondary
                                  : theme.colorScheme.secondaryContainer),
                              foregroundColor: MaterialStateProperty.all(rabbit
                                  ? theme.colorScheme.secondaryContainer
                                  : theme.colorScheme.secondary)),
                          onPressed: () {
                            setState(() {
                              rabbit ? rabbit = false : rabbit = true;
                            });
                          },
                          icon: Image.asset(
                              "assets/images/recipe/icons/rabbit.png"),
                          label: Text("Hase")),
                    ),
                    SizedBox(
                      height: 40,
                      child: ElevatedButton.icon(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(vegan
                                  ? theme.colorScheme.secondary
                                  : theme.colorScheme.secondaryContainer),
                              foregroundColor: MaterialStateProperty.all(vegan
                                  ? theme.colorScheme.secondaryContainer
                                  : theme.colorScheme.secondary)),
                          onPressed: () {
                            setState(() {
                              vegan ? vegan = false : vegan = true;
                            });
                          },
                          icon: Image.asset(
                              "assets/images/recipe/icons/vegan.png"),
                          label: Text("Vegan")),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
