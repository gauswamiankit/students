import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/mediaQuery.dart';
import '../controller/profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ProfileController profileController = Get.put(
      ProfileController(),
    );
    return GetBuilder<ProfileController>(builder: (profileController) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: SizeConfig.Height * 0.1,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18.0),
                    image: const DecorationImage(
                        image: NetworkImage(
                          "https://images.unsplash.com/photo-1558591710-4b4a1ae0f04d?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                        ),
                        fit: BoxFit.cover,
                        opacity: 20.0),
                  ),
                ),
                Container(
                  height: SizeConfig.Height * 0.1,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 5,
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                      border: Border.all(color: Colors.white, width: 3)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100.0),
                    child: CachedNetworkImage(
                      imageUrl: "${profileController.auth.currentUser!.photoURL}",
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const CircularProgressIndicator(),
                      errorWidget: (context, url, error) => const Icon(Iconsax.user),
                    ),
                  ),
                ),
              ],
            ),
            title(title: "Name", text: "${profileController.auth.currentUser!.displayName}"),
            title(title: "Email ID", text: "${profileController.auth.currentUser!.email}"),
            ElevatedButton(
                    onPressed: () {
                      profileController.signOut();
                    },
                    child: const Text("Logout"))
                .paddingOnly(top: 60.0)
          ],
        ).paddingAll(18.0),
      );
    });
  }
}

Widget title({title, text}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title ?? "",
        style: GoogleFonts.poppins(color: Colors.grey),
      ),
      Text(
        text ?? "",
        style: GoogleFonts.poppins(fontSize: 22.0),
      ),
    ],
  ).paddingOnly(top: 30.0);
}
