import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
  
 import '../controller/login_controller.dart';
import '../utils/mediaQuery.dart';
import 'bottomNav_screen.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.put(
      LoginController(),
    );
    SizeConfig().init(context);

    return GetBuilder<LoginController>(
      builder: (loginController) {
        return Scaffold(
          body: Stack(
            children: [
              Align(
                  alignment: const AlignmentDirectional(0, -1),
                  child: Container(
                    height: SizeConfig.Height * 0.18,
                    width: SizeConfig.Width * 0.6,
                    color: Colors.deepPurple,
                  )),
              Positioned(
                  top: 200,
                  left: -12,
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue,
                    ),
                    height: SizeConfig.Height * 0.24,
                    width: SizeConfig.Width * 0.48,
                  )),
              Positioned(
                  top: 200,
                  right: -12,
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue,
                    ),
                    height: SizeConfig.Height * 0.24,
                    width: SizeConfig.Width * 0.48,
                  )),
              BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100), child: Container()),
              Positioned(
                top: SizeConfig.Height * 0.3,
                left: SizeConfig.Width * 0.1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hey 🙋!!",
                      style: GoogleFonts.poppins(fontSize: 60.0),
                    ),
                    Text(
                      "Welcome ",
                      style: GoogleFonts.poppins(fontSize: 18.0),
                    ).paddingOnly(bottom: 30.0),
                    ElevatedButton(
                      onPressed: () async {
                        User? user = await loginController.signInWithGoogle();
                        if (user != null) {
                          Get.offAll(() => const BottomNavScreen());
                        } else {
                          print("Google sign in failed");
                        }
                      },
                      child: const Text("Let's Continue with Google"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
