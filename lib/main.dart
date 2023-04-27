// Import required packages and files
import 'package:Barfbook/Screens/Account/Login.dart';
import 'package:Barfbook/controller.dart';
import 'package:Barfbook/loading.dart';
import 'package:Barfbook/util/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Define main function to initialize Supabase and runApp
Future<void> main() async {
  // Initialize Supabase with provided URL and anonymous key
  await Supabase.initialize(
    url: 'https://wokqzyqvqztmyzhhuqqh.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Indva3F6eXF2cXp0bXl6aGh1cXFoIiwicm9sZSI6ImFub24iLCJpYXQiOjE2Nzc0MTAwNjUsImV4cCI6MTk5Mjk4NjA2NX0.Lw1KOvMQsD7mx_NbiXvZ2uxGTX61j_oSS93v_DqTyG0',
  );
  // Ensure Flutter widgets are initialized before running the app
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize date formatting for local language
  initializeDateFormatting().then((_) => runApp(MainApp()));
}

// Define main app widget
class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get instance of controller using GetX package
    final Controller controller = Get.put(Controller());
    // Determine if user is already signed in by checking session and user variables from Supabase
    final session = Supabase.instance.client.auth.currentSession;
    final user = Supabase.instance.client.auth.currentUser;
    // Set theme mode and themes using custom theme file
    return GetMaterialApp(
      themeMode: ThemeMode.system,
      theme: CustomTheme.classicLight,
      darkTheme: CustomTheme.classicDark,
      // Show loading screen if user is signed in or show login screen if not
      home:
          (session != null) || (user != null) ? ScreenLoading() : ScreenLogin(),
    );
  }
}
