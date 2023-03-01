import 'package:Barfbook/util/Supabase/AuthController.dart';

late Map userdata;

Future<void> getProfile() async {
  try {
    userdata = await supabase
        .from('profile')
        .select('''name, email''')
        .eq('id', user?.id)
        .limit(1)
        .single();
  } catch (error) {
    print(error);
  }
}
