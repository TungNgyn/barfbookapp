import 'package:Barfbook/Screens/Barfbook/barfbook_controller.dart';
import 'package:Barfbook/loading.dart';
import 'package:Barfbook/util/Supabase/AuthController.dart';
import 'package:get/get.dart';

class Controller extends GetxController {
  List userScheduleList = [].obs;
  List userRecipeList = [].obs;
  List userFavoriteList = [].obs;
  List databaseRecipeList = [].obs;
  List exploreRecipeList = [].obs;

  getRecipeList() async {
    try {
      databaseRecipeList = await supabase.from('recipe').select(
          'id, created_at, modified_at, name, description, paws, user_id');
    } catch (error) {
      print(error);
    } finally {
      exploreRecipeList.clear();
      for (var recipe in databaseRecipeList) {
        List userName = await supabase
            .from('profile')
            .select('name')
            .eq('id', recipe['user_id']);
        exploreRecipeList.add(Recipe(
            name: (recipe as Map)['name'],
            id: recipe['id'],
            created_at: recipe['created_at'],
            paws: recipe['paws'],
            description: recipe['description'],
            modified_at: recipe['modified_at'],
            user_id: recipe['user_id'],
            user: userName[0]['name']));
      }
    }
  }

  getProfile() async {
    try {
      userdata = await supabase
          .from('profile')
          .select("name, email, description")
          .match({'id': user?.id}).single();
    } catch (error) {
      print("ERROR = $error");
    }
  }
}
