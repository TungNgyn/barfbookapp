import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:Barfbook/Screens/Mehr/profile_controller.dart';
import 'package:Barfbook/Screens/Barfbook/pet_controller.dart';
import 'package:Barfbook/controller.dart';
import 'package:Barfbook/util/Supabase/AuthController.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ScreenEditProfile extends StatefulWidget {
  const ScreenEditProfile({required this.profile});
  final Profile profile;

  @override
  State<ScreenEditProfile> createState() => _ScreenEditProfileState();
}

class _ScreenEditProfileState extends State<ScreenEditProfile> {
  final Controller controller = Get.find();
  late TextEditingController _nameController =
      TextEditingController(text: widget.profile.name);
  late TextEditingController _emailController =
      TextEditingController(text: widget.profile.email);
  late TextEditingController _descriptionController =
      TextEditingController(text: widget.profile.description);
  var avatar;
  var file;
  Future? _future;
  FilePickerResult? result;
  PlatformFile? avatarFile;

  _loadAvatar() async {
    avatar = widget.profile.avatar;
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
          title: Text("Profil bearbeiten"),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                icon: Icon(Icons.create),
                onPressed: () async {
                  await _updateProfile().then((value) => Get.back());
                },
              ),
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32),
          child: Column(
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
                      file = File('${tempDir.path}/${user?.id}');

                      setState(() {
                        avatar = Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Theme.of(context).colorScheme.primary),
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
                    child: Container(child: avatar)),
              ),
              SizedBox(height: 24),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(
                    label: 'Name',
                    text: widget.profile.name,
                    controller: _nameController,
                    onChanged: (name) {},
                  ),
                  SizedBox(height: 24),
                  CustomTextField(
                    label: 'Email',
                    text: widget.profile.email,
                    controller: _emailController,
                    onChanged: (age) {},
                  ),
                  SizedBox(height: 24),
                  CustomTextField(
                      label: 'Biografie',
                      text: widget.profile.description,
                      controller: _descriptionController,
                      maxLines: 12,
                      onChanged: (breed) {}),
                  SizedBox(height: 24),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> _updateProfile() async {
    try {
      if (file != null) {
        final bytes = await rootBundle.load(avatarFile!.path!);
        await file.writeAsBytes(
            bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes));

        await supabase.storage.from('profile').update('${user?.id}', file,
            fileOptions:
                const FileOptions(cacheControl: '3600', upsert: false));
      }
      await supabase.rpc('update_profile', params: {
        'profilename': _nameController.text,
        'profileemail': _emailController.text,
        'profiledescription': _descriptionController.text,
        'profileid': widget.profile.id
      });
    } catch (error) {
      print(error);
      Get.snackbar("Fehler!", "Etwas hat nicht funktioniert");
    }
  }
}
