import 'package:Barfbook/Screens/Account/Login.dart';
import 'package:Barfbook/Screens/Account/SignUp.dart';
import 'package:Barfbook/Screens/Mehr/profile.dart';
import 'package:Barfbook/main.dart';
import 'package:Barfbook/util/Supabase/AuthController.dart';
import 'package:Barfbook/util/custom_theme.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:supabase/src/supabase_stream_builder.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ScreenSettings extends StatefulWidget {
  @override
  _settingsStartState createState() => _settingsStartState();
}

class SectionSettings extends StatelessWidget {
  SectionSettings({
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

class _settingsStartState extends State<ScreenSettings>
    with SingleTickerProviderStateMixin {
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

  String _themeModeValue = "system";

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
                        child: Image.asset(
                          "assets/images/defaultAvatar.png",
                          height: 100,
                        )),
                    Text(user != null || session != null
                        ? "${userdata["name"]}"
                        : "")
                  ],
                )),
            Expanded(
                child: SettingsList(physics: ScrollPhysics(), sections: [
              CustomSettingsSection(
                  child: user == null || session == null
                      ? SectionProfileGast()
                      : SectionProfile()),
              CustomSettingsSection(
                  child: SettingsSection(
                title: Text("Einstellungen"),
                tiles: [
                  SettingsTile(
                    title:
                        // Text("Dunkelmodus"),
                        Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Theme"),
                          Row(
                            children: [
                              Radio(
                                  value: "system",
                                  groupValue: _themeModeValue,
                                  onChanged: (value) {
                                    setState(() {
                                      Get.changeThemeMode(ThemeMode.system);
                                      _changeTheme(value!);
                                    });
                                  }),
                              Text("System")
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                  value: "light",
                                  groupValue: _themeModeValue,
                                  onChanged: (value) {
                                    setState(() {
                                      Get.changeThemeMode(ThemeMode.light);
                                      _changeTheme(value!);
                                    });
                                  }),
                              Text("Hell")
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                  value: "dark",
                                  groupValue: _themeModeValue,
                                  onChanged: (value) {
                                    setState(() {
                                      Get.changeThemeMode(ThemeMode.dark);
                                      _changeTheme(value!);
                                    });
                                  }),
                              Text("Dunkel")
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Switch(
                    //   value: Get.isDarkMode,
                    //   onChanged: (value) {
                    //     setState(() {
                    //       Get.changeThemeMode(Get.isDarkMode
                    //           ? ThemeMode.light
                    //           : ThemeMode.dark);
                    //     });
                    //   },
                    // ),
                  ),
                  SettingsTile(title: Text("allo"))
                ],
              )),
              CustomSettingsSection(child: SectionSupport()),
              CustomSettingsSection(
                  child: SettingsSection(
                title: Text("Über uns"),
                tiles: [
                  SettingsTile(title: Text("Allgemeine Geschäftsbedingungen")),
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

  void _changeTheme(String value) {
    setState(() {
      _themeModeValue = value;
    });
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
        SettingsTile(
          title: Text("Profil"),
          onPressed: (context) {
            Get.to(() => ScreenProfile());
          },
        ),
        SettingsTile(
          title: Text("Abonnement abschließen"),
          onPressed: (context) {},
        ),
        SettingsTile(
          title: Text("Abmelden"),
          onPressed: (context) =>
              {authController.signOut(), Get.offAll(() => ScreenLogin())},
        )
      ],
    );
  }
}

class SectionProfileGast extends StatelessWidget {
  const SectionProfileGast({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SettingsSection(
      title: Text("Profil"),
      tiles: [
        SettingsTile(
            title: Text("Account erstellen"),
            onPressed: (context) {
              authController.signOut();
              Get.to(() => ScreenSignUp());
            })
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
