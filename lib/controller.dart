import 'package:Barfbook/Screens/Barfbook/barfbook_controller.dart';
import 'package:Barfbook/loading.dart';
import 'package:Barfbook/util/Supabase/AuthController.dart';
import 'package:get/get.dart';

class Controller extends GetxController {
  late Map<String, dynamic> userProfile;

  List userScheduleList = [].obs;
  List userRecipeListDB = [];
  List userRecipeList = [].obs;

  List commentList = [].obs;

  List userLikedRecipeDB = [].obs;
  List userLikedRecipeXrefDB = [].obs;
  List userLikedRecipe = [].obs;
  List userFavoriteList = [];

  List databasePopularRecipeList = [].obs;
  List explorePopularRecipeList = [].obs;

  List databaseNewRecipeList = [].obs;
  List exploreNewRecipeList = [].obs;

  List scheduleRecipeListDB = [].obs;
  List scheduleRecipeList = [].obs;

  List userPetListDB = [].obs;
  List userPetList = [].obs;
}
