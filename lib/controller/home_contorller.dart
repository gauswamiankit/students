import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:students/model/student_model.dart';
import 'package:students/utils/mediaQuery.dart';
import 'package:uuid/uuid.dart';

class HomeController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth fireAuth = FirebaseAuth.instance;
  List<StudentModel> studentModel = [];

  @override
  void onInit() {
    super.onInit();
    getStudents();
  }

  addStudent({name, english, math}) async {
    var uid = Uuid().v4();
    var student = await firestore
        .collection("teachers")
        .doc(fireAuth.currentUser!.uid)
        .collection("students")
        .doc(uid);

    final postData = StudentModel(
      id: uid,
      english: english,
      math: math,
      name: name,
      createdAt: "${DateTime.now()}",
    );
    await student.set(postData.toJson());
    update();
    getStudents();
  }

  getStudents() async {
    var snapshot = await firestore
        .collection("teachers")
        .doc(fireAuth.currentUser!.uid)
        .collection("students")
        .orderBy('createdAt', descending: true)
        .get();
    studentModel = snapshot.docs.map((e) => StudentModel.fromJson(e.data())).toList();
    update();
  }

  removeStudent(String studentId) async {
    try {
      await FirebaseFirestore.instance
          .collection("teachers")
          .doc(fireAuth.currentUser!.uid)
          .collection("students")
          .doc(studentId)
          .delete();

      studentModel.removeWhere((student) => student.id == studentId);

      update();
      getStudents();
    } catch (error) {
      print("Error removing student: $error");
    }
  }

  updateStudent({studentId, name, english, math}) async {
    var student = await FirebaseFirestore.instance
        .collection("teachers")
        .doc(fireAuth.currentUser!.uid)
        .collection("students")
        .doc(studentId);

    await student.update({'name': name, 'english': english, 'math': math});

    update();
    getStudents();
  }

  //

  void showUpdateDialog({context, student, isNew}) {
    TextEditingController nameController = TextEditingController(text: isNew ? '' : student.name);
    TextEditingController englishController =
        TextEditingController(text: isNew ? '' : student.english);
    TextEditingController mathController = TextEditingController(text: isNew ? '' : student.math);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(isNew ? 'Add New Student' : 'Update Student'),
          content: Container(
            height: SizeConfig.Height * 0.26,
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: englishController,
                  decoration: InputDecoration(labelText: 'English'),
                ),
                TextField(
                  controller: mathController,
                  decoration: InputDecoration(labelText: 'Math'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                isNew
                    ? addStudent(
                        name: nameController.text,
                        english: englishController.text,
                        math: mathController.text,
                      )
                    : updateStudent(
                        studentId: student.id,
                        name: nameController.text,
                        english: englishController.text,
                        math: mathController.text,
                      );
                Navigator.pop(context);
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }
}
