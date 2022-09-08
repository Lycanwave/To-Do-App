import 'package:firebase/ui/posts/posts_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import '../../utils/utils.dart';
import '../../widget/round_button.dart';

class VerifyCodeScreen extends StatefulWidget {
  final String verificationId;

  const VerifyCodeScreen({Key? key, required this.verificationId})
      : super(key: key);

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  bool loading = false;
  final _verificationController = TextEditingController();
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            SizedBox(height: 50),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: _verificationController,
              decoration: InputDecoration(
                hintText: "6-Digit Code",
              ),
            ),
            SizedBox(height: 80),
            RoundButton(
              title: "Verify",
              loading: loading,
              onTap: () async {
                setState(() {
                  loading = true;
                });

                final credential = PhoneAuthProvider.credential(
                  verificationId: widget.verificationId,
                  smsCode: _verificationController.text.toString(),
                );
                try {
                  await auth.signInWithCredential(credential);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PostScreen()));
                  setState(() {
                    loading = false;
                  });
                } catch (e) {
                  Utils().toastMessage(e.toString());
                  setState(() {
                    loading = false;
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
