import 'package:Barfbook/util/Supabase/AuthController.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final database = Database();

class Database {
  Future<void> onUpload(String imageUrl) async {
    try {
      final userId = supabase.auth.currentUser!.id;
      await supabase.from('profiles').upsert({
        'id': userId,
        'avatar_url': imageUrl,
      });
      Get.snackbar("message", 'Updated your profile image!');
    } on PostgrestException catch (error) {
      Get.snackbar("message", error.message);
    } catch (error) {
      Get.snackbar("message", 'Unexpected error has occurred');
    }
    return;
  }
}
