import 'package:Barfbook/Screens/Mehr/profile_controller.dart';
import 'package:Barfbook/Screens/calculator/pet_controller.dart';
import 'package:Barfbook/controller.dart';
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
  final TextEditingController _nameController = TextEditingController();
  String? _genderController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profil bearbeiten"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              icon: Icon(Icons.create),
              onPressed: () async {
                // await _updateRecipe();
                // Get.back();
              },
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            CircleAvatar(
              radius: 67,
              child: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.surface,
                radius: 64,
                child: FlutterLogo(
                  size: 64,
                ),
              ),
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
                  label: 'E-Mail',
                  text: widget.profile.email,
                  controller: _nameController,
                  onChanged: (age) {},
                ),
                SizedBox(height: 24),
                CustomTextField(
                    label: 'Erzähl etwas über dich!',
                    text: widget.profile.description,
                    controller: _nameController,
                    maxLines: 12,
                    onChanged: (breed) {}),
                SizedBox(height: 24),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
