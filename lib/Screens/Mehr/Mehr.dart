import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';

import '../../main.dart';

class ScreenMehr extends StatefulWidget {
  @override
  _themeState createState() => _themeState();
}

class SectionEinstellung extends StatelessWidget {
  SectionEinstellung({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SettingsSection(
      title: Text("Einstellungen"),
      tiles: [
        SettingsTile(
            title: Row(
          children: [
            Text("Dunkelmodus"),
          ],
        )),
        SettingsTile(title: Text("allo"))
      ],
    );
  }
}

class _themeState extends State<ScreenMehr> {
  bool darkModus = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DrawerHeader(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Theme.of(context).colorScheme.primaryContainer,
                  Theme.of(context).colorScheme.secondaryContainer,
                  Theme.of(context).colorScheme.onTertiary,
                ])),
                child: Column(
                  children: [
                    Material(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        elevation: 10,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: FlutterLogo(size: 100),
                        ))
                  ],
                )),
            Expanded(
                child: SettingsList(
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    sections: [
                  CustomSettingsSection(child: SectionProfile()),
                  CustomSettingsSection(
                      child: SettingsSection(
                    title: Text("Einstellungen"),
                    tiles: [
                      SettingsTile(
                          title: Row(
                        children: [
                          Text("Dunkelmodus"),
                          Switch(
                            value: darkModus,
                            onChanged: (value) {
                              setState(() {
                                darkModus = value;
                              });
                            },
                          ),
                        ],
                      )),
                      SettingsTile(title: Text("allo"))
                    ],
                  )),
                  CustomSettingsSection(child: SectionSupport()),
                  CustomSettingsSection(child: SectionAboutUs()),
                ]))
          ],
        ),
      ),
    );
  }
}

class SectionSupport extends StatelessWidget {
  const SectionSupport({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SettingsSection(
      title: Text("Support"),
      tiles: [
        SettingsTile(title: Text("Hilfe")),
        SettingsTile(title: Text("Kontakt"))
      ],
    );
  }
}

class SectionProfile extends StatelessWidget {
  const SectionProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SettingsSection(
      title: Text("Profil"),
      tiles: [
        SettingsTile(title: Text("Anmelden")),
        SettingsTile(title: Text("Abonnement abschließen"))
      ],
    );
  }
}

class SectionAboutUs extends StatelessWidget {
  const SectionAboutUs({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SettingsSection(
      title: Text("Über uns"),
      tiles: [
        SettingsTile(title: Text("Allgemeine Geschäftsbedingungen")),
        SettingsTile(title: Text("Datenschutzhinweise")),
        SettingsTile(title: Text("Impressum")),
        SettingsTile(
          title: Text("App-Informationen"),
          onPressed: (context) {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("App-Informationen"),
                    content: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text("App-Version: " "1"),
                    ),
                  );
                });
          },
        )
      ],
    );
  }
}
