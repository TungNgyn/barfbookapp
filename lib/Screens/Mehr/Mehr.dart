import 'package:Barfbook/Screens/Account/Login.dart';
import 'package:Barfbook/util/Supabase/DB.dart';
import 'package:Barfbook/Screens/Account/avatar.dart';
import 'package:Barfbook/util/Supabase/AuthController.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../main.dart';

class ScreenMehr extends StatefulWidget {
  @override
  _settingsStartState createState() => _settingsStartState();
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

class _settingsStartState extends State<ScreenMehr>
    with SingleTickerProviderStateMixin {
  bool darkModus = false;
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
        value: 0.0,
        duration: const Duration(milliseconds: 500),
        reverseDuration: const Duration(milliseconds: 250),
        vsync: this)
      ..addStatusListener((status) {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool get _isAnimationRunningForwardsOrComplete {
    switch (_controller.status) {
      case AnimationStatus.forward:
      case AnimationStatus.completed:
        return true;
      case AnimationStatus.reverse:
      case AnimationStatus.dismissed:
        return false;
    }
  }

  String? _avatarUrl;
  Future<void> _onUpload(String imageUrl) async {
    try {
      final userId = supabase.auth.currentUser!.id;
      await supabase.from('profiles').upsert({
        'id': userId,
        'avatar_url': imageUrl,
      });
      if (mounted) {
        Get.snackbar("message", 'Updated your profile image!');
      }
    } on PostgrestException catch (error) {
      Get.snackbar("message", error.message);
    } catch (error) {
      Get.snackbar("message", 'Unexpected error has occurred');
    }
    if (!mounted) {
      return;
    }

    setState(() {
      _avatarUrl = imageUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, Widget? child) {
          return FadeScaleTransition(animation: _controller, child: child);
        },
        child: Visibility(
          visible: _controller.status != AnimationStatus.dismissed,
          child: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {},
          ),
        ),
      ),
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
                          child: Avatar(
                              imageUrl:
                                  "https://upload.wikimedia.org/wikipedia/commons/thumb/2/2c/Default_pfp.svg/1200px-Default_pfp.svg.png",
                              onUpload: _onUpload),
                        )),
                    Text(
                      "${user?.email}",
                      style: TextStyle(color: Colors.white),
                    )
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
                  CustomSettingsSection(
                      child: SettingsSection(
                    title: Text("Über uns"),
                    tiles: [
                      SettingsTile(
                          title: Text("Allgemeine Geschäftsbedingungen")),
                      SettingsTile(title: Text("Datenschutzhinweise")),
                      SettingsTile(title: Text("Impressum")),
                      SettingsTile(
                        title: Text("App-Informationen"),
                        onPressed: (context) {
                          showModal(
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
                  )),
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
        SettingsTile(title: Text("Abonnement abschließen")),
        SettingsTile(
          title: Text("Abmelden"),
          onPressed: (context) =>
              {authController.signOut(), Get.to(() => ScreenLogin())},
        )
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
            // showDialog(
            //     context: context,
            //     builder: (BuildContext context) {
            //       return AlertDialog(
            //         title: Text("App-Informationen"),
            //         content: Padding(
            //           padding: EdgeInsets.all(20.0),
            //           child: Text("App-Version: " "1"),
            //         ),
            //       );
            //     });
          },
        )
      ],
    );
  }
}
