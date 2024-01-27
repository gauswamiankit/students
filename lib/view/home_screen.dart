import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/home_contorller.dart';
import '../utils/mediaQuery.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.put(
      HomeController(),
    );
    return GetBuilder<HomeController>(
      builder: (homeController) {
        return Scaffold(
          appBar: AppBar(title: const Text('Students'), actions: [
            ElevatedButton(
                    onPressed: () {
                      homeController.showUpdateDialog(context: context, isNew: true);
                    },
                    child: const Text("Add Student"))
                .paddingOnly(right: 18.0),
          ]),
          body: Column(
            children: [
              ListView.builder(
                itemCount: homeController.studentModel.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    padding: const EdgeInsets.fromLTRB(8, 0, 0, 8),
                    margin: const EdgeInsets.only(top: 8, bottom: 8, left: 12.0, right: 12.0),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 0.5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                homeController.studentModel[index].name.toString(),
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                              icon: const Icon(Icons.delete_outline_rounded),
                              onPressed: () {
                                homeController.removeStudent(
                                    homeController.studentModel[index].id.toString());
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.more_vert_rounded),
                              onPressed: () {
                                homeController.showUpdateDialog(
                                    context: context,
                                    student: homeController.studentModel[index],
                                    isNew: false);
                              },
                            )
                          ],
                        ),
                        Container(
                          height: 1,
                          color: Colors.grey,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'English :',
                                      style: GoogleFonts.poppins(color: Colors.grey),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      homeController.studentModel[index].english.toString(),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 1.3,
                                height: SizeConfig.Height * 0.04,
                                color: Colors.grey,
                              ),
                              Expanded(
                                flex: 1,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Math :',
                                      style: GoogleFonts.poppins(color: Colors.grey),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      homeController.studentModel[index].math.toString(),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
