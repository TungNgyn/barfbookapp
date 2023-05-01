import 'package:Barfbook/controller.dart';
import 'package:Barfbook/loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatelessWidget {
  final Controller controller = Get.find();
  late TextEditingController _nameController = TextEditingController(
      text: userProfile.name == 'Gast' ? '' : userProfile.name);
  late TextEditingController _emailController = TextEditingController(
      text: userProfile.name == 'Gast' ? '' : userProfile.email);
  TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kontakt"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(children: [
          Column(
            children: [
              Text(
                  'Bei Fragen oder Anregungen kannst du uns eine Email schreiben, indem du das Formular ausfüllst.\nWir melden uns so bald wie möglich.'),
            ],
          ),
          Column(
            children: [
              TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                      hintText: 'Name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)))),
              TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                      hintText: 'Email',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)))),
              TextField(
                  maxLines: 10,
                  controller: _messageController,
                  decoration: InputDecoration(
                      hintText: 'Nachricht',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)))),
              ElevatedButton(
                  onPressed: () async {
                    // sendEmail().whenComplete(() => Get.back());
                  },
                  child: Text("Abschicken"))
            ],
          ),
        ]),
      ),
    );
  }

  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  // Future sendEmail() async {
  //   try {
  //     final Uri params = Uri(
  //         scheme: 'mailto',
  //         path: 'dev.tung@proton.me',
  //         query: encodeQueryParameters(<String, String>{
  //           'subject': 'Barfbook Nachricht',
  //           'body':
  //               'id: ${userProfile.id} \nuser: ${_nameController.text} \nemail: ${_emailController.text} \nmessage: ${_messageController.text}'
  //         }));

  //     if (await canLaunchUrl(params)) {
  //       await launchUrl(params);
  //     } else {
  //       throw 'Could not launch $params';
  //     }
  //   } catch (error) {
  //     print(error);
  //   }
  // }
}
