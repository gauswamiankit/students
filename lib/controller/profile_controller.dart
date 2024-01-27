import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../view/login_screen.dart';
 
class ProfileController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  Future<void> signOut() async {
    await googleSignIn.signOut();
    await auth.signOut();
    Get.offAll(() => LoginScreen());
  }
}
