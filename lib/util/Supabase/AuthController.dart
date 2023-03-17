import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;
final authController = AuthController();

Session? session = supabase.auth.currentSession;
User? user = supabase.auth.currentUser;

class AuthController {
  Future<User?> signUp(String email, String username, String password) async {
    final AuthResponse response = await supabase.auth.signUp(
      email: email,
      password: password,
    );

    session = response.session;
    user = response.user;
  }

  Future<User?> signOut() async {
    await supabase.auth.signOut();
    session = null;
    user = null;
  }
}
