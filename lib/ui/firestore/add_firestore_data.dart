import 'package:firebase/utils/utils.dart';
import 'package:firebase/widget/round_button.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddFirestoreDataScreen extends StatefulWidget {
  const AddFirestoreDataScreen({Key? key}) : super(key: key);

  @override
  State<AddFirestoreDataScreen> createState() => _AddFirestoreDataScreen();
}

class _AddFirestoreDataScreen extends State<AddFirestoreDataScreen> {
  bool loading = false;
  final postController = TextEditingController();
  final fireStore = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Firestore posts'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const SizedBox(height: 30),
            TextFormField(
              maxLines: 4,
              controller: postController,
              decoration: const InputDecoration(
                hintText: 'What is in your mind',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),
            RoundButton(
              title: "Add",
              loading: loading,
              onTap: () {
                setState(() {
                  loading = true;
                });
                String id = DateTime.now().millisecondsSinceEpoch.toString();
                fireStore.doc(id).set({
                  'id': id,
                  'title': postController.text.toString(),
                }).then((value) {
                  setState(() {
                    loading = false;
                  });
                  Utils().toastMessage('Post Added');
                }).onError((error, stackTrace) {
                  setState(() {
                    loading = false;
                  });
                  Utils().toastMessage(error.toString());
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
