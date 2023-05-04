import 'package:Barfbook/Screens/Account/Login.dart';
import 'package:Barfbook/Screens/Account/SignUp.dart';
import 'package:Barfbook/Screens/Account/TransferToAccount.dart';
import 'package:Barfbook/Screens/Mehr/AGB.dart';
import 'package:Barfbook/Screens/Mehr/AboPage.dart';
import 'package:Barfbook/Screens/Mehr/DataPage.dart';
import 'package:Barfbook/Screens/Mehr/aboutUsPage.dart';
import 'package:Barfbook/Screens/Mehr/contactPage.dart';
import 'package:Barfbook/Screens/Mehr/editProfile.dart';
import 'package:Barfbook/Screens/Mehr/profile.dart';
import 'package:Barfbook/Screens/Mehr/thankPage.dart';
import 'package:Barfbook/controller.dart';
import 'package:Barfbook/loading.dart';
import 'package:Barfbook/util/Supabase/AuthController.dart';
import 'package:Barfbook/util/widgets/avatar_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ScreenSettings extends StatefulWidget {
  @override
  _settingsStartState createState() => _settingsStartState();
}

class _settingsStartState extends State<ScreenSettings>
    with SingleTickerProviderStateMixin {
  final Controller controller = Get.find();
  bool isPressedLight = false;
  bool isPressedDark = false;
  bool isPressedAbout = false;
  bool isPressedAGB = false;
  bool isPressedData = false;
  bool isPressedContact = false;
  bool isPressedThank = false;
  bool isPressedDelete = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Opacity(
        opacity: 0.4,
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/splash/background.png"),
                  fit: BoxFit.cover)),
        ),
      ),
      Center(
        child: Column(
          children: [
            SafeArea(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (userProfile.rank != 'guest') {
                        Get.to(() => ScreenProfile(profileId: userProfile.id));
                      }
                    },
                    child: CircleAvatar(
                        backgroundColor: Theme.of(context).colorScheme.surface,
                        radius: 64,
                        child: getUserAvatar(userProfile.id)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Column(
                      children: [
                        Text(
                          "${userProfile.rank == 'guest' ? 'Gast' : userProfile.name}",
                          style: TextStyle(
                              fontWeight: FontWeight.w200, fontSize: 24),
                        ),
                        if (userProfile.rank != 'guest')
                          Text("${userProfile.email}")
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: Theme.of(context).colorScheme.background,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Account Section
                        Padding(
                          padding: EdgeInsets.only(left: 20, bottom: 5),
                          child: Text(
                            "Account",
                            style: TextStyle(
                                fontSize: 13,
                                fontFamily: DefaultTextStyle.of(context)
                                    .style
                                    .fontFamily),
                          ),
                        ),
                        (userProfile.rank == 'guest')
                            ? accountGuestSettings(context)
                            : accountSettings(context),
                        // barfbook app
                        Padding(
                          padding:
                              EdgeInsets.only(left: 20, bottom: 5, top: 30),
                          child: Text(
                            "Barfbook Team",
                            style: TextStyle(
                                fontSize: 13,
                                fontFamily: DefaultTextStyle.of(context)
                                    .style
                                    .fontFamily),
                          ),
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.onPrimary,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                boxShadow: [
                                  BoxShadow(
                                      spreadRadius: 0.01,
                                      blurRadius: 0.01,
                                      color:
                                          Theme.of(context).colorScheme.outline)
                                ]),
                            child: ListView(
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                physics: NeverScrollableScrollPhysics(),
                                children: [
                                  Column(children: [
                                    GestureDetector(
                                      onTapDown: (details) {
                                        setState(() {
                                          isPressedAbout = true;
                                        });
                                      },
                                      onTapCancel: () {
                                        setState(() {
                                          isPressedAbout = false;
                                        });
                                      },
                                      onTap: () => {
                                        Get.to(() => AboutUsPage()),
                                        setState(() {
                                          isPressedAbout = false;
                                        })
                                      },
                                      child: Container(
                                        color: isPressedAbout
                                            ? Colors.transparent
                                                .withOpacity(0.1)
                                            : Colors.transparent,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                  flex: 1,
                                                  child: FaIcon(
                                                      FontAwesomeIcons.users)),
                                              Expanded(
                                                flex: 8,
                                                child: Text(
                                                  "Über uns",
                                                  style: TextStyle(
                                                      letterSpacing: 0.5,
                                                      fontSize: 16,
                                                      fontFamily:
                                                          DefaultTextStyle.of(
                                                                  context)
                                                              .style
                                                              .fontFamily,
                                                      color: Theme.of(context)
                                                          .textTheme
                                                          .labelMedium!
                                                          .color),
                                                ),
                                              ),
                                              Expanded(
                                                  flex: 1,
                                                  child: Icon(
                                                      Icons.arrow_forward_ios))
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Divider(
                                      height: 0,
                                      thickness: 0.7,
                                    ),
                                    GestureDetector(
                                      onTapDown: (details) {
                                        setState(() {
                                          isPressedLogIn = true;
                                        });
                                      },
                                      onTapCancel: () {
                                        setState(() {
                                          isPressedLogIn = false;
                                        });
                                      },
                                      onTap: () => {
                                        setState(() {
                                          isPressedLogIn = false;
                                        }),
                                      },
                                      child: Container(
                                        color: isPressedLogIn
                                            ? Colors.transparent
                                                .withOpacity(0.1)
                                            : Colors.transparent,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Row(
                                              children: [
                                                Expanded(
                                                    flex: 1,
                                                    child: FaIcon(FontAwesomeIcons
                                                        .solidCircleQuestion)),
                                                Expanded(
                                                  flex: 8,
                                                  child: Text(
                                                    "Fragen",
                                                    style: TextStyle(
                                                        letterSpacing: 0.5,
                                                        fontSize: 16,
                                                        fontFamily:
                                                            DefaultTextStyle.of(
                                                                    context)
                                                                .style
                                                                .fontFamily,
                                                        color: Theme.of(context)
                                                            .textTheme
                                                            .labelMedium!
                                                            .color),
                                                  ),
                                                ),
                                                Expanded(
                                                    flex: 1,
                                                    child: Icon(Icons
                                                        .arrow_forward_ios))
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Divider(
                                      height: 0,
                                      thickness: 0.7,
                                    ),
                                    GestureDetector(
                                      onTapDown: (details) {
                                        setState(() {
                                          isPressedContact = true;
                                        });
                                      },
                                      onTapCancel: () {
                                        setState(() {
                                          isPressedContact = false;
                                        });
                                      },
                                      onTap: () => {
                                        Get.to(() => ContactPage()),
                                        setState(() {
                                          isPressedContact = false;
                                        })
                                      },
                                      child: Container(
                                        color: isPressedContact
                                            ? Colors.transparent
                                                .withOpacity(0.1)
                                            : Colors.transparent,
                                        child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                    flex: 1,
                                                    child: FaIcon(
                                                        FontAwesomeIcons
                                                            .solidComments)),
                                                Expanded(
                                                  flex: 8,
                                                  child: Text(
                                                    "Feedback",
                                                    style: TextStyle(
                                                        letterSpacing: 0.5,
                                                        fontSize: 16,
                                                        fontFamily:
                                                            DefaultTextStyle.of(
                                                                    context)
                                                                .style
                                                                .fontFamily,
                                                        color: Theme.of(context)
                                                            .textTheme
                                                            .labelMedium!
                                                            .color),
                                                  ),
                                                ),
                                                Expanded(
                                                    flex: 1,
                                                    child: Icon(Icons
                                                        .arrow_forward_ios))
                                              ],
                                            )),
                                      ),
                                    ),
                                    Divider(
                                      height: 0,
                                      thickness: 0.7,
                                    ),
                                    GestureDetector(
                                      onTapDown: (details) {
                                        setState(() {
                                          isPressedThank = true;
                                        });
                                      },
                                      onTapCancel: () {
                                        setState(() {
                                          isPressedThank = false;
                                        });
                                      },
                                      onTap: () => {
                                        Get.to(() => ThankPage()),
                                        setState(() {
                                          isPressedThank = false;
                                        })
                                      },
                                      child: Container(
                                        color: isPressedThank
                                            ? Colors.transparent
                                                .withOpacity(0.1)
                                            : Colors.transparent,
                                        child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                    flex: 1,
                                                    child: FaIcon(
                                                        FontAwesomeIcons
                                                            .solidHeart)),
                                                Expanded(
                                                  flex: 8,
                                                  child: Text(
                                                    "Danksagung",
                                                    style: TextStyle(
                                                        letterSpacing: 0.5,
                                                        fontSize: 16,
                                                        fontFamily:
                                                            DefaultTextStyle.of(
                                                                    context)
                                                                .style
                                                                .fontFamily,
                                                        color: Theme.of(context)
                                                            .textTheme
                                                            .labelMedium!
                                                            .color),
                                                  ),
                                                ),
                                                Expanded(
                                                    flex: 1,
                                                    child: Icon(Icons
                                                        .arrow_forward_ios))
                                              ],
                                            )),
                                      ),
                                    ),
                                  ])
                                ])),
                        // barfbook team
                        Padding(
                          padding:
                              EdgeInsets.only(left: 20, bottom: 5, top: 30),
                          child: Text(
                            "Rechtliches",
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.onPrimary,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                    spreadRadius: 0.01,
                                    blurRadius: 0.01,
                                    color:
                                        Theme.of(context).colorScheme.outline)
                              ]),
                          child: ListView(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: NeverScrollableScrollPhysics(),
                            children: [
                              Column(
                                children: [
                                  GestureDetector(
                                    onTapDown: (details) {
                                      setState(() {
                                        isPressedAGB = true;
                                      });
                                    },
                                    onTapCancel: () {
                                      setState(() {
                                        isPressedAGB = false;
                                      });
                                    },
                                    onTap: () => {
                                      Get.to(() => AGB()),
                                      setState(() {
                                        isPressedAGB = false;
                                      })
                                    },
                                    child: Container(
                                        color: isPressedAGB
                                            ? Colors.transparent
                                                .withOpacity(0.1)
                                            : Colors.transparent,
                                        child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                    flex: 1,
                                                    child: FaIcon(
                                                        FontAwesomeIcons.book)),
                                                Expanded(
                                                  flex: 8,
                                                  child: Text(
                                                    "Allg. Geschäftsbedingungen",
                                                    style: TextStyle(
                                                        letterSpacing: 0.5,
                                                        fontSize: 16,
                                                        fontFamily:
                                                            DefaultTextStyle.of(
                                                                    context)
                                                                .style
                                                                .fontFamily,
                                                        color: Theme.of(context)
                                                            .textTheme
                                                            .labelMedium!
                                                            .color),
                                                  ),
                                                ),
                                                Expanded(
                                                    flex: 1,
                                                    child: Icon(Icons
                                                        .arrow_forward_ios))
                                              ],
                                            ))),
                                  ),
                                  Divider(
                                    height: 0,
                                    thickness: 0.7,
                                  ),
                                  GestureDetector(
                                    onTapDown: (details) {
                                      setState(() {
                                        isPressedData = true;
                                      });
                                    },
                                    onTapCancel: () {
                                      setState(() {
                                        isPressedData = false;
                                      });
                                    },
                                    onTap: () => {
                                      Get.to(() => DataPage()),
                                      setState(() {
                                        isPressedData = false;
                                      })
                                    },
                                    child: Container(
                                      color: isPressedData
                                          ? Colors.transparent.withOpacity(0.1)
                                          : Colors.transparent,
                                      child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                  flex: 1,
                                                  child: FaIcon(FontAwesomeIcons
                                                      .shieldDog)),
                                              Expanded(
                                                flex: 8,
                                                child: Text(
                                                  "Datenschutz",
                                                  style: TextStyle(
                                                      letterSpacing: 0.5,
                                                      fontSize: 16,
                                                      fontFamily:
                                                          DefaultTextStyle.of(
                                                                  context)
                                                              .style
                                                              .fontFamily,
                                                      color: Theme.of(context)
                                                          .textTheme
                                                          .labelMedium!
                                                          .color),
                                                ),
                                              ),
                                              Expanded(
                                                  flex: 1,
                                                  child: Icon(
                                                      Icons.arrow_forward_ios))
                                            ],
                                          )),
                                    ),
                                  ),
                                  Divider(
                                    height: 0,
                                    thickness: 0.7,
                                  ),
                                  GestureDetector(
                                    onTapDown: (details) {
                                      setState(() {
                                        isPressedDelete = true;
                                      });
                                    },
                                    onTapCancel: () {
                                      setState(() {
                                        isPressedDelete = false;
                                      });
                                    },
                                    onTap: () => {
                                      Get.defaultDialog(
                                          title: 'Achtung!',
                                          confirm: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              ElevatedButton(
                                                  onPressed: () async {
                                                    _deleteAccount().whenComplete(
                                                        () => authController
                                                            .signOut()
                                                            .whenComplete(() =>
                                                                Get.to(() =>
                                                                    ScreenLogin())));
                                                  },
                                                  child: Text(
                                                    'Ja',
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  )),
                                              ElevatedButton(
                                                  onPressed: () {},
                                                  child: Text('Nein')),
                                            ],
                                          ),
                                          content: Column(
                                            children: [
                                              Text.rich(TextSpan(
                                                  text: 'Diese Aktion kann',
                                                  children: [
                                                    TextSpan(
                                                        text: ' nicht ',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    TextSpan(
                                                        text:
                                                            'rückgängig gemacht werden.\nBist du dir sicher, dass du deinen Account löschen möchtest?')
                                                  ]))
                                            ],
                                          )),
                                      setState(() {
                                        isPressedDelete = false;
                                      })
                                    },
                                    child: Container(
                                      color: isPressedDelete
                                          ? Colors.transparent.withOpacity(0.1)
                                          : Colors.transparent,
                                      child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                  flex: 1,
                                                  child: FaIcon(FontAwesomeIcons
                                                      .userXmark)),
                                              Expanded(
                                                flex: 8,
                                                child: Text(
                                                  "Account löschen",
                                                  style: TextStyle(
                                                      letterSpacing: 0.5,
                                                      fontSize: 16,
                                                      fontFamily:
                                                          DefaultTextStyle.of(
                                                                  context)
                                                              .style
                                                              .fontFamily,
                                                      color: Colors.red),
                                                ),
                                              ),
                                              Expanded(
                                                  flex: 1,
                                                  child: Icon(
                                                      Icons.arrow_forward_ios))
                                            ],
                                          )),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    ]));
  }

  bool isPressedProfile = false;
  bool isPressedAbo = false;
  bool isPressedLogOff = false;
  bool isPressedProfileEdit = false;
  bool isPressed = false;
  Container accountSettings(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onPrimary,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
                spreadRadius: 0.01,
                blurRadius: 0.01,
                color: Theme.of(context).colorScheme.outline)
          ]),
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: NeverScrollableScrollPhysics(),
        children: [
          Column(
            children: [
              GestureDetector(
                onTapDown: (details) {
                  setState(() {
                    isPressedProfile = true;
                  });
                },
                onTapCancel: () {
                  setState(() {
                    isPressedProfile = false;
                  });
                },
                onTap: () {
                  setState(() {
                    isPressedProfile = false;
                  });
                  Get.to(
                    () => ScreenProfile(profileId: userProfile.id),
                  );
                },
                child: Container(
                  color: isPressedProfile
                      ? Colors.transparent.withOpacity(0.1)
                      : Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 1, child: FaIcon(FontAwesomeIcons.solidUser)),
                        Expanded(
                          flex: 8,
                          child: Text(
                            "Profil",
                            style: TextStyle(
                                letterSpacing: 0.5,
                                fontSize: 16,
                                fontFamily: DefaultTextStyle.of(context)
                                    .style
                                    .fontFamily,
                                color: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .color),
                          ),
                        ),
                        Expanded(flex: 1, child: Icon(Icons.arrow_forward_ios))
                      ],
                    ),
                  ),
                ),
              ),
              Divider(
                height: 0,
                thickness: 0.7,
              ),
              GestureDetector(
                onTapDown: (details) {
                  setState(() {
                    isPressedProfileEdit = true;
                  });
                },
                onTapCancel: () {
                  setState(() {
                    isPressedProfileEdit = false;
                  });
                },
                onTap: () => {
                  Get.to(
                    () => ScreenEditProfile(profile: userProfile),
                  ),
                  setState(() {
                    isPressedProfileEdit = false;
                  })
                },
                child: Container(
                  color: isPressedProfileEdit
                      ? Colors.transparent.withOpacity(0.1)
                      : Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 1, child: FaIcon(FontAwesomeIcons.userGear)),
                        Expanded(
                          flex: 8,
                          child: Text(
                            "Profil bearbeiten",
                            style: TextStyle(
                                letterSpacing: 0.5,
                                fontSize: 16,
                                fontFamily: DefaultTextStyle.of(context)
                                    .style
                                    .fontFamily,
                                color: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .color),
                          ),
                        ),
                        Expanded(flex: 1, child: Icon(Icons.arrow_forward_ios))
                      ],
                    ),
                  ),
                ),
              ),
              Divider(
                height: 0,
                thickness: 0.7,
              ),
              GestureDetector(
                onTapDown: (details) {
                  setState(() {
                    isPressedAbo = true;
                  });
                },
                onTapCancel: () {
                  setState(() {
                    isPressedAbo = false;
                  });
                },
                onTap: () => {
                  Navigator.of(context).push(PageRouteBuilder(
                      opaque: false,
                      pageBuilder: (BuildContext context, _, __) => AboPage())),
                  setState(() {
                    isPressedAbo = false;
                  })
                },
                child: Container(
                  color: isPressedAbo
                      ? Colors.transparent.withOpacity(0.1)
                      : Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 1, child: FaIcon(FontAwesomeIcons.subscript)),
                        Expanded(
                          flex: 8,
                          child: Text(
                            "Abonnement abschließen",
                            style: TextStyle(
                                letterSpacing: 0.5,
                                fontSize: 16,
                                fontFamily: DefaultTextStyle.of(context)
                                    .style
                                    .fontFamily,
                                color: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .color),
                          ),
                        ),
                        Expanded(flex: 1, child: Icon(Icons.arrow_forward_ios))
                      ],
                    ),
                  ),
                ),
              ),
              Divider(
                height: 0,
                thickness: 0.7,
              ),
              GestureDetector(
                onTapDown: (details) {
                  setState(() {
                    isPressedLogOff = true;
                  });
                },
                onTapCancel: () {
                  setState(() {
                    isPressedLogOff = false;
                  });
                },
                onTap: () => {
                  authController.signOut(),
                  Get.offAll(() => ScreenLogin()),
                  setState(() {
                    isPressedLogOff = false;
                  })
                },
                child: Container(
                  color: isPressedLogOff
                      ? Colors.transparent.withOpacity(0.1)
                      : Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: FaIcon(FontAwesomeIcons.rightFromBracket)),
                        Expanded(
                          flex: 8,
                          child: Text(
                            "Abmelden",
                            style: TextStyle(
                                letterSpacing: 0.5,
                                fontSize: 16,
                                fontFamily: DefaultTextStyle.of(context)
                                    .style
                                    .fontFamily,
                                color: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .color),
                          ),
                        ),
                        Expanded(flex: 1, child: Icon(Icons.arrow_forward_ios))
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  bool isPressedLogIn = false;
  bool isPressedSignIn = false;
  accountGuestSettings(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onPrimary,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                  spreadRadius: 0.01,
                  blurRadius: 0.01,
                  color: Theme.of(context).colorScheme.outline)
            ]),
        child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
            children: [
              Column(children: [
                GestureDetector(
                  onTapDown: (details) {
                    setState(() {
                      isPressedLogIn = true;
                    });
                  },
                  onTapCancel: () {
                    setState(() {
                      isPressedLogIn = false;
                    });
                  },
                  onTap: () => {
                    setState(() {
                      isPressedLogIn = false;
                    }),
                    Get.offAll(() => ScreenTransfer())
                  },
                  child: Container(
                    color: isPressedLogIn
                        ? Colors.transparent.withOpacity(0.1)
                        : Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: FaIcon(FontAwesomeIcons.rightToBracket)),
                          Expanded(
                            flex: 8,
                            child: Text(
                              "Anmelden",
                              style: TextStyle(
                                  letterSpacing: 0.5,
                                  fontSize: 16,
                                  fontFamily: DefaultTextStyle.of(context)
                                      .style
                                      .fontFamily,
                                  color: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .color),
                            ),
                          ),
                          Expanded(
                              flex: 1, child: Icon(Icons.arrow_forward_ios))
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTapDown: (details) {
                    setState(() {
                      isPressedSignIn = true;
                    });
                  },
                  onTapCancel: () {
                    setState(() {
                      isPressedSignIn = false;
                    });
                  },
                  onTap: () => {},
                  child: Container(
                    color: isPressedSignIn
                        ? Colors.transparent.withOpacity(0.1)
                        : Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: FaIcon(FontAwesomeIcons.userPlus)),
                          Expanded(
                            flex: 8,
                            child: Text(
                              "Profil",
                              style: TextStyle(
                                  letterSpacing: 0.5,
                                  fontSize: 16,
                                  fontFamily: DefaultTextStyle.of(context)
                                      .style
                                      .fontFamily,
                                  color: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .color),
                            ),
                          ),
                          Expanded(
                              flex: 1, child: Icon(Icons.arrow_forward_ios))
                        ],
                      ),
                    ),
                  ),
                )
              ])
            ]));
  }

  Future _deleteAccount() async {
    try {
      await supabase.from('profile').delete().eq('id', user?.id);
    } catch (error) {
      print(error);
    }
  }
}
