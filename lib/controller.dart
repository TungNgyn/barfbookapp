import 'package:Barfbook/Screens/Barfbook/barfbook_controller.dart';
import 'package:Barfbook/loading.dart';
import 'package:Barfbook/util/Supabase/AuthController.dart';
import 'package:get/get.dart';

class Controller extends GetxController {
  List userScheduleList = [].obs;
  List userRecipeList = [].obs;

  List commentList = [].obs;

  List userLikedRecipe = [];

  List explorePopularRecipeList = [];

  List exploreNewRecipeList = [].obs;

  List scheduleRecipeList = [].obs;

  List userPetList = [].obs;
}
