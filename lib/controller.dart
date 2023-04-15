import 'package:Barfbook/Screens/Barfbook/barfbook_controller.dart';
import 'package:Barfbook/loading.dart';
import 'package:Barfbook/util/Supabase/AuthController.dart';
import 'package:get/get.dart';

class Controller extends GetxController {
  late Map<String, dynamic> userProfile;

  List userScheduleList = [].obs;
  List userRecipeListDB = [];
  List userRecipeList = [].obs;

  List userLikedRecipeDB = [].obs;
  List userLikedRecipeXrefDB = [].obs;
  List userLikedRecipe = [].obs;
  List userFavoriteList = [];

  List databaseRecipeList = [].obs;
  List exploreRecipeList = [].obs;
  List exploreProfileList = [].obs;
  List scheduleEventList = [].obs;

  List userPetListDB = [].obs;
  List userPetList = [].obs;
}
